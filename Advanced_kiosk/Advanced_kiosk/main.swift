//
//  Main.swift
//  Advanced_kiosk
//
//  Created by t2023-m0035 on 12/4/23.
//

func notice() {
    print("""
    [ SHAKESHACK MENU ]

    1. Burgers
    2. Frozen Custard
    3. Drinks
    4. Beer

    0. 프로그램 종료             
    
    """)
    print("번호를 입력하세요 -> ", terminator: "")
}

notice()

while let input = readLine() {
   
    let n = Int(input)!
    switch n {
        case 0 :
            print("프로그램을 종료합니다.")
            exit(0)
        case 1:
            Order().orderMenu(type: .burgers)
        case 2:
            Order().orderMenu(type: .frozencustard)
        case 3:
            Order().orderMenu(type: .drinks)
        case 4:
            Order().orderMenu(type: .beer)
        default:
            print("잘 못 입력하셨습니다. 다시 입력해주세요.")
    }
}
