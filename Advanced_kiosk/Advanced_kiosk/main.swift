//
//  main.swift
//  Advanced_kiosk
//
//  Created by t2023-m0035 on 12/5/23.
//

import Foundation

class Main {
    func printMainMenu() {
        // 메인 메뉴 출력
        print("""
        --------------------------------------------------------
        
        [ SHAKESHACK MENU ]

        1. Burgers         | 앵거스 비프 통살을 다져만든 버거
        2. Frozen Custard  | 매장에서 신선하게 만드는 아이스크림
        3. Drinks          | 매장에서 직접 만드는 음료
        4. Beer            | 뉴욕 브루클린 브루어리에서 양조한 맥주

        0. 프로그램 종료
        
        """)
        if !isCartEmpty {
            print("""
            [ ORDER MENU ]
            5. Order       | 장바구니를 확인 후 주문합니다.
            6. Cancel      | 진행중인 주문을 취소합니다.
            
            """)
        }
        print("잔액 : W \(round100(wallet))")
        print("번호를 입력하세요 -> ", terminator: "")
    }

    let burgers = Burgers()
    let frozenCustard = FrozenCustard()
    let drinks = Drinks()
    let beer = Beer()
    let orders = Orders()
    
    func kiosk() {
        print("""
        
        \"SHAKESHACK BURGER 에 오신걸 환영합니다.\"
        아래 메뉴판을 보시고 메뉴를 골라 입력해주세요.
        
        """)
        
        while true {
            printMainMenu()
            
            while let choice = readInt() {
                switch choice {
                case 1:
                    burgers.detailMenu(mainInstance: self)
                case 2:
                    frozenCustard.detailMenu(mainInstance: self)
                case 3:
                    drinks.detailMenu(mainInstance: self)
                case 4:
                    beer.detailMenu(mainInstance: self)
                case 0:
                    print("✂️")
                    print("----- 키오스크를 종료합니다 -----")
                    exit(0)
                default:
                    if !isCartEmpty {
                        if choice == 5 {
                            orders.processOrders()
                        } else if choice == 6 {
                            orders.cancelOrders()
                            self.kiosk()
                        } else {
                            ERROR_input()
                            continue
                        }
                    } else {
                        ERROR_input()
                        continue
                    }
                }
            }
        }
    }
}

func isAlphabet(_ str: String) -> Bool {
  for char in str {
    if !char.isLetter { return false }
  }
  return true
}

func readInt() -> Int? {
    var result: Int? = 0
    
    while let input = readLine() {
        
        if isAlphabet(input) {
            print("""
        
            ERROR : 문자는 입력할 수 없습니다.
        
        """)
        } else {
            result = Int(input)
            break
        }
    }
    
    return result
}

func ERROR_input() {
    print("잘못된 번호를 누르셨습니다. 다시 입력해주세요.")
}

func round100(_ data: Double) -> Double {
    return round(data * 100) / 100
}

let kiosk = Main()
kiosk.kiosk()
