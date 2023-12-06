//
//  Menu.swift
//  Advanced_kiosk
//
//  Created by t2023-m0035 on 12/6/23.
//

class Menu {
    func printDetailMenu(options: Product) {
        print("""
              --------------------------------------------------------
              
              ========= [ \(options.name) MENU ] =========
              
              """)
        
        for i in 0 ..< options.productName.count {
            print("\(i+1). \(options.productName[i])       | \(options.productPrice[i])w | \(options.productInfo[i])")
        }
        
        print("""
        
        0. 뒤로가기
        
        """)
        print("번호를 입력하세요 -> ", terminator: "")
    }

    func detailMenu(options: Product) {
        printDetailMenu(options: options)
        
        while let choice = readInt() {
            switch choice {
                case 1 ... options.productName.count :
                    let index = choice - 1
                    let data: CartItem = CartItem(name: options.productName[index], price: options.productPrice[index], info: options.productInfo[index])
                    
                    Cart().checkInputCart(option: data)
                case 0:
                    Main().kiosk()
                default:
                    ERROR_input()
                    continue
            }
            break
        }
    }
}

class Category: Menu {
    var menuOptions: Product
        
    init(menuOptions: Product) {
        self.menuOptions = menuOptions
    }
    
    func detailMenu() {
        detailMenu(options: menuOptions)
    }
}

class Burgers: Category {
    init() {
        super.init(menuOptions: .burgers)
    }
}

class FrozenCustard: Category {
    init() {
        super.init(menuOptions: .frozencustard)
    }
}

class Drinks: Category {
    init() {
        super.init(menuOptions: .drinks)
    }
}

class Beer: Category {
    init() {
        super.init(menuOptions: .beer)
    }
}
