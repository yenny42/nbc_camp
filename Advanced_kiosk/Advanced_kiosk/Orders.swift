//
//  Orders.swift
//  Advanced_kiosk
//
//  Created by t2023-m0035 on 12/6/23.
//

import Foundation

var wallet: Double = 20
var allPrice: Double = 0

class Orders {
    
    static func printOrders() {
        
        print("""
              --------------------------------------------------------
              
              [ Orders ]
              """)
        
        for cartItem in cartList {
            print("\(cartItem.name)  |  \(cartItem.price)  |  \(cartItem.info)")
        }
        
        print("""
        
        [ Total ]
        W \(round100(allPrice))

        1. 주문      2. 메뉴판
        """)
        print("번호를 입력하세요 -> ", terminator: "")
    }
    
    func processOrders(_ mainInstance: Main) {
        
//       TODO: 변수명 바꾸는게 좋을듯
        let priceArr = cartList.map {$0.price}
        allPrice = priceArr.reduce(0) { $0 + $1 }
        
        Orders.printOrders()
        
        let price = round100(wallet - allPrice)
        
        if let choice = readInt() {
            switch choice {
                case 1:
    
                    if price < 0 {
                        print("현재 잔액은 \(round100(wallet))W 으로 \(-round100(price))W이 부족해서 주문할 수 없습니다.")
                    } else {
                        wallet = price
                        cartList.removeAll()
                        isCartEmpty = true
                        allPrice = 0
                        print("""
                        --------------------------------------------------------
                        
                        구매를 완료했습니다.
                        
                        """)
                    }
                    mainInstance.kiosk()
                case 2:
                    print("메뉴판으로 돌아갑니다.")
                    mainInstance.kiosk()
                default:
                    ERROR_input()
            }
        }
    }
    
    func cancelOrders() {
        cartList.removeAll()
        isCartEmpty = true
        allPrice = 0
        print("주문을 취소했습니다.")
    }
}
