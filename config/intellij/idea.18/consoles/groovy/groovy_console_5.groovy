import static groovy.io.FileType.FILES
import com.datarecognitioncorp.iat.domain.*

/**
 * Read through input files for LA and add items to IAT.
 * First add images.
 * Then add Passages.
 * Then add items.
 */

targetDir = "C:/iat/la_input_files/Math Content/Math/extracted/Math_Gr01_MC_01_of_01-20160526-114430"
List itemFiles = collectFilesFromDir(targetDir,"xml")
println "collected $itemFiles.size item xml files from directory $targetDir"

itemFiles.each {
    parseItemFromFile(it)
}

def collectFilesFromDir(targetDirPath, fileType) {
    def List itemFileList = []
    targetDir = new File(targetDirPath)
    targetDir.eachFileRecurse (FILES) { file ->
        if((file.name.toLowerCase()).endsWith(fileType)){
            itemFileList << file
        }
    }
    return itemFileList
}

def parseItemFromFile(file) {
    assessmentItem = new XmlSlurper().parse(file)
    correctResponse = assessmentItem.responseDeclaration.correctResponse.value
    println correctResponse

//    Item item = new Item(
//            key: assessmentItem.responseDeclaration.correctResponse.value
//    )
//    println item.key

//    return item
}







