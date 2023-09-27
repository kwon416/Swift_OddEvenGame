import UIKit
/*
    변수 var
    상수 let
 */

var greeting = "Hello, playground"

var name: String = "Atlas"
var age: Int = 25

name
name = "아틀라스"

age
age = 30

let one: Int = 1
let two: Int = 2

/*
    func 함수명(파라메터 이름: 데이터타입) -> 리턴타입 {
    return 반환값
 }
 */
func sayHello(name: String) -> String {
    return "Nice to meet you, \(name)"
}

sayHello(name: name)

func introiduce(name: String, age: Int) -> String {
    return "Hi, My name is \(name), I'm \(age)"
}

introiduce(name: name, age: age)

func add(a: Int, b: Int) -> Int {
    return a + b
}

add(a: 1, b: 2)



var isChecked: Bool = false
isChecked = true

let color: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
print(color)
print(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
type(of: color)

switch color {
case UIColor.white:
    print("흰색입니다")
case #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1):
    print("colorLiteral 1111입니다")
default:
    print("비교할 수 있는 색상이 없습니다")
    
}

func getName(name: String?) -> String {
    guard let uName = name else {
        return "이름값이 존재하지 않습니다."
    }
    return uName
}
getName(name: "아틀라스")
getName(name: nil)

