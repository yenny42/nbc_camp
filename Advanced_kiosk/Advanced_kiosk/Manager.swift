//
//  Manager.swift
//  Advanced_kiosk
//
//  Created by t2023-m0035 on 12/4/23.
//

import Foundation

class Order {
    
    func orderMenu(type:Product) {
        noticeMenu(type: type)
        outerLoop: while let input = readLine(){
            let userInput = Int(input)!
            let productInfo: [Any] = [type.productName[userInput - 1], type.productPrice[userInput - 1]]
            
            print("""
                    [ \(type.productName[userInput - 1]) ] 상품을 선택하셨습니다.
                    가격은 \(type.productPrice[userInput - 1])w 입니다.
                    
                    장바구니에 담으시겠습니까?
                    1. 확인       2. 취소
                """)
            print("장바구니에 담을 데이터 체크 -> \(productInfo)")
            
            while let input2 = readLine(){
                if Int(input2)! == 2 {
                    print("===== 취소하였습니다.")
                    print("")
                    break outerLoop
                    
                } else if Int(input2)! == 1 {
                    print("===== 장바구니에 담았습니다.")
                    print("")
                    break outerLoop
                } else { break }
            }
            
        }
        notice()
    }
}

func noticeMenu(type: Product) {
    print(" ")
    print(" ====== \(type.name) =======")
    print(" ")
    for i in 0 ..< type.productName.count {
        print("\(i+1). \(type.productName[i]) - \(type.productPrice[i])w")
    }
    print(" ")
    print("""
          0. 뒤로가기
          =============================
          상품 번호를 골라주세요 ->
          """, terminator: "")
}
