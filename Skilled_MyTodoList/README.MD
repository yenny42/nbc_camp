# 📋 TO DO LIST <br/> 앱개발 숙련 강의 과제

<!--
## 폴더링
## UI 디자인
## 기술 스택
## 구조 및 설계
-->

## 폴더링
![스크린샷 2024-01-10 오후 4 21 35](https://github.com/yenny42/nbc_camp/assets/107637741/6088d57c-24b2-4f41-871d-89f0e2f32b78)

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

### Model (데이터 모델)
- **TodoData**:
  - Todo 데이터 구조체
  - 프로퍼티: `category`, `title`, `isCompleted`

- **RandomDog**, **Dog**:
  - 이미지 정보 모델 구조체
  - 랜덤 개 이미지 api 요청할 때 사용

<br/>

### View (사용자 인터페이스)
- **HomeView**:
  - 홈 화면 스택 뷰
  - 서브뷰: `mainImage`, `showTodoListButton`, `showCompletedListButton`, `showDogImage`

- **TodoTableView**:
  - 할 일 목록 테이블 뷰
  - 할 일 추가, 수정, 삭제
  - 서브뷰: `TodoTableViewCell`

- **CompletedListView**:
  - 완료된 일 목록 테이블 뷰

- **RandomDogView**:
  - 랜덤 개 이미지를 표시
  - GIF 이미지 스켈레톤

<br/>

### Controller (비즈니스 로직 및 상태 관리)
- **HomeVC**:
  - 홈 화면 뷰 컨트롤러
  - 서브뷰 : `TodoListVC`, `CompletedListVC`, `RandomDogVC`
  - 화면 전환 및 데이터 처리

- **TodoListVC**:
  - 할 일 목록 뷰 컨트롤러
  - 할 일 추가, 수정, 삭제 로직

- **CompletedListVC**:
  - 완료된 일 목록 뷰 컨트롤러
  - 완료된 일 목록 표시, 삭제

- **RandomDogVC**:
  - 랜덤 개 이미지 뷰 컨트롤러
  - GIF 스켈레톤 처리 및 api 통신하여 이미지 업데이트

<br/>

### 네트워크 통신
- **RandomDogRequest**:
  - 랜덤 개 이미지를 서버에서 가져오기 위한 네트워크 요청 클래스
  - URLSession
