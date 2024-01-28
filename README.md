# 앱 개발 심화 - 개인 과제
> 디자인이 정해진 UI 구성하기 및 CoreData를 활용하여 데이터 일관성 구현하기

<br/>

## UserDefaults와 CoreData의 차이점

| UserDefaults | CoreData |
| --- | --- |
| 간단한 데이터를 저장 | 복잡한 데이터를 저장 | 
| 보안은 좀 떨어져도 성능이 중요한 경우 | 데이터의 보안을 강화해야 하는 경우 | 
| 복잡한 데이터 구조를 저장하기 어려움 | 복잡한 데이터 구조를 저장할 수 있음 |
| key-value | 데이터를 Entity라는 객체의 집합으로 표현 | 
| 사용 난이도 쉬움 | 사용 난이도 어려움 |

#### 객체?
      
    데이터와 해당 데이터를 처리하는 메서드를 포함하는 단위

<br/>
<br/>

## Lv1. UI 동일하게 구현하기

⬇️ 구현한 화면 (Gif) ⬇️

<img src = "https://github.com/yenny42/nbc_camp/assets/107637741/0aca4e4a-ceab-4f3f-98f5-174c468ed101" width = "300" />

1. 사용한 UI 요소

    - `UILabel`
    - `UIButton`
    - `UIImageView`
    - `UIStackView`
    - `UICollectionView`, `UICollectionViewFlowLayout`
    - `UINavigationBar`

<br/>

2. 사용한 이미지 assets

    <img src = "https://github.com/yenny42/nbc_camp/assets/107637741/09bcda65-ad96-46c1-a79d-9d2f6f1fa8b8" width = "200" />

<br/>

3. Code Base AutoLayout UI
   
    - `Visual Format Language` 사용  ([🔗 링크](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/VisualFormatLanguage.html))
    - `SnapKit` X


<br/>

---
<br/>

## Lv2. Profile 페이지 만들기 - `ProfileViewController`

- `UserProfile` Struct 
    - 사용자 정보 데이터 저장 (이름, 나이)

- `ProfileViewModel` Class
    - UserProfile 보유
    - UserProfile의 이름, 나이 정보를 반환

- `ProfileViewController` Class
    - 사용자 프로필 정보를 표시
    - 뷰 모델 (ProfileViewModel)에 바인딩
    - 뷰 모델에서 사용자 프로필 데이터를 수신하고 해당 UILabel을 업데이트

<br/>

---
<br/>

## Lv3. Core Data를 사용해서 데이터 일관성 유지하기

⬇️ 구현한 화면 (mp4) ⬇️

<video src="https://github.com/yenny42/nbc_camp/assets/107637741/8fa77dfa-2112-4414-a979-939862509f99" width = "300" controls>Lv3. CoreData TodoList</video>

<br/>


### Entity : TodoItem

| Attribute | Type | 설명 |
| --- | --- | --- |
| id | UUID | 각 Task의 고유 ID입니다. |
| title | String | Task의 제목입니다. |
| createDate | Date | Task가 생성된 날짜 입니다. |
| modifyDate | Date | Task가 수정된 날짜입니다. |
| isCompleted | Boolean | Task 완료여부입니다. |

<br/>

### Todo Data Type

``` Swift
struct Todo {
    var id: String
    var title: String
    var createDate: Date
    var modifyDate: Date?
    var isCompleted: Bool
}
```
- 생성 시 modifyDate를 넣지 않기 위해서 옵셔널 지정

<br/>

### Core Data CRUD

#### - Create

``` Swift
func saveData(title: String) {
    guard let context = self.persistentContainer?.viewContext else { return }

    if title.count > 30 {
        return
    }

    do {
        let newTodo = TodoItem(context: context)
        newTodo.id = UUID()
        newTodo.title = title
        newTodo.createDate = Date()
        newTodo.isCompleted = false
            
        try context.save()
    } catch {
        print("Error saving todo: \(error)")
    }
}
```
- title의 경우 30자 이상일 경우 다시 입력받게 함
- 새로운 값을 생성할 때는 createDate만 입력하고 modifyDate는 입력하지 않음

<br/>



#### - Read

``` Swift
func readData() -> [Todo] {
    guard let context = self.persistentContainer?.viewContext else { return [] }
        
    let request = TodoItem.fetchRequest()
        
    do {
        let todos = try context.fetch(request)
            
        var data: [Todo] = []
            
        for todo in todos {
            let todoModel = Todo(
                id: String(describing: todo.id),
                title: todo.title!,
                createDate: todo.createDate!,
                modifyDate: todo.modifyDate ?? nil,
                isCompleted: todo.isCompleted
            )
                
            data.append(todoModel)
        }
            
        return data
    } catch {
        print("Error fetching todos: \(error)")
        return []
    }
}
```
- modifyDate는 값이 없을 수 있으니 !를 사용한 강제 추출 언래핑이 불가하므로 nil-coalescing 연산자(??)를 사용하여 기본값 제공


<br/>

#### - Update

``` Swift
func updateData(_ id: String, title: String? = nil, isCompleted: Bool? = nil) {
    guard let context = self.persistentContainer?.viewContext else { return }
        
    let request = TodoItem.fetchRequest()
    guard let todos = try? context.fetch(request) else { return }
        
    let filteredData = todos.filter { String(describing: $0.id) == id }[0]
        
    if title != nil {
        if title!.count > 30 {
            return
        } else {
            filteredData.title = title
        }
    }

    if isCompleted != nil {
        filteredData.isCompleted = isCompleted!
    }
        
    filteredData.modifyDate = Date()
        
    try? context.save()
}
```
- title, isCompleted를 각각 업데이트 할 수 있도록 옵셔널로 지정
- title의 경우 30자 이상일 경우 다시 입력받게 함
- 수정을 할 때마다 modifyDate를 당일의 날짜로 새롭게 업데이트 함

<br/>

#### - Delete

``` Swift
func deleteData(_ id: String) {
    guard let context = self.persistentContainer?.viewContext else { return }
        
    let request = TodoItem.fetchRequest()
    guard let todos = try? context.fetch(request) else { return }
        
    let filteredData = todos.first { String(describing: $0.id) == id }
    context.delete(filteredData!)
        
    try? context.save()
}
```
- id 값을 입력받아 검색한 뒤 해당하는 데이터 삭제
- 상세 화면에서 삭제가 이루어지므로 반드시 id 값이 존재할 것이라 가정하고 별도의 에러처리는 하지 않았음

<br/>
<br/>

### Life Cycle

#### - TodoViewController / viewDidLoad

- getTodoData()로 데이터 가져오기 
- `viewModel.readData()`

#### - TodoViewController / didTapAddTodoButton

- textField 값을 사용하여 저장하기 
- `viewModel.saveData(title: title)`

#### - TodoDetailViewController / didTapDeleteButton

- 삭제하기 버튼 클릭시 해당하는 id 값을 조회하여 제거 
- `viewModel.deleteData(self.data.id)`

#### - TodoDetailViewController / didTapUpdateTitleButton

- 수정하기 버튼 클릭시 textField 값으로 title을 업데이트 
- `viewModel.updateData(data.id, title: titleTextField.text)`

#### - TodoDetailViewController / didTapUpdateIsCompletedButton

- 수정하기 버튼 클릭시 isCompleted 값을 반전하여 isCompleted을 업데이트 
- `viewModel.updateData(data.id, isCompleted: !data.isCompleted)`


<br/>
<br/>


