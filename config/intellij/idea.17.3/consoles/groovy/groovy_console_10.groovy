import groovy.json.*

extractedImageDir = "c:/iat/la_input_files/images/"
imageMapFilePath = "c:/iat/la_input_files/laImageNameMap.json"

class Globals {
    static int counter = 0
    // map to hold all renamed images. 'Duplicate' images will have a 'duplicateX_' prefix
    //   added to them since windows is case-insensitive for file names, but not zip file entries
    static Map itemNameMap = [:]
    static int dupctr = 0
}

// process all directories for math ela and science
def zipPath = ["c:/iat/la_input_files/Original_Zipped/Math Content/Math/"
               ,"c:/iat/la_input_files/Original_Zipped/ELA Content/ELA/"
               ,"c:/iat/la_input_files/Original_Zipped/Science Content/Science/"
               ,"c:/iat/la_input_files/Original_Zipped/Social Studies Content/High School/"
]

zipPath.each {
    def zipDir = new File(it)
    zipDir.traverse {
        if (it.name.endsWith(".zip")) {
            if ( (it.name.contains("_Misc_")) || (it.name.contains("_MC_")) || (it.name.contains("ELA_")) || (it.name.contains("_CR_")) )
                println it.name
            createImagesUnzipped(it)
        }
    }
}

convertFilesToSupportedFormats();

def json = JsonOutput.toJson(Globals.itemNameMap)
File imageMapFile = new File(imageMapFilePath)
imageMapFile.write JsonOutput.prettyPrint(json)

println "DUP COUNTER: ${Globals.dupctr}"
println "COUNTER: ${Globals.counter}"
println " ,-----.                        ,--.         ,--.          "
println "'  .--./ ,---. ,--,--,--. ,---. |  | ,---. ,-'  '-. ,---.  "
println "|  |    | .-. ||        || .-. ||  || .-. :'-.  .-'| .-. : "
println "'  '--'\\' '-' '|  |  |  || '-' '|  |\\   --.  |  |  \\   --. "
println " `-----' `---' `--`--`--'|  |-' `--' `----'  `--'   `----' "
println "                         `--'                             "

return 0


def int createImagesUnzipped(File zipFile) {
    println "opening zip file ${zipFile}"
    def zf = new java.util.zip.ZipFile(zipFile)
    zf.entries().findAll { !it.directory }.each {
        def tokens = zipFile.name.tokenize('_')
        def prefix4 = tokens[0] + "_" +  tokens[1] + "_" +  tokens[2] + "_" +  tokens[3] + "_"
        if (it.toString().startsWith("images")) {
            Globals.counter++
            def origName = "/images/" + prefix4 + it.name.substring(it.name.lastIndexOf("/")+1,it.name.length())
            def newname = prefix4 + it.name.substring(it.name.lastIndexOf("/")+1,it.name.length()).toLowerCase()

            File file = new File(extractedImageDir + newname)
            if (file.exists()) {
                println "DUPLICATE ..............................................................  ${newname}"
                def unique = false
                index = 1
                while (!unique) {
                    newname = prefix4 + "duplicate" + index + "_" + it.name.substring(it.name.lastIndexOf("/")+1,it.name.length()).toLowerCase()
                    file = new File(extractedImageDir + newname)
                    if (!file.exists()) {
                        println "DUPLICATE RENAMED..............................................................  ${newname}"
                        unique = true
                        Globals.dupctr++
                        if(Globals.itemNameMap[origName]) {
                            println    "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        DUPLICATE in MAP %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ${origName}"
                        }
                    } else {
                        index++
                    }
                }
            }
            file.append(zf.getInputStream(it))
            Globals.itemNameMap.put(origName,newname)
        }
    }
    return 0
}

// now lets convert the SVG's to PNG's by issuing a system command to run the utility "magick" against them.  Cannot
// delete the .SVG as the commmands get queued up and need the .svg image there for when they run.  It takes a minute or
// so after completion before all the commands fully process.
def convertFilesToSupportedFormats() {
    print "converting"
    i = 0
    Globals.itemNameMap.keySet().each { origName ->
        if (origName.contains(".svg") || origName.contains(".jpg")) {
            copiedFile = Globals.itemNameMap[origName];
            newName = convertFileToPng(copiedFile, extractedImageDir)
            Globals.itemNameMap[origName] = newName
            i++
            if (i % 100 == 0) {
                println "images converted : ${i}"
            }
        }
    }
    println "."
    new File(extractedImageDir).eachFile {
        if (it.getName().contains(".svg") || it.getName().contains("jpg")) {
            it.delete();
        }
    }
}

def convertFileToPng(fileName,imagePath) {
    def newName = fileName.substring(0,fileName.size()-3) + "png"
    command = "magick ${imagePath}" + fileName + " ${imagePath}" + newName
    sleep(20)
    print "."
    command.execute()
    return newName
}

