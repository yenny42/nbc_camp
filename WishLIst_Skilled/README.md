# 📋 WISH LIST <br/> 앱개발 숙련 강의 실습

<!--
## 폴더링


## UI 디자인
-->

## 폴더링
### WishList_skilled

  - **`Global`** 
    - `Components` : 재사용 가능한 컴포넌트

    - `Supports` : 전역적으로 사용되는 리소스

  - **`Presentation`** : 화면 표시와 관련된 요소

    - `Main.storyboard`
    - `ViewController` : UI, 이벤트 처리
    - `View` : UI를 통한 사용자 응답, 애니메이션
    - `Model` : 데이터를 정의, 저장
      - `CoreData` : 코어 데이터 Entity

    - `Networking`: 외부 API 통신

<br/>

## 기술 스택
- 언어 - `Swift`
- 프레임워크 - `UIKit, Core Data`
- 네트워크 통신 - `URLSession`

<br/>

## 디자인
<img src="https://github.com/yenny42/nbc_camp/assets/107637741/9e74fe0a-5c53-4d68-82be-740bd9a64fa1" height="500"/>
<img src="https://github.com/yenny42/nbc_camp/assets/107637741/114d34a3-80bc-4878-8e9b-8216a5f59d68" height="500"/>
<img src="https://github.com/yenny42/nbc_camp/assets/107637741/74fc4ab6-7da7-439e-bce6-70d5555ba40f" height="500"/>
<img src="https://github.com/yenny42/nbc_camp/assets/107637741/f8f1b4b8-4445-4708-9c48-fa1bc23d60fc" height="500"/>
<img src="https://github.com/yenny42/nbc_camp/assets/107637741/2c70d83f-82a7-4637-a5f7-2551af654d8f" height="500"/>
<!-- 
![Simulator Screenshot - iPhone 15 Pro - 2024-01-06 at 17 18 37](https://github.com/yenny42/nbc_camp/assets/107637741/9e74fe0a-5c53-4d68-82be-740bd9a64fa1)
![Simulator Screenshot - iPhone 15 Pro - 2024-01-05 at 19 47 47](https://github.com/yenny42/nbc_camp/assets/107637741/114d34a3-80bc-4878-8e9b-8216a5f59d68) 
![Simulator Screenshot - iPhone 15 Pro - 2024-01-06 at 17 05 53](https://github.com/yenny42/nbc_camp/assets/107637741/74fc4ab6-7da7-439e-bce6-70d5555ba40f)
![Simulator Screenshot - iPhone 15 Pro - 2024-01-06 at 17 05 58](https://github.com/yenny42/nbc_camp/assets/107637741/f8f1b4b8-4445-4708-9c48-fa1bc23d60fc)
![Simulator Screenshot - iPhone 15 Pro - 2024-01-06 at 17 06 40](https://github.com/yenny42/nbc_camp/assets/107637741/2c70d83f-82a7-4637-a5f7-2551af654d8f)
-->

<br/><br/>

## 구조 및 설계

MVC (Model-View-Controller) 아키텍처를 따르고 있습니다.

1. **Model (데이터 모델)**

    - Product Request Model
      
      ``` swift
      struct Product: Decodable { 
          let id: Int
          let title: String
          let description: String
          let price: Int
          let brand: String
          let thumbnail: String
      }
      ```
      
    - **`WishListItem`** :  Core Data Entity

        | **Attribute** | **Type** |
        | --- | --- |
        | `id` | UUID |
        | `productId` | Int |
        | `name` | String |
        | `price` | Int |
         | `desc` | String |
        | `brand` | String |

<br/>

2. **View (뷰)**

    - **`ProductView` :  UIView**
        - 상품 정보 UI
          - UIStackView
          - UILabel
          - UIImageView<br/><br/>
    - **`ProductButtonView` :  UIView**
        - 하단 버튼 UI
          - UIStackView
          - UIButton<br/><br/>

      ``` swift
        위시리스트 담기 - 보고 있는 상품 Core Data 업로드
        다른상품 보기 - 랜덤 productId 로 apiRequest
        위시리스트 보기 - WishListViewController 화면 전환
      ```

<br/>
 
<!-- 
![스크린샷 2024-01-05 오전 10 17 38](https://github.com/yenny42/nbc_camp/assets/107637741/300f2295-c7c0-464b-979a-b8a2887ca240) -->


3. **Controller (컨트롤러)**

    - **`ProductViewController`** :  **ViewController**
        - 상품 정보 UI
        - `UIStackView` 
    - **`WishListViewController`** : **ViewController**
        - 위시리스트 UI
        - `UITableView, UITableViewCell`

<br/>

4. **네트워크 통신**
    - `URLSession`
      - 랜덤하게 상품 노출

      #### ProductRequest.swift
      ``` swift
        import Foundation
        
        class ProductRequests {
            static func decodeProduct(completion: @escaping (Result<Product, Error>) -> Void) {
                
                let productID: Int = Int.random(in: 1 ... 100)
                    
                if let url = URL(string: "https://dummyjson.com/products/\(productID)") {
                    let task = URLSession.shared.dataTask(with: url) { (data, res, error) in
                        if let error = error {
                            completion(.failure(error))
                            return
                        }
                        else if let data = data {
                            do {
                                let product = try JSONDecoder().decode(Product.self, from: data)
                                completion(.success(product))
                            } catch {
                                completion(.failure(error))
                            }
                        }
                    }
                    
                    task.resume()
                }
            }
        }
      ```

    
      #### ProductVC.swift
      ``` swift
        func fetchInitialData() {
            ProductRequests.decodeProduct { result in
                DispatchQueue.main.async {
                    
                    self.productView.hideSkeletonView()
                    
                    switch result {
                        case .success(let product):
                            self.productView.updateUIWithProduct(product)
                        case .failure(let error):
                            print("Error decoding product: \(error)")
                    }
                }
            }
        }
      ```
    

<br/>

