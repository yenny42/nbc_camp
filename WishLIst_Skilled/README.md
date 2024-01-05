# 📋 WISH LIST <br/> 앱개발 숙련 강의 실습

<!--
## 폴더링


## UI 디자인
-->



## 구조 및 설계

MVC (Model-View-Controller) 아키텍처를 따르고 있습니다.

1. **Model (데이터 모델)**
    - `WishListItem`: 코어 데이터의 엔터티로, 위시리스트 아이템의 정보를 나타냅니다.
    - `id`, `productId`, `name`, `price`, `description` 속성을 가지고 있습니다.
2. **View (뷰)**
    - `ProductView`: 상품 데이터를 시각적으로 표현하기 위한 UIView입니다.
    - UILabel과 UIImageView 로 구성되어 있습니다.
    - `ProductButtonView`
        - 상품 관련 버튼을 담은 UIView입니다.
        - 위시리스트 담기, 다른 상품 보기, 위시리스트 보기 라는 UIButton 으로 구성되어 있습니다.
![스크린샷 2024-01-05 오전 10 17 38](https://github.com/yenny42/nbc_camp/assets/107637741/300f2295-c7c0-464b-979a-b8a2887ca240)


3. **Controller (컨트롤러)**
    - `ProductViewController`
        - 메인이 되는 ViewController. 상품 정보를 보여줍니다.
        - 네트워크 통신을 통해 상품 데이터를 가져오고, 받아온 데이터로 `ProductView`와 `ProductButtonView`를 동적으로 업데이트합니다.
        - 또한, 위시리스트에 상품을 추가하거나, 다른 상품을 랜덤으로 보여주는 등의 기능을 구현합니다.
    - `WishListViewController`
        - 위시리스트를 보여주는 ViewController
        - 코어 데이터에 저장된 위시리스트를 `UITableView, UITableViewCell`을 통해 표시합니다.
4. **네트워크 통신**
    - `URLSession`을 사용하여 비동기 네트워크 통신을 수행합니다.
    - 상품 데이터를 가져오는 동안 스켈레톤을 표시하여 사용자에게 로딩 중임을 시각적으로 알립니다.
5. **알림 처리**
    - 에러가 발생하거나 이미 위시리스트에 있는 상품인 경우에 대한 `alert`이 표시됩니다.
    - '위시리스트 담기' 버튼
        - 코어 데이터에 저장 중 에러가 발생했을 때 - `잠시 후 다시 시도해주세요`
        - 정상적으로 업로드 되었을 때 - `위시리스트에 담았습니다`
        - 이미 위시리스트에 담긴 상품일 때 - `이미 추가된 상품입니다`
    - 네트워크 통신
        - 통신이 실패하여 상품을 불러오지 못했을 때 - `잠시 후 다시 시도해주세요`
        - api 호출 횟수 초과되었을 때 - `잠시 후 다시 시도해주세요`
6. **랜덤 상품 표시**
    - '다른 상품 보기' 버튼
        - 버튼을 누를 때마다 `getRandomNumber` 함수를 사용하여 랜덤한 `productId`를 사용해서 랜덤한 상품을 가져와 화면에 표시합니다.
