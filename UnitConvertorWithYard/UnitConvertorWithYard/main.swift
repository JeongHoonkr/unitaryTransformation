//
//  main.swift
//  UnitConvertorWithYard
//
//  Created by Choi Jeong Hoon on 2017. 10. 25..
//  Copyright © 2017년 JH Factory. All rights reserved.
//

import Foundation

// 0. 단위이름만을 위한 구조체 선언
struct UnitsTypeOnly {
    enum Length: String { case cm, m, inch, yard }
    static let lengthUnitName = [Length.cm.rawValue, Length.m.rawValue, Length.inch.rawValue, Length.yard.rawValue]
    enum Weight: String { case g, kg, oz, lb }
    static let weightUnitName = [Weight.g.rawValue, Weight.kg.rawValue, Weight.oz.rawValue]
    enum Volume: String { case l, gal, pt, qt }
    static let volumeUnitName = [Volume.l.rawValue, Volume.gal.rawValue, Volume.pt.rawValue, Volume.qt.rawValue]
}

// 0.1 루프를 돌리기 위해 단위를 딕셔너리로 선언
struct UnitsTypeAndValue {
    typealias DictionaryType = [String: Float]
    static let length: DictionaryType = ["cm": 1, "m": 100, "inch": 2.54, "yard": 91.44]
    static let weight: DictionaryType = ["g": 1, "kg": 1000, "oz": 28.34, "lb": 435.59]
    static let volume: DictionaryType = ["l": 1, "gal": 3.785, "pt": 0.473, "qt": 0.946]
}

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
    for i in UnitsTypeAndValue.length.keys {
        switch array.count {
        case 2 :
            if array[0].hasSuffix(i) || array[1].hasSuffix(i)
            { hasUnit = true; break }
        case 1 :
            if array[0].hasSuffix(i)
            { hasUnit = true; break }
        default :
            hasUnit = false
        }
    }
    return hasUnit
}

// 3. 첫단위 쪼개기
func findUnit (_ strArray: [String]) -> String {
    var from: String = ""
    for i in UnitsTypeAndValue.length.keys {
        if strArray[0].hasSuffix(i) {
            from += i
            return from
        }
    }
    return from
}

// 4. 기본단위인지 아닌지 판단하는 enum
enum BaseUnit { case base, upper }

// 5. 단위가 Length의 기본단위인지 아닌지 판단하는 함수 : <연산함수를 간소화하는 과정에서 연산대상을 구분짓는 기준이 필요했다?
func checkBaseUnitofUnit (_ input: String) -> BaseUnit {
    var result: BaseUnit
    if input == UnitsTypeOnly.Length.cm.rawValue {
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
        case UnitsTypeOnly.Length.cm.rawValue : to = UnitsTypeOnly.Length.m.rawValue
        case UnitsTypeOnly.Length.m.rawValue : to = UnitsTypeOnly.Length.cm.rawValue
        default : (from, to) = ("0", "0")
        }
    }
    return (from, to, num)
}

// enum으로 돌려보려고 했으나 실패 : enum으로 어떻게 활용할 수 있을까
// 7. 스트링으로 변환된 단위에 맞는, 기본값을 반환하는 함수
func returnValueOfUnit (fromS: String, toS: String) -> (from: Float, to: Float) {
    var from: Float = 0.0
    var to: Float = 0.0
    for (key, value) in UnitsTypeAndValue.length {
        if fromS == key { from = value }
        if toS == key { to = value }
    }
    return (from, to)
}

// 8. 연산하는 함수
func convertUnit(num input: Float, from fromUnit: Float, to toUnit: Float, isBaseUnit: BaseUnit) -> Float{
    var result: Float = 0.0
    if isBaseUnit == BaseUnit.base {
        result += input/toUnit
    } else if isBaseUnit == BaseUnit.upper {
        result = (input * fromUnit)/toUnit
    }
    return result
}

// 9. 결과값에 목표단위 붙히는 함수
func addUnitAtResult (_ resultNum: Float, toU toUnit: String) -> String {
    var result: String = ""
    result += "\(String(resultNum) + " " + toUnit)"
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
        let (reFromN, reToN) = returnValueOfUnit(fromS: from, toS: to)
        almostResult = convertUnit(num: Float(num) ?? 0.0, from: reFromN, to: reToN, isBaseUnit: checkBaseUnitofUnit(from))
        result += addUnitAtResult(almostResult, toU: to)
    } else {
        result += ("지원하지 않는 단위입니다.")
    }
    return result
}

// 11. 출력
func printResult (_ result: String) { print(result) }

// 12. 프로그램 구현부
unitConvertLoop : while true {
    print ("변환하고 싶은 단위를 입력해주세요.")
    let userInput = readLine()
    if userInput == "q" || userInput == "quit"
    { print ("프로그램이 종료됩니다."); break }
    printResult(excuteConverting(userInput))
    print("------------------\n")
}
