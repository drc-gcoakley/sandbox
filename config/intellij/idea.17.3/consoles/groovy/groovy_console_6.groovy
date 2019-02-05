@Grab('org.apache.commons:commons-csv:1.2')
import java.nio.file.Paths
import java.nio.charset.*
import groovy.xml.*
import org.apache.commons.csv.CSVParser
import static org.apache.commons.csv.CSVFormat.*
import static groovy.io.FileType.FILES
import com.datarecognitioncorp.iat.domain.*
import com.datarecognitioncorp.iat.type.*

/**
 * Read through input files for LA and add items to IAT.
 * First add images.
 * Then add Passages.
 * Then add items.
 */


mathBaseDir = "C:/iat/la_input_files/Math Content/Math/extracted/"
mathSingleDir = "C:/iat/la_input_files/Math Content/Math/extracted/Math_Gr01_MC_01_of_01-20160526-114430/"
mathCsvFile = "C:/iat/la_input_files/Math Content/EAGLE item_metadata_FINAL_053116_math_export.csv"

metadatas = parseItemMetadatasFromCSV(mathCsvFile)
passages = processPassageFiles(new File(mathSingleDir), metadatas)
saveObjectsToDb(passages, "passage")

//processSubject(mathBaseDir, mathCsvFile)
//processSingleForTest()

// process all the directories in a single subject in a batch
def processSubject(gradeDirBase, csvFile) {
    gradeDirs = collectGradeDirsForSubject(gradeDirBase)
    metadatas = parseItemMetadatasFromCSV(csvFile)
    gradeDirs.each { dir ->
        println "PROCESSING ${dir.getName()}"
        items = processItemFiles(dir, metadatas)
    }
}

def processItemFiles(targetDir, metadatas) {
    List itemFiles = collectItemFilesFromDir(targetDir,"xml")
    println "there are ${itemFiles.size} files to process"
    List items = parseItemsFromFiles(itemFiles, metadatas)
    println "created ${items.size} items from files"
    return items;
}

def processPassageFiles(targetDir, metadatas) {
    List passageFiles = collectPassageFilesFromDir(targetDir,"xml")
    println "there are ${passageFiles.size} passage files to process"
    List passages = parsePassagesFromFiles(passageFiles, metadatas)
    println "created ${passages.size} passages from files"
    return passages;
}

def parsePassagesFromFiles(files, metadatas) {
    List passages = []
    files.each { file ->
        try {
            passage = parsePassageFromFile(file, metadatas)
            if (passage != null) {
                passages << passage
            } else {
                println "not adding null item"
            }
        } catch (all) {
            println "Error caught parsing item from ${file.name}"
            println "${all.getMessage()}"
            all.printStackTrace()
        }
    }
    return passages
}

def parseItemsFromFiles(files, metadatas) {
    List items = []
    files.each { file ->
        try {
            item = parseItemFromFile(file, metadatas)
            if (item != null) {
                items << item
            } else {
                println "not adding null item"
            }
        } catch (all) {
            println "Error caught parsing item from ${file.name}"
            println "${all.getMessage()}"
            all.printStackTrace()
        }
    }
    return items
}


def collectGradeDirsForSubject(baseGradeDirPath) {
    gradeDirList = []
    baseGradeDir = new File(baseGradeDirPath)
    baseGradeDir.eachDir { dir ->
        gradeDirList << dir
    }
    return gradeDirList
}

def collectPassageFilesFromDir(targetDir, fileType) {
    def List passageFileList = []
    targetDir.eachFile (FILES) { file ->
        filename = file.name.toLowerCase()
        if(filename.startsWith("p")) {
            passageFileList << file
        }
    }
    return passageFileList
}

def collectItemFilesFromDir(targetDir, fileType) {
    def List itemFileList = []
    targetDir.eachFile (FILES) { file ->
        filename = file.name.toLowerCase()
        if(filename.endsWith(fileType) && !filename.startsWith("p") &&
                ! filename.contains("assessment") && ! filename.contains("manifest") &&
                filename.contains("_mc")) {
            itemFileList << file
        }
    }
    return itemFileList
}

