int i = 0
File output = new File("C:/git/iat/mongoqueries/new_la_domain_updates.txt");
new File("c:/git/iat/mongoqueries/new_la_domains.txt").eachLine { line ->
    def splits = line.tokenize('.')
    println "splits = ${splits} ${splits.size()}"
    if (splits.size() > 4) {
        update = '''db.program.update(   { code: '1' },   {     $push: {  domains:  {  \"key\" : \"REPLACE_ME\", \"value\" : \"\"}} })\n'''.replace("REPLACE_ME", line)
        println update
        output << update
        i++
    } else {
    }
}

