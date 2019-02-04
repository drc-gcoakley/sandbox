

def json = """{"TestSessions": []}"""
def handScoringStatusJSON = new JsonSlurper().parseText(jsonText)
def statuses = handScoringStatusJSON.get("TestSessions")
if (statuses.size() > 0) {
    println "OK"
} else {
    println "NOT OK"
}
