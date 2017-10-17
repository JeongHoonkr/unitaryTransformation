//: Playground - noun: a place where people can play

import UIKit


// 길이 변환 및 출력
/*
 * 요구사항
 github 저장소를 만들고 새로운 Playground를 생성해서 저장소에 연결한다.
 다음의 센티미터(cm) 단위 값을 미터(m) 단위로 변환해 결과 화면에 출력한다.
 예를 들어 "120cm"을 "1.2m"로 출력한다.
 미터(m) 단위 값을 센티미터(cm) 단위로 변환해 결과 화면에 출력한다.
 "1.86m"를 "186cm"로 출력한다.
 로그래밍 길이 변환" 혹은 "프로그래밍 단위 변환" 같은 키워드로 검색하고 변환(계산) 방법을 찾아 구현한다.
 */

// 120cm


func unitChange(inputType: String, outputType: String, inputValue: Double) -> String {
    
    var returnValue: String = ""
    if inputType == "cm" &&  outputType == "m" {
        returnValue = String(inputValue / 100) + outputType
    } else if inputType == "m" &&  outputType == "cm" {
        returnValue = String(inputValue * 100) + outputType
    } else {
        returnValue += "올바른 타입과 숫자를 입력해주세요"
    }
    return returnValue
}
print(unitChange(inputType: "cm", outputType: "m", inputValue: 123))
print(unitChange(inputType: "ㅗㅓ", outputType: "cm", inputValue: 1.2))


var str = "123cm"

if str.contains("cm") {
    var unit = str.substring(from: str.index(str.endIndex, offsetBy: -2))
    var number = str.substring(to: str.index(str.startIndex, offsetBy: 3))
    print ("\((Double(number))!/100)m")
}

