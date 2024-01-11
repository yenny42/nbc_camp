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

## UI 디자인

<img src="https://github.com/yenny42/nbc_camp/assets/107637741/4d9d37a5-d545-461c-870c-3069781be7b2" height="500"/>
<img src="https://github.com/yenny42/nbc_camp/assets/107637741/8757c3d3-8342-49c5-b391-1e98619463b2" height="500"/>
<img src="https://github.com/yenny42/nbc_camp/assets/107637741/3ea1e359-df49-4a15-8dba-06561d38d754" height="500"/>

<img src="https://github.com/yenny42/nbc_camp/assets/107637741/f5b2b10a-a2ab-4f15-a14e-d23ea26ba19b" height="500"/>
<img src="https://github.com/yenny42/nbc_camp/assets/107637741/3a996a44-bb3c-4e52-8f67-f28bb7cf0ad5" height="500"/>
<img src="https://github.com/yenny42/nbc_camp/assets/107637741/0fa9e381-ae5e-4747-a31b-d8c32cf0ad98" height="500"/>
<img src="https://github.com/yenny42/nbc_camp/assets/107637741/42077425-106f-4eb8-9747-7fb92f6cdfb0" height="500"/>
<img src="https://github.com/yenny42/nbc_camp/assets/107637741/ce2ac975-317e-4a8c-950d-4e675ad5e01d" height="500"/>


<br/><br/>

## 기술 스택
- 언어 - Swift
- 프레임워크 - UIKit, Gifu
- 네트워크 통신 - URLSession

<br/><br/>

## 구조 및 설계

### 다이어그램
![스크린샷 2024-01-10 오후 4 36 45](https://github.com/yenny42/nbc_camp/assets/107637741/b5b58165-e673-4caf-bab1-f98686af6ffc)

<br/>

### MVC (Model-View-Controller) 아키텍처
- **Model**
  - `TodoData`, `RandomDog`, `RandomDogRequest`
- **View**
  - `HomeView`, `TodoTableView`, `TodoTableViewCell`, `CompletedListView`, `RandomDogView`
- **ViControllerew**
  - `HomeVC`, `TodoListVC`, `CompletedListVC`, `RandomDogVC`

<br/>

### 1. 데이터 모델 (Model):

- **TodoData 구조체:**
  - 속성: 할 일의 카테고리, 제목, 완료 여부를 나타내는 데이터 구조체.
  - 메서드: 데이터를 로컬 스토리지에 저장하고 불러오는 메서드를 제공.

### 2. 데이터 로딩 및 저장:

- **UserDefaults**
  - `saveTodoData`
  - `loadTodoData`
  - `loadAllData`
  - `updateTodoData`
  - `removeTodoData`

### 3. 컨트롤러 (Controller)와 뷰 (View) 간의 상호 작용:

- **HomeVC**
  - `HomeView` 메인화면 구성
  - 버튼 클릭 액션 처리: 할 일 목록 보기, 완료된 일 보기, 랜덤 강아지 이미지 보기.

- **TodoListVC**
  - 할 일 목록 표시
  - `TodoListDelegate` 프로토콜을 통해 스위치 토글 액션 처리.
  - 데이터 로드: `loadData` 메서드를 통해 할 일 목록 로드.

- **CompletedListVC**
  - 완료된 일 목록 표시
  - 데이터 로드: `loadData` 메서드를 통해 완료된 일 목록 로드.

### 4. 네트워킹 및 이미지 로딩:

- **RandomDogRequest 클래스:**
  - 외부 API 호출하여 랜덤 강아지 이미지 가져오는 기능 담당.

- **ImageLoader 클래스:**
  - 이미지 비동기로 로딩.
  - `RandomDogVC`에서 호출되어 강아지 이미지 표시.

### 5. 뷰의 표현:

- **HomeView:**
  - 메인 이미지, 할 일 목록 보기 버튼, 완료된 일 보기 버튼, 랜덤 강아지 이미지 버튼을 포함하는 뷰.

- **TodoTableView:**
  - 할 일 목록을 테이블 뷰로 표시.
  - `TodoTableViewCell`에서는 각 셀의 스위치 토글 액션을 `TodoListDelegate`를 통해 처리.

- **CompletedListView:**
  - 완료된 일 목록을 테이블 뷰로 표시.

- **RandomDogView:**
  - 랜덤 강아지 이미지를 표시하는 뷰.


<br/>

### 네트워크 통신
- **RandomDogRequest**:

  - https://api.thedogapi.com/v1/images/search `api request`
  - URLSession

- **ImageLoader**
  - 이미지 URL을 사용하여 비동기 통신

<br/><br/><br/><br/>

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
