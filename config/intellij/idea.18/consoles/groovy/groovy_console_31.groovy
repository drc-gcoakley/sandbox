import groovy.json.JsonSlurper

String input = """{"ItemId":547736}"""
def output = new JsonSlurper().parseText(input).ItemId
println "output : ${output}"