// parse out the item body contents for the prompt, but remove the choiceInteraction portion to return
//  separately. return [body, choices]
def splitBodyAndChoices(file) {
    def assItem = new XmlParser().parse(file)
    def bodyNode = assItem.itemBody.get(0)
    def choicesNode
    assItem.depthFirst().each { node ->
        if (node instanceof Node) {
            name = node.name().getLocalPart()
            if (name == "choiceInteraction") {
                choicesNode = node
            }
        }
    }
    choicesParent = choicesNode.parent()
    choicesParent.remove(choicesNode)

    bodyText = writeNodeToString(bodyNode.children().get(0))
    choiceText = writeNodeToString(choicesNode)

    return [bodyText, choiceText]
}

def writeNodeToString(node) {
    sw = new StringWriter()
    nodePrinter = new XmlNodePrinter(new PrintWriter(sw))
    nodePrinter.setNamespaceAware(false)
    nodePrinter.print(node)
    text = sw.toString()
}

def parsePassageFromFile(file, metadatas) {
    root = new XmlParser().parse(file)
    text = writeNodeToString(root.div[0].div[0]);
    passageTitle = file.getName()
    passage = new Passage(
            identifier: passageTitle,
            title: passageTitle,
            text: text,
            programCode: 1,
            source: ItemSourceType.BULK,
            itemType : ItemType.MC
    )
    return passage
}

def parseItemFromFile(file, metadatas) {
    bodyAndChoices = splitBodyAndChoices(file)

    assessmentItem = new XmlParser().parse(file)
    correctResponse = assessmentItem.responseDeclaration.correctResponse.value.text()
    identifier = assessmentItem.@identifier
    metadata = metadatas[identifier]
    if (! metadata) {
        println("no metadata for id == ${identifier}")
        return null
    }

    prompt = bodyAndChoices[0]
    choices = new XmlParser().parseText(bodyAndChoices[1]).simpleChoice

    List options = new ArrayList()
    choices.each { choice ->
        options << writeNodeToString(choice.children().get(0))
    }

    item = new Item(
            source: ItemSourceType.BULK,
            itemType : ItemType.MC,
            points : metadata.points,
            programCode: 1,
            subject: metadata.contentArea,
            difficulty: metadata.difficulty,
            identifier: identifier,
            key: correctResponse,
            prompt: prompt,
            options : options,
            grade: metadata.grade,
            depthOfKnowledge: metadata.dok
    )
    return item
}



class ItemMetadata {
    String id, description, correct, contentArea, primaryAlignment, secondaryAlignment, subType
    int difficulty, grade, points, dok
}

def parseItemMetadatasFromCSV(file) {
    metadatas = [:]
    CharsetDecoder decoder = Charset.forName("UTF-8").newDecoder();
    decoder.onMalformedInput(CodingErrorAction.REPORT);

    input = new FileInputStream(new File(file))
    InputStreamReader  isr = new InputStreamReader(input, decoder)
    i = 1
    isr.withReader { reader ->
        CSVParser parser = new CSVParser(reader, DEFAULT.withHeader())
        parser.iterator().each { record ->
            grade = record.grade

            metadata =
                    ([ id: record.i_external_id,
                       description: record.i_description,
                       correct: record.i_correct_response,
                       contentArea: record.content_area,
                       primaryAlignment: record.primary_alignment,
                       secondaryAlignment: record.secondary_alignments,
                       subType: record.i_subtype,
                       difficulty: record.i_difficulty,
                       grade: Integer.parseInt(record.grade),
                       points: record.points,
                       dok: record.dok?: 0
                    ] as ItemMetadata)
            if (metadata.id == null) {
                println "grade is ${record.grade}"
                println "bad metadata! ${record.i_external_id}"
                throw new IOException()
            }
            metadatas.put(metadata.id, metadata)
        }
    }
    println "Got ${metadatas.size()} metadatas from file"
    return metadatas
}

def saveObjectsToDb(objects, objectType) {
    println "Attempting to save ${objects.size()} ${objectType}s to DB..."

    savedCount = 0
    // save them to mongo
    objects.each { object ->
        try {
            object.save(flush: true, failOnError: true)
            savedCount++
        } catch (all) {
            println "Error saving ${objectType} : {object.identifier}"
            println "Message : ${all.getMessage()}"
        }
    }

    println "Saved ${savedCount} ${objectType}s"
}

"done"








