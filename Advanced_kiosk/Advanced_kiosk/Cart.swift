//
//  Cart.swift
//  Advanced_kiosk
//
//  Created by t2023-m0035 on 12/6/23.
//

var isCartEmpty: Bool = true
var cartList: [CartItem] = []

class Cart {
    
    func printCheckInputCart(name: String) {
        print("""
        --------------------------------------------------------
        
            \(name)
            위 메뉴를 장바구니에 추가하시겠습니까?
              1. 확인        2. 취소
        
        """)
        print("번호를 입력하세요 -> ", terminator: "")
    }
    
    func checkInputCart(option: CartItem, _ mainInstance: Main) {
        printCheckInputCart(name: option.name)
        
        if let choice = readInt() {
            switch choice {
            case 1:
                cartList.append(option)
                isCartEmpty = false
                print("""
                --------------------------------------------------------
                    [ \(option.name) ] 가 장바구니에 추가되었습니다.
                """)
                mainInstance.kiosk()
            case 2:
                print("취소하였습니다.")
                mainInstance.kiosk()
            default:
                ERROR_input()
            }
        }
    }
    
}
