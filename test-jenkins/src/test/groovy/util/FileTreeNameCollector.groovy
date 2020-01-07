package util

import groovy.io.FileType

class FileTreeNameCollector {

    static collectFrom(String directory, FileType whichOnes = FileType.ANY, Closure filter = {}) {
        def dir = new File(directory)
        def files = []
        dir.eachFile(whichOnes) {
            files << it.name
        }
        return files.findAll(filter)
    }
}
