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

var cmUnitNum : String = "14444444cm"
cmUnitNum = "142m"

if cmUnitNum.contains("cm") {
    let firstCharOfUnit = cmUnitNum.index(of: "c") ?? cmUnitNum.endIndex
    let justNum = cmUnitNum[..<firstCharOfUnit]
    print (String("\(Double(justNum)!/100)m"))
} else {
    let firstCharOfUnit = cmUnitNum.index(of: "m") ?? cmUnitNum.endIndex
    let justNum = cmUnitNum[..<firstCharOfUnit]
    print (String("\(Double(justNum)!*100)cm"))
}
