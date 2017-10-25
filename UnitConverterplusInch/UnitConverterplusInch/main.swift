//
//  main.swift
//  UnitConverterplusInch
//  Created by Choi Jeong Hoon on 2017. 10. 22..
//  Copyright © 2017년 JH Factory. All rights reserved.

/* 로직 :
 1. 프로그램 구현부에서 유저 인풋값을 받음
 2. 인풋값이 프린트함수를 호출 : 프린트함수는 연산함수를 인수로 받음
 3. 변환함수가 아래의 함수를 호출함
 함수1 : 유저인풋 받아서 배열로 나누기
 함수2 : 갖고있는 단위인지 아닌지 판별하여 불값으로 리턴 (있으면 트루, 없으면 폴스)
 - 갖고있는 단위가 없어서 false라면 "지원하지 않는 단위입니다." 출력하고 프로그램 다시 돌림
 함수3 : 배열의 길이가 2인지 1인지 판별하여 배열을 튜플 스트링으로 리턴해줌
 - 배열의 길이가 1이라면 현재갖고있는 단위를 확인하고 숫자와 단위로 리턴
 - 배열의 길이가 2라면 현재단위와 목표단위와 숫자로 리턴
 함수4 : 함수3번이 반환한 값을 인수로 받아 연산하는 함수
 - 받은 인수에 따라 현재단위를 목표단위로 바꿔줄것인지, 현재단위만 cm-m을 상호 변환해줄것인지 선택하여 연산된 값을 리턴
 4. 3번의 변환이 끝난값을 2번의 프린트함수가 인수로 받아 결과를 출력
 */

import Foundation

// 0. lengunit의 구조체 선언
struct LengthUnit {
    enum UnitNum: Float {
        case cm = 1, m = 100, inch = 2.54
    }
    enum Unittype: String {
        case cm, m, inch
    }
    // unit체크를 위해 배열에 넣음
    let lengthUnitType = [Unittype.cm.rawValue, Unittype.m.rawValue, Unittype.inch.rawValue]
}

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
    for i in lengUnit.lengthUnitType {
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
    for i in lengUnit.lengthUnitType {
        if strArray[0].hasSuffix(i) {
            from += i
            return from
        }
    }
    return from
}

// 4. 배열을 스트링으로 나누기 <배열 길이에 따라 분기>
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
        if from == LengthUnit.Unittype.cm.rawValue {
            to = LengthUnit.Unittype.m.rawValue
        } else if from == LengthUnit.Unittype.m.rawValue {
            to = LengthUnit.Unittype.cm.rawValue }
    }
    return (from, to, num)
}

// 5. 모든 함수를 호출하여 값을 반환하는 함수
func excuteConverting (_ userInput: String?) -> String {
    guard let userInput = userInput else { return "" }
    var hasUnit: Bool = false
    var result: String = "변환된 값 -> "
    let divide = divideStrToArr(userInput)
    hasUnit = unitCheck(divide)
    if hasUnit == true {
        let (from, to, num) = devideArrToStr(divide)
        switch (from, to) {
        case ("cm", "inch") :
            result += "\((String(convertCentiToInch(Float(num) ?? 0)) + to))"
        case ("cm", "m") :
            result += "\((String(convertCentiToM(Float(num) ?? 0)) + to))"
        case ("m", "inch") :
            result += "\((String(convertCentiToInch(convertMeterToCenti(Float(num) ?? 0))) + to))"
        case ("m", "cm") :
            result += "\((String(convertMeterToCenti(Float(num) ?? 0)) + to))"
        case ("inch", "m") :
            result += "\((String(convertCentiToM(convertInchToCenti(Float(num) ?? 0))) + to))"
        case ("inch", "cm") :
            result += "\((String(convertInchToCenti(Float(num) ?? 0)) + to))"
        default :
            result += ("지원하지 않는 단위입니다.")
        }
    } else {
        result += ("지원하지 않는 단위입니다.")
    }
    return result
}
// 6. 각 연산 함수

// : meter를 centi로 변환
func convertMeterToCenti (_ input: Float) -> Float {
    var result: Float = 0.0
    result += input*LengthUnit.UnitNum.m.rawValue
    return result
}

// : centi를 meter로 변환
func convertCentiToM (_ input: Float) -> Float {
    var result: Float = 0.0
    result += input/LengthUnit.UnitNum.m.rawValue
    return result
}

// : centi를 inch로 변환
func convertCentiToInch (_ input: Float) -> Float {
    var result: Float = 0.0
    result += input/LengthUnit.UnitNum.inch.rawValue
    return result
}

// : inch를 centi로 변환
func convertInchToCenti (_ input: Float) -> Float {
    var result: Float = 0.0
    result += input*LengthUnit.UnitNum.inch.rawValue
    return result
}

// 7. 출력
func printResult (_ result: String) {
    print(result)
}

// 8. 프로그램 구현부
unitConvertLoop : while true {
    print ("변환하고 싶은 단위를 입력해주세요.")
    let userInput = readLine()
    if userInput == "q" || userInput == "quit" { break }
    printResult(excuteConverting(userInput))
    print("------------------\n")
}
