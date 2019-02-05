array = ["one", "two", "three"]
println array[1..-1]

myList = new ArrayList<String>()
myList.addAll(["four", "five", "six"])
println myList[1]
for (i in array) {
    myList << i
}
println myList

slashy = /"directory" == c:\temp\files\this.txt/
println slashy

class MyClass {
    int i = 0

    def plus(op) {
        i = i+ op
    }
    def multiply(op) {
        i = i * op
    }
    def leftShift(op) {
        i = Integer.parseInt("" + i + op)
    }
    def print() {
        println "my value is now ${i}"
    }
}

mine = new MyClass()
mine + 5
mine * 2
mine.print()
mine << 55
mine.print()