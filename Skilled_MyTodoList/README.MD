# 📋 TO DO LIST <br/> 앱개발 숙련 강의 과제

<!--
## 폴더링
## UI 디자인
## 기술 스택
## 구조 및 설계
-->

## 폴더링
![스크린샷 2024-01-11 오전 11 14 06](https://github.com/yenny42/nbc_camp/assets/107637741/23e97190-2e29-494d-99d7-1dcc29ea5549)

<br/>

## 기술 스택
- 언어 - Swift
- 프레임워크 - UIKit, Gifu
- 네트워크 통신 - URLSession

<br/>

## 구조 및 설계

### 다이어그램
![스크린샷 2024-01-10 오후 4 36 45](https://github.com/yenny42/nbc_camp/assets/107637741/b5b58165-e673-4caf-bab1-f98686af6ffc)

<br/>

### Model
- **TodoData**:
  - Todo 데이터 `Struct`
  - 프로퍼티: `category`, `title`, `isCompleted`

- **RandomDog**, **Dog**:
  - 이미지 정보 모델 `Struct`
  - 랜덤 개 이미지 api Request 시 사용하는 타입

<br/>

### View
- **HomeView**:
  - 홈 화면 `UIStackView`
  - 서브뷰: `mainImage`, `showTodoListButton`, `showCompletedListButton`, `showDogImage`

- **TodoTableView**:
  - 할 일 목록 `UITableView`
  - 할 일 추가, 수정, 삭제
  - 서브뷰: `TodoTableViewCell`

- **CompletedListView**:
  - 완료된 일 목록 `UITableView`

- **RandomDogView**:
  - 랜덤 개 이미지 `UIImageView`
  - GIF 이미지 스켈레톤

<br/>

### Controller
- **HomeVC**:
  - 홈 화면 `ViewController`
  - 화면 전환 및 데이터 처리
  - 서브뷰 : `TodoListVC`, `CompletedListVC`, `RandomDogVC`

- **TodoListVC**:
  - 할 일 목록 `ViewController`
  - UserDefaults - 할 일 추가, 완료 여부 수정, 삭제 

- **CompletedListVC**:
  - 완료된 일 목록 `ViewController`
  - UserDefaults - 완료된 일 목록 표시, 삭제

- **RandomDogVC**:
  - 랜덤 개 이미지 `ViewController`
  - GIF 스켈레톤 처리 및 api 통신 & `UIImageView` 업데이트

<br/>

### 네트워크 통신
- **RandomDogRequest**:

  - https://api.thedogapi.com/v1/images/search `api request`
  - URLSession

<br/><br/>

## 저번 투두리스트 피드백
```
- Todo 같은 모델 타입은 ViewController에 내포하는게 아닌 
  별도 파일로 분리하여 관심사를 조금 더 구분짓고 
  그룹화 등 디렉토리 관리도 해보면 좋을것 같아요~!

- 또한, 현재 ViewController 파일 및 타입 명이 ViewController인데 
  추후 다른 VC가 생기면 수정되어야 하지 않을까요~? 
  그렇기에 조금 더 명확한 네이밍을 가질 수 있도록 
  모든 부분에서 구체적으로 네이밍을 지어보면 좋을것 같습니다.

- class를 사용할때 final 키워드도 나아가서 학습해보고 적용해봐도 좋을것 같습니다.

- 그리고 현재 할일을 체크할때 하트 이미지 버튼을 이용하는데 
  일반적으로 하트를 생각하면 좋아요 및 북마크 저장과 같은 느낌으로 
  활용되기에 HIG를 참고하여 완료 체크 이미지를 더 직관적이고 
  일반적인 이미지로 바꿔도 좋지 않을까 생각이 듭니다!
```
<br/>
