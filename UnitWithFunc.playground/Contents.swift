//: Playground - noun: a place where people can play

import UIKit
var str = "Hello, playground"


/*
 학습 목표
 
 변수와 상수에 값을 저장하는 방식을 경험한다.
 숫자와 문자열을 다루는 데이터 타입을 구분해서 응용한다.
 정해진 역할을 담당하는 함수를 만든다.
 요구사항
 
 센티미터 단위 값을 변수에 저장하고 변환하는 데 사용한다.
 센티미터 단위 값을 저장한 변수를 미터 단위 값으로 변환한 후 변수에 저장하고 저정한 변수 값을 출력한다.
 길이 단위를 바꿀 때 곱하거나 나누는 값은 바뀌지 않는 값이다. 따라서 상수 값으로 지정해서 프로그램을 구현한다.
 문자열로 값 뒤에 붙어있는 단위에 따라 길이를 변환해서 결과를 출력하는 함수를 만든다.
 예를 들어 "183cm"처럼 숫자 다음에 cm가 붙어있으면 센티미터 값을 미터로 변환하고 출력한다. "3.14m"처럼 숫자 다음에 m가 붙어있으면 미터 값을 센티미터로 변환하고 출력한다.
 */

// 센티를 미터로 바꾸는 함수


// cenit를 meter로 숫자만 바꾸기 : trimmingCharacters사용
func cmToM (_ input: String) -> Double {
    var num: Double = 0.0
    num += Double(input.trimmingCharacters(in: ["c","m"]))!
    return num
}

// nil coalesning 사용
func meterToCenti (_ input: String) -> Double {
    var num: Double = 0.0
    let firstCharOfUnit = input.index(of: "m") ?? input.endIndex
    let justNum = input[..<firstCharOfUnit]
    num = (Double(justNum)!/100)
    return num
}

// meter를 meter로 숫자만 바꾸기 : trimmingCharacters사용
func unitCovertMToCm (_ input: String) -> Double {
    var num: Double = 0.0
    num += Double(input.trimmingCharacters(in: ["m"]))!
    return num
}

// centi를 미터로 바꾸기 : prefix upto와 index사용
func unitCovertCentiToM (_ input: String) -> Double {
    var num: Double = 0.0
    num += Double(input.prefix(upTo: input.index(before: input.index(of: "m")!)))!
    return num
}


// 변환된 문자를 단위변환함수 호출하여 출력
func printNumString (_ input: String) -> String {
    var result: String = ""
    if input.contains("cm") {
        result += String(unitCovertCentiToM(input) / 100) + "m"
    } else {
        result += String(unitCovertMToCm(input) * 100) + "cm"
    }
    return result
}

// 스트링에서 숫자로 형변
printNumString("1m")
printNumString("145cm")


struct Unit {
    let centi: String = "Centi"
    var meter: String
}

