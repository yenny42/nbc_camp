//
//  ProductRequest.swift
//  WishLIst_Skilled
//
//  Created by t2023-m0035 on 1/5/24.
//

import Foundation

class ProductRequests {
    
    // static 키워드
    // = 클래스의 인스턴스를 생성하지 않고도 호출할 수 있는 메서드나 프로퍼티를 정의
    // - 클래스 자체에서 직접 메서드를 호출할 수 있음
    // - 특정 인스턴스에 의존하지 않고 타입 자체에 속한다
    static func decodeProduct(completion: @escaping (Result<Product, Error>) -> Void) {
        
        let productID: Int = Int.random(in: 1 ... 100)
        
        // if let
        // - 옵셔널 바인딩
        // - 옵셔널 바인딩은 옵셔널 값이 nil이 아닌 경우에만 코드 블록을 실행
            
        if let url = URL(string: "https://dummyjson.com/products/\(productID)") {
            
            // shared 인스턴스
            // - URLSession 클래스의 공유 인스턴스
            // - 앱 전역에서 공유되는 동일한 URLSession을 사용하여 네트워크 작업을 수행할 수 있음
            // - 단일 앱 내에서 전역적으로 사용되는 네트워킹 작업에 대해 편리함
            
            // dataTask(with:completionHandler:)
            // - 비동기로 데이터를 다운로드하고 완료될 때 특정 핸들러를 호출
            // 전달되는 정보 : 다운로드한 데이터, 응답, 발생한 에러
            let task = URLSession.shared.dataTask(with: url) { (data, res, error) in
                if let error = error {
                    
                    // URLSession에서 발생한 네트워크 관련 에러
                    // - URLSessionDataTask가 완료되지 못하거나 데이터를 받아오는 동안 어떤 문제가 발생했을 때 발생
                    // - 네트워크 연결이 없거나 서버에 접속할 수 없는 경우, 타임아웃이 발생한 경우
                    
                    // completion(.failure(error))
                    // - 클로저의 completion 매개변수에 Result 형태로 에러를 전달
                    // Result 열거형
                    // -  네트워크 요청이나 다른 비동기 작업에서 성공 또는 실패와 관련된 값을 나타낼 때 사용
                    // 1) .success(value): 비동기 작업이 성공하면 성공과 연관된 값 전달
                    // 2) .failure(error): 비동기 작업이 실패하면 실패와 연관된 에러 전달
                    completion(.failure(error))
                    return
                }
                else if let data = data {
                    do {
                        // JSONDecoder
                        // - Codable 프로토콜을 준수하는 타입을 JSON 데이터로 디코딩하기 위한 클래스
                        
                        // try 키워드
                        // - 오류가 발생할 가능성이 있는 코드 블록에 사용
                        // - 만약 오류가 발생하면 catch 블록으로 이동하여 오류를 처리
                        
                        // decode 메소드
                        // - 첫 번째 매개변수: 디코딩하려는 결과의 타입 (Decodable 프로토콜 준수해야 함)
                        // - 두 번째 매개변수: 디코딩할 JSON 데이터
                        
                        // 디코딩 실패할 수도 있으니까 try - catch 사용해서 걸러줌
                        let product = try JSONDecoder().decode(Product.self, from: data)
                        completion(.success(product))
                    } catch {
                        
                        // try의 에러처리
                        completion(.failure(error))
                    }
                }
            }
            
            task.resume()
        }
    }
}
