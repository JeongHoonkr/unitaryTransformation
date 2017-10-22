//
//  main.swift
//  UnitConverterplusInch
//
//  Created by Choi Jeong Hoon on 2017. 10. 22..
//  Copyright © 2017년 JH Factory. All rights reserved.
//

import Foundation

/*
 사용자가 길이 값과 단위를 입력하고 변환할 단위까지도 입력하도록 확장한다.
 센티미터를 인치로 바꾸는 함수와 인치를 센티미터로 바꾸는 함수를 추가로 구현한다.
 사용자가 입력한 문자열에서 값 뒤에 붙어있는 단위와 그 이후에 변환할 단위를 붙이면 해당하는 변환 함수를 호출해서 변환하도록 구현한다.
 예를 들어 "18cm inch"라고 입력하면 센티미터를 인치로 바꾸는 함수를 호출한다.
 "25.4inch m"라고 입력하면 인치를 센티미터로 바꾸는 함수를 호출하고, 다시 센티미터 단위를 미터로 바꾸는 함수를 호출한다.
 "0.5m inch"라고 입력하면 미터를 센티미터로 바꾸는 함수를 호출하고, 다시 센티미터 단위를 인치로 바꾸는 함수를 호출한다.
 "183cm"처럼 숫자 다음에 cm만 붙어있으면 센티미터 값을 미터로 변환하고 출력한다.
 "3.14m"처럼 숫자 다음에 m가 붙어있으면 미터 값을 센티미터로 변환하고 출력한다.
 만약 지원하지 않는 길이 단위(feet)가 붙어 있을 경우, "지원하지 않는 단위입니다."를 출력하고 다시 입력받도록 한다.
 */

import Foundation

// 함수0 : 사용자로부터 값을 입력받기
func getUserInput () -> String {
    let userInput = readLine() ?? ""
    return userInput
}

// 함수1 : meter 단위제거 : trimmingCharacters사용
func eraseMeterUnit (_ input: String) -> Int{
    var num: Int = 0
    num += Int(input.trimmingCharacters(in: ["m"]))!
    return num
}

// 함수2 : meter를 centi로 변환
func convertMeterToCenti (_ input: Int) -> String {
    var result: String = ""
    result += String(input*100) + "cm"
    return result
}

// 함수3 : centi 단위제거 : prefix upto와 index사용
func eraseCentiUnit (_ input: String) -> Double{
    var num: Double = 0.0
    num += Double(input.prefix(upTo: input.index(of: "c")!))!
    return num
}

// 함수4 : centi를 meter로 변환
func convertCentiToM (_ input: Double) -> String {
    var result: String = ""
    result += String(input/100) + "m"
    return result
}

// 함수 5: 출력
func printResult (_ result: String) {
    print(result)
}

// 프로그램 루프
unitConvertLoop : while true {
    print ("변환하고 싶은 단위를 입력해주세요.")
    let input = getUserInput()
    if input == "q" || input == "quit" { break }
    
    var result: String = ": "
    if input.hasSuffix("cm") {
        result += convertCentiToM(eraseCentiUnit(input))
    } else if input.hasSuffix("m") {
        result += convertMeterToCenti(eraseMeterUnit(input))
    } else {
        print ("지원하지 않는 단위입니다.")
        continue unitConvertLoop
    }
    printResult(result)
}

