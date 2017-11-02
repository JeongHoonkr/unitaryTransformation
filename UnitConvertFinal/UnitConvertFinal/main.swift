//
//  main.swift
//  UnitConvertorWithYard
//
//  Created by Choi Jeong Hoon on 2017. 10. 25..
//  Copyright © 2017년 JH Factory. All rights reserved.
//

import Foundation

// 1. 길이 구조체
struct LengthUnit {
    enum UnitName: String { case cm, m, inch, yard }
    static let names = [UnitName.cm.rawValue, UnitName.m.rawValue, UnitName.inch.rawValue, UnitName.yard.rawValue]
    static let nameAndValue: [String: Float] = [UnitName.cm.rawValue: 1, UnitName.m.rawValue: 100, UnitName.inch.rawValue: 2.54, UnitName.yard.rawValue: 91.44]
}

// 2. 무게 구조체
struct WeightUnit {
    enum UnitName: String { case g, kg, oz, lb }
    static let names = [UnitName.g.rawValue, UnitName.kg.rawValue, UnitName.oz.rawValue, UnitName.lb.rawValue]
    static let nameAndValue: [String: Float] = [UnitName.g.rawValue: 1, UnitName.kg.rawValue: 1000, UnitName.oz.rawValue: 28.3495, UnitName.lb.rawValue: 453.592]
}

// 3. 부피 구조체
struct VolumeUnit {
    enum UnitName: String { case L, pt, qt, Gal }
    static let names = [UnitName.L.rawValue, UnitName.pt.rawValue, UnitName.qt.rawValue, UnitName.Gal.rawValue]
    static let nameAndValue: [String: Float] = [UnitName.L.rawValue: 1, UnitName.pt.rawValue: 0.473176, UnitName.qt.rawValue: 0.946353, UnitName.Gal.rawValue: 3.78541]
}

// 4. 단위 비교를 위한 열거형
enum UnitsType { case length, weight, volume, none }

// 5. 분리클래스 : 인풋스트링을 기준으로 분리
class Separating {
    // 5-1. 입력받은 값을 배열로 분리
    var (from, num, to): (String, String, [String]) = ("", "", [])
    func divideStringtoArray (_ input: String) -> Array<String> {
        let userInput = input
        let temp = userInput.components(separatedBy: " ")
        return temp // ["123cm", "inch,yard"]
    }
    
    // 5-2. 배열로부터 기본단위 분리하기
    func findUnit (_ strArray: [String]) -> String? {
        let unitNamesAssortment = [LengthUnit.nameAndValue.keys, WeightUnit.nameAndValue.keys, VolumeUnit.nameAndValue.keys]
        for unitNames in unitNamesAssortment {
            for unitName in unitNames {
                if strArray[0].contains(unitName) {
                    from = unitName
                    return from
                }
            }
        }
        return nil
    }
    
    // 5-3. 배열의 길이가 2일떄 배열을 문자열로 분리
    func divideTwoArray (_ input: [String], type unit: UnitsType ) -> (String, String, Array<String>) {
        from = findUnit(input) ?? ""
        let frontString = input[0]
        num += frontString.prefix(frontString.count - from.count)
        if input[1].contains(",") {
            to += input[1].components(separatedBy: ",")
        } else {
            to.append(input[1])
        }
        return (from, num, to)
    }
    
    // 5-4. 배열의 길이가 1일떄 배열을 문자열로 분리 <이 부분이 보기 싫다. 어떻게 수정할 수 있을까>
    func divideOneArray (_ input: [String], type unitType: UnitsType) -> (String,  String, Array<String>) {
        from = findUnit(input) ?? ""
        let frontString = input[0]
        num += frontString.prefix(frontString.count - from.count)
        let unitNames = [LengthUnit.names, WeightUnit.names, VolumeUnit.names]
        switch unitType {
        case .length :
            for unit in unitNames[0] {
                if from != unit {
                    to.append(unit)
                }
            }
        case .weight :
            for unit in unitNames[1] {
                if from != unit {
                    to.append(unit)
                }
            }
        case .volume :
            for unit in unitNames[2] {
                if from != unit {
                    to.append(unit)
                }
            }
        default : break
        }
        return (from, num, to)
    }
}

// 6. 체크클래스 : 단위를 근거로해서 체크하는 함수
class CheckUnit: Separating {
    
    // 6-1. 해당단위가 속한 단위범주가 어떤단위인지 판단해주는 함수
    func checkUnitsType (_ inputUnit: String) -> UnitsType {
        var unitType : UnitsType = .none
        if LengthUnit.UnitName.init(rawValue: inputUnit) != nil    { unitType = UnitsType.length }
        else if WeightUnit.UnitName.init(rawValue: inputUnit) != nil{ unitType = UnitsType.weight }
        else if VolumeUnit.UnitName.init(rawValue: inputUnit) != nil { unitType = UnitsType.volume }
        return unitType
    }
    
