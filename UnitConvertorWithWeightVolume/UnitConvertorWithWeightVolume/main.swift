//
//  main.swift
//  UnitConvertorWithYard
//
//  Created by Choi Jeong Hoon on 2017. 10. 25..
//  Copyright © 2017년 JH Factory. All rights reserved.
//

import Foundation

// 0. 단위이름 체크를 위한 구조체 선언
struct UnitsName {
    enum Length: String { case cm, m, inch, yard }
    static let length = [Length.cm.rawValue, Length.m.rawValue, Length.inch.rawValue, Length.yard.rawValue]
    
    enum Weight: String { case g, kg, oz, lb }
    static let weight = [Weight.g.rawValue, Weight.kg.rawValue, Weight.oz.rawValue, Weight.lb.rawValue]
    
    enum Volume: String { case l, gal, pt, qt }
    static let volume = [Volume.l.rawValue, Volume.gal.rawValue, Volume.pt.rawValue, Volume.qt.rawValue]
}

// 0.1 루프를 돌리기 위해 단위를 딕셔너리로 선언
struct UnitsTypeAndValue {
    typealias StringVersusFloat = [String: Float]
    static let length: StringVersusFloat = ["cm": 1, "m": 100, "inch": 2.54, "yard": 91.44]
    static let weight: StringVersusFloat = ["g": 1, "kg": 1000, "oz": 28.3495, "lb": 453.592]
    static let volume: StringVersusFloat = ["L": 1, "pt": 0.473176, "qt": 0.946353, "gal": 3.78541]
}

// 1. 입력받은 값을 배열로 넘기기
func divideStringtoArray (_ input: String) -> [String] {
    var temp: [String] = []
    let userInput = input
    temp = userInput.components(separatedBy: " ")
    return temp
}



// 2. 지원되는 단위인지 체크하기
func checkUnit (_ input: [String]) -> Bool {
    let array = input
    var hasUnit: Bool = false
    let unitNamesArray = [UnitsTypeAndValue.length.keys, UnitsTypeAndValue.volume.keys, UnitsTypeAndValue.weight.keys]
    for unitName in unitNamesArray {
        for eachUnit in unitName {
            switch array.count {
            case 1... :
                if array[0].hasSuffix(eachUnit)
                { hasUnit = true; break }
            default : hasUnit = false
            }
        }
    }
    return hasUnit
}

// 3. 첫단위 쪼개기
func findUnit (_ strArray: [String]) -> String {
    var from: String = ""
    let unitNamesAssortment = [UnitsTypeAndValue.length.keys, UnitsTypeAndValue.volume.keys, UnitsTypeAndValue.weight.keys]
    for unitNames in unitNamesAssortment {
        for unitName in unitNames {
            if strArray[0].contains(unitName) {
                from = unitName
                return from }
        }
    }
    return from
}

// 4. 기본단위인지 아닌지 판단하는 enum
enum BaseUnit { case base, upper }

// 5. 단위가 Length의 기본단위인지 아닌지 판단하는 함수 : <연산함수를 간소화하는 과정에서 연산대상을 구분짓는 기준이 필요했다?
func checkBaseUnitofUnit (_ input: String) -> BaseUnit {
    var result: BaseUnit
    switch input {
    case UnitsName.Length.cm.rawValue : result = BaseUnit.base
    case UnitsName.Weight.g.rawValue : result = BaseUnit.base
    case UnitsName.Volume.l.rawValue : result = BaseUnit.base
    default : result = BaseUnit.upper
    }
    return result
}

// 이것도 함수 2개로 쪼갤 수 있을것 같다. 해보자
// 6. 배열을 스트링으로 나누기 <배열 길이에 따라 분기>    : 현재 이곳이 문제고, 여길 잘 해야 예외사항 처리 가능할듯
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
        case UnitsName.Length.cm.rawValue : to = UnitsName.Length.m.rawValue
        case UnitsName.Length.m.rawValue : to = UnitsName.Length.cm.rawValue
        default : (from, to) = ("0", "0")
        }
    }
    return (from, to, num)
}

// enum으로 돌려보려고 했으나 실패 : enum으로 어떻게 활용할 수 있을까
// 7. 스트링으로 변환된 단위에 맞는, 기본값을 반환하는 함수
func returnValueOfUnit (fromS: String, toS: String) -> (from: Float, to: Float) {
    var (from, to): (Float, Float) = (0, 0)
    let units = [UnitsTypeAndValue.length, UnitsTypeAndValue.volume, UnitsTypeAndValue.weight]
    for unitDictionary in units {
        for (key, value) in unitDictionary {
            if fromS == key { from = value }
            if toS == key { to = value }
        }
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

// 9. 모든 함수를 호출하여 값을 반환하는 함수
func excuteConverting (_ userInput: String?) -> String {
    guard let userInput = userInput else { return "" }
    var hasUnit: Bool = false
    var almostResult: Float = 0.0
    var result: String = "변환된 값 -> "
    let divide = divideStringtoArray(userInput)
    
    hasUnit = checkUnit(divide)
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

// 10. 결과값에 목표단위 붙히는 함수
func addUnitAtResult (_ resultNum: Float, toU toUnit: String) -> String {
    var result: String = ""
    result += "\(String(resultNum) + " " + toUnit)"
    return result
}


// 11. 출력
func printResult (_ result: String) { print(result) }

// 12. 입력가능한 값을 출력하는 부분
func showConvertibleUnit() {
    print("""
        <주의> 같은단위 내에서만 변환이 가능합니다.!
        길이 : \(UnitsName.length)
        무게 : \(UnitsName.weight)
        부피 : \(UnitsName.volume)
        """)
}

// 13. 프로그램 구현부
unitConvertLoop : while true {
    showConvertibleUnit()
    print("변환 하고 싶으신 단위를 입력하세요 : ", terminator: "")
    let userInput = readLine()
    if userInput == "q" || userInput == "quit"
    { print ("프로그램이 종료됩니다."); break }
    printResult(excuteConverting(userInput))
    print("---------------------------\n")
}
