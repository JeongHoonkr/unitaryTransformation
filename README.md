## 단위 변환기

### 1. 길이변환 및 출력 (완료)

* 요구사항

  > - github 저장소를 만들고 새로운 Playground를 생성해서 저장소에 연결한다.
  > - 다음의 센티미터(cm) 단위 값을 미터(m) 단위로 변환해 결과 화면에 출력한다.
  >   - 예를 들어 "120cm"을 "1.2m"로 출력한다.
  > - 미터(m) 단위 값을 센티미터(cm) 단위로 변환해 결과 화면에 출력한다.
  >   - "1.86m"를 "186cm"로 출력한다.

  ​

* 힌트

  > 변환 결과를 print() 함수를 활용해 결과 화면에 출력한다.
  >
  > Int 타입과 Float/Double 데이터 타입 변환하는 방법을 찾아본다.
  >
  > 구글에서 "프로그래밍 길이 변환" 혹은 "프로그래밍 단위 변환" 같은 키워드로 검색하고 변환(계산) 방법을 찾아 구현한다.



* 어려웠던 점 및 해결사항

  > * 어려웠던 점 : 사용하는 변수의 타입이 string이라 string을 다루는 것이 어려웠다.
  > * 해결방법 
  >   * `index(of: )`와 nil결합연산자를 사용해서 서브스크립트 범위를 활용하여 문자열을 구분
  >   * `prefix(upTo: )` : upto 포지션의 전까지 포함하여 스트링 반환
  >   * `trimmingCharacters` : 양끝의 케릭터를 제거하는 함수, 단위제거에 사용



### 2. 길이 단위 변환 함수 (완료)

- 요구사항

  > 센티미터 단위 값을 변수에 저장하고 변환하는 데 사용한다.
  >
  > 센티미터 단위 값을 저장한 변수를 미터 단위 값으로 변환한 후 변수에 저장하고 저정한 변수 값을 출력한다.
  >
  > 길이 단위를 바꿀 때 곱하거나 나누는 값은 바뀌지 않는 값이다. 따라서 상수 값으로 지정해서 프로그램을 구현한다.
  >
  > 문자열로 값 뒤에 붙어있는 단위에 따라 길이를 변환해서 결과를 출력하는 함수를 만든다.
  >
  > 예를 들어 "183cm"처럼 숫자 다음에 cm가 붙어있으면 센티미터 값을 미터로 변환하고 출력한다. "3.14m"처럼 숫자 다음에 m가 붙어있으면 미터 값을 센티미터로 변환하고 출력한다.



### 3. 사용자가 값을 입력하게 하여 2번 구현하기

- 요구사항

  >- 사용자가 길이 값을 입력하고 변수에 저장하도록 한다.
  >- 길이 단위에 따라 센티미터를 미터로 바꾸는 함수와, 미터를 센티미터로 바꾸는 함수로 나눈다.
  >- 사용자가 입력한 문자열에서 값 뒤에 붙어있는 단위에 따라서, 앞서 나눠놓은 길이 변환 함수를 호출하고 결과를 출력한다.
  >  - 예 :  "183cm"처럼 숫자 다음에 cm가 붙어있으면 센티미터 값을 미터로 변환하고 출력한다.
  >  - "3.14m"처럼 숫자 다음에 m가 붙어있으면 미터 값을 센티미터로 변환하고 출력한다.

- 힌트

  > ```swift
  > let inputValue = readLine()
  > ```



* 어려웠던 점 및 해결사항 

  > readLine이 옵셔널이기 때문에 언래핑을 해줘야 했던점 -> guard let 사용
  >
  > 입력받지 않았을때는 출력하는 함수를 호출해서 썼지만, 입력받아야 하기 때문에
  >
  > 조건을 설정해서 구현해야 했던 부분 -> while루프 사용해서 조건식 추가
  >
  > * 다음과제를 위해 추가로 연습해본 부분 : q, quit 입력시 종료되는 조건 추가



### 4. 인치 길이 변환과 예외 처리

* 요구사항 

  >- 사용자가 길이 값과 단위를 입력하고 변환할 단위까지도 입력하도록 확장한다.
  >- 센티미터를 인치로 바꾸는 함수와 인치를 센티미터로 바꾸는 함수를 추가로 구현한다.
  >- 사용자가 입력한 문자열에서 값 뒤에 붙어있는 단위와 그 이후에 변환할 단위를 붙이면 해당하는 변환 함수를 호출해서 변환하도록 구현한다.
  >  - 예를 들어 "18cm inch"라고 입력하면 센티미터를 인치로 바꾸는 함수를 호출한다.
  >  - "25.4inch m"라고 입력하면 인치를 센티미터로 바꾸는 함수를 호출하고, 다시 센티미터 단위를 미터로 바꾸는 함수를 호출한다.
  >  - "0.5m inch"라고 입력하면 미터를 센티미터로 바꾸는 함수를 호출하고, 다시 센티미터 단위를 인치로 바꾸는 함수를 호출한다.
  >  - "183cm"처럼 숫자 다음에 cm만 붙어있으면 센티미터 값을 미터로 변환하고 출력한다.
  >  - "3.14m"처럼 숫자 다음에 m가 붙어있으면 미터 값을 센티미터로 변환하고 출력한다.
  >- 만약 지원하지 않는 길이 단위(feet)가 붙어 있을 경우, "지원하지 않는 단위입니다."를 출력하고 다시 입력받도록 한다.

  ​

* 문제해결을 위해 생각해보기