    // 6-2. 기본단위인지 아닌지 판단하는 enum
    enum BaseUnit { case base, upper }
    
    // 6-3. 기본단위인지 아닌지 판단하는 함수
    func checkBaseOfUnit (_ input: String) -> BaseUnit {
        var result: BaseUnit
        switch input {
        case LengthUnit.UnitName.cm.rawValue : result = BaseUnit.base
        case WeightUnit.UnitName.g.rawValue : result = BaseUnit.base
        case VolumeUnit.UnitName.L.rawValue : result = BaseUnit.base
        default : result = BaseUnit.upper
        }
        return result
    }
    
    // 6-3. 출발단위와 목표단위가 상호 변환가능한 단위인지 확인
    func compareUnitType (_ fromUnit: String, _ Units: [String]) -> Bool {
        var isPossibleConvert: Bool = false
        let fromUnit = checkUnitsType(from)     // cm이면 length
        var targetUnit: UnitsType
        for unit in Units {
            targetUnit = checkUnitsType(unit)
            if fromUnit == targetUnit {
                isPossibleConvert = true
            } else {
                isPossibleConvert = false
            }
        }
        return isPossibleConvert
    }
}

// 7. 연산 클래스
class Operator: CheckUnit {
    // 7-1. 연산함수  <단순케이스 비교같다..있어보이게 변경할 수 없을까>
    func convertNum (_ inputNum: String, _ from: String, _ toUnits: [String], _ isBaseUnit: BaseUnit, _ unitType: UnitsType) -> String {
        var result: String = ""
        let inputNum: Float = Float(inputNum) ?? 0
        for toUnit in toUnits {
            if isBaseUnit == BaseUnit.base {
                switch unitType {
                case .length :
                    let length = LengthUnit.nameAndValue
                    result += String(inputNum / (length[toUnit] ?? 0)) + toUnit + "\n"
                case .weight :
                    let weight = WeightUnit.nameAndValue
                    result += String(inputNum / (weight[toUnit] ?? 0)) + toUnit + "\n"
                case .volume :
                    let volume = VolumeUnit.nameAndValue
                    result += String(inputNum / (volume[toUnit] ?? 0)) + toUnit + "\n"
                default : break
                }
            } else if isBaseUnit == BaseUnit.upper {
                switch unitType {
                case .length :
                    let length = LengthUnit.nameAndValue
                    result += String((inputNum * (length[from]!) / (length[toUnit] ?? 0))) + toUnit + "\n"
                case .weight :
                    let weight = WeightUnit.nameAndValue
                    result += String((inputNum * (weight[from]!)) / (weight[toUnit] ?? 0)) + toUnit + "\n"
                case .volume :
                    let volume = VolumeUnit.nameAndValue
                    result += String((inputNum * (volume[from]!)) / (volume[toUnit] ?? 0)) + toUnit + "\n"
                default : break
                }
            }
        }
        return result
    }
}

// 8. 모든 함수를 호출하여 값을 반환하는 함수   <길어서 읽기가 힘들다, 프로그램 구현부와 역할분담을 해야할까?>
func excuteConverting (_ userInput: String?) -> String {
    guard let userInput = userInput else { return "" }
    var result: String = ""
    let convert = Operator()
    var (num, targetUnits): (String, [String]) = ("", [])
    let modifiedInput = convert.divideStringtoArray(userInput)
    var canConvert: Bool = false
    
    if var from = convert.findUnit(modifiedInput) {
        let checkUnit = convert.checkUnitsType(from)
        if modifiedInput.count == 2 {
            (from, num, targetUnits) = convert.divideTwoArray(modifiedInput, type: checkUnit)
            canConvert = convert.compareUnitType(from, targetUnits)
            if canConvert == true {
                let baseOrUpper = convert.checkBaseOfUnit(from)
                result = convert.convertNum(num, from, targetUnits, baseOrUpper, convert.checkUnitsType(from))
            } else  {
                result += "상호간의 변환할 수 업는 단위입니다"
            }
        }
        else if modifiedInput.count == 1 {
            (from, num, targetUnits) = convert.divideOneArray(modifiedInput, type: checkUnit)
            canConvert = convert.compareUnitType(from, targetUnits)
            if canConvert == true {
                let baseOrUpper = convert.checkBaseOfUnit(from)
                result = convert.convertNum(num, from, targetUnits, baseOrUpper, convert.checkUnitsType(from))
            } else  {
                result += "상호간의 변환할 수 업는 단위입니다"
            }
        }
    }
    else {
        result += "지원하지 않는 단위입니다."
    }
    return result
}

// 11. 출력
func printResult (_ result: String) { print(result) }

// 12. 입력가능한 값을 출력하는 부분
func showConvertibleUnit() {
    print("""
        <입력예시> 123m or 132cm inch or 132yard inch,m
        길이 : \(LengthUnit.names)
        무게 : \(WeightUnit.names)
        부피 : \(VolumeUnit.names)
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

