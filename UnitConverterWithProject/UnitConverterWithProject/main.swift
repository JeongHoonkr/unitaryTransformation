//
//  main.swift
//  UnitConverterWithProject
//
//  Created by Choi Jeong Hoon on 2017. 10. 20..
//  Copyright © 2017년 JH Factory. All rights reserved.
//


/*
 사용자가 길이 값을 입력하고 변수에 저장하도록 한다.
 길이 단위에 따라 센티미터를 미터로 바꾸는 함수와, 미터를 센티미터로 바꾸는 함수로 나눈다.
 사용자가 입력한 문자열에서 값 뒤에 붙어있는 단위에 따라서, 앞서 나눠놓은 길이 변환 함수를 호출하고 결과를 출력한다.
 예를 들어 "183cm"처럼 숫자 다음에 cm가 붙어있으면 센티미터 값을 미터로 변환하고 출력한다.
 "3.14m"처럼 숫자 다음에 m가 붙어있으면 미터 값을 센티미터로 변환하고 출력한다.
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

func makeStringresult (_ input: String) -> String {
    var result: String = "변환된 값 : "
    if input.hasSuffix("cm") {
        result += convertCentiToM(eraseCentiUnit(input))
    } else if input.hasSuffix("m") {
        result += convertMeterToCenti(eraseMeterUnit(input))
    } else {
        result += "지원하지 않는 단위입니다."
    }
    return result
}

// 함수 5: 출력
func printResult (_ result: String) {
    print(result)
}

// 프로그램 루프
while true {
    print ("변환하고 싶은 단위를 입력해주세요.")
    let input = getUserInput()
    if input == "q" || input == "quit" { break }
    printResult(makeStringresult(input))
    print("--------------------------")
}
