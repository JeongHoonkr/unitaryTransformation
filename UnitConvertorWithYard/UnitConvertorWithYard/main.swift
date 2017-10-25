//
//  main.swift
//  UnitConvertorWithYard
//
//  Created by Choi Jeong Hoon on 2017. 10. 25..
//  Copyright © 2017년 JH Factory. All rights reserved.
//

import Foundation

// 0. lengunit의 구조체 선언
class LengthUnit {
    enum UnitNum: Float {
        case cm = 1, m = 100, inch = 2.54, yard = 91.44
    }
    enum Unittype: String {
        case cm, m, inch, yard
    }
    // unit체크를 위해 배열에 넣음
    let lengthUnitType = [Unittype.cm.rawValue, Unittype.m.rawValue, Unittype.inch.rawValue, Unittype.yard.rawValue]
}

let dicOfLengch: [String: Float] = ["cm": 1, "m": 100, "inch": 2.54, "yard": 91.44]

// 0-1. unittype속성값에 접근하기 위해 LengthUnit의 인스턴스 생성
let lengUnit = LengthUnit()

// 1. 입력받은 값을 배열로 넘기기   ["123cm", "inch"]
func divideStrToArr (_ input: String) -> [String] {
    var initialArray: [String] = []
    let userInput = input
    initialArray = userInput.components(separatedBy: " ")
    return initialArray
}

// 2. 지원되는 단위인지 체크하기
func unitCheck (_ input: [String]) -> Bool {
    let array = input
    var hasUnit: Bool = false
    for i in dicOfLengch.keys {
        if array[0].hasSuffix(i) {
            hasUnit = true
            break
        } else {
            hasUnit = false
        }
    }
    return hasUnit
}

// 3. 첫단위 쪼개기
func findUnit (_ strArray: [String]) -> String {
    var from: String = ""
    for i in dicOfLengch.keys {
        if strArray[0].hasSuffix(i) {
            from += i
            return from
        }
    }
    return from
}

// 4. 기본단위인지 아닌지 판단하는 enum
enum BaseUnit {
    case base, upper }

// 부피와 무게가 추가된다면 enum을 활용해서 각 값들을 배열에 넣을 것인지, 딕셔너리로 선회할것인지 고민해보기
// 5. 단위가 Length의 기본단위인지 아닌지 판단하는 함수
func isBaseUnit (_ input: String) -> BaseUnit {
    var result: BaseUnit
    if input == LengthUnit.Unittype.cm.rawValue {
        result = BaseUnit.base
    } else {
        result = BaseUnit.upper
    }
    return result
}

// 이것도 함수 2개로 쪼갤 수 있을것 같다. 해보자
// 6. 배열을 스트링으로 나누기 <배열 길이에 따라 분기>
func devideArrToStr (_ input: [String]) -> (String, String, String) {
    var (from, num, to) = ("", "", "")
    if input.count == 2 {
        from = findUnit(input)
        let frontString = input[0]
        num += frontString.prefix(frontString.count - from.count)
        to = input[1]
    } else if input.count == 1 {
        from = findUnit(input)
        let frontString = input[0]
        num += frontString.prefix(frontString.count - from.count)
        
        switch from {
        case LengthUnit.Unittype.cm.rawValue : to = LengthUnit.Unittype.m.rawValue
        case LengthUnit.Unittype.m.rawValue : to = LengthUnit.Unittype.cm.rawValue
        default : (from, to) = ("", "")
        }
    }
    return (from, to, num)
}

// enum으로 돌려보려고 했으나 실패 : enum으로 어떻게 활용할 수 있을까
// 7. 스트링으로 변환된 단위에 맞는, 기본값을 반환하는 함수
func checkTypeOfUnit (fromS: String, toS: String) -> (from: Float, to: Float) {
    var from: Float = 0.0
    var to: Float = 0.0
    for (key, value) in dicOfLengch {
        if fromS == key { from = value }
        if toS == key { to = value }
    }
    return (from, to)
}

// 8. 연산하는 함수
func convertToUnit(num input: Float, from fromUnit: Float, to toUnit: Float, isbaseUnit: BaseUnit) -> Float{
    var result: Float = 0.0
    if isbaseUnit == BaseUnit.base {
        result += input/toUnit
    } else if isbaseUnit == BaseUnit.upper {
        result = (input * fromUnit)/toUnit
    }
    return result
}

// 9. 결과값에 목표단위 붙히는 함수
func addUnitAtResult (_ resultNum: Float, toU toUnit: String) -> String {
    var result: String = ""
    result += "\(String(resultNum) + toUnit)"
    return result
}

// 10. 모든 함수를 호출하여 값을 반환하는 함수
func excuteConverting (_ userInput: String?) -> String {
    guard let userInput = userInput else { return "" }
    var hasUnit: Bool = false
    var almostResult: Float = 0.0
    var result: String = "변환된 값 -> "
    let divide = divideStrToArr(userInput)
    hasUnit = unitCheck(divide)
    if hasUnit == true {
        let (from, to, num) = devideArrToStr(divide)
        let (reFromN, reToN) = checkTypeOfUnit(fromS: from, toS: to)
        almostResult = convertToUnit(num: Float(num) ?? 0.0, from: reFromN, to: reToN, isbaseUnit: isBaseUnit(from))
        result += addUnitAtResult(almostResult, toU: to)
    } else {
        result += ("지원하지 않는 단위입니다.")
    }
    return result
}

// 11. 출력
func printResult (_ result: String) {
    print(result)
}

// 12. 프로그램 구현부
unitConvertLoop : while true {
    print ("변환하고 싶은 단위를 입력해주세요.")
    let userInput = readLine()
    if userInput == "q" || userInput == "quit"
    { print ("프로그램이 종료됩니다."); break }
    printResult(excuteConverting(userInput))
    print("------------------\n")
}


/*
 switch convertWise {
 case .toLower: result = input * unit.rawValue
 case .toUpper: result = input / unit.rawValue
 }
 */
