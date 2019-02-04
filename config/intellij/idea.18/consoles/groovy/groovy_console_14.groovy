new File("c:/git/iat/mongoqueries/new_la_domains.txt").eachLine { line ->
    if (line.split().length > 4) {
        println "skipping ${line}"
    }
    updateStmt = '''db.program.update(   { code: '1' },   {     $push: {  domains:  {  "key" : "REPLACE_ME", "value" : ""}} })'''
    updateStmt = updateStmt.replace("REPLACE_ME", line)
    println updateStmt
}
