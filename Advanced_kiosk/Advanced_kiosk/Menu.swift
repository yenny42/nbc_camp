//
//  Menu.swift
//  Advanced_kiosk
//
//  Created by t2023-m0035 on 12/6/23.
//

import Foundation

struct MenuItem {
    var name: String
    var price: Double
    var info: String
}

class Menu {
    let burgers = Burgers()
    let frozenCustard = FrozenCustard()
    let drinks = Drinks()
    let beer = Beer()
    
    var cart: Cart
    
    private var menuListName: String = ""
    private var menuListArr: [MenuItem] = []
    private var menuListCount: Int = 0
    
    private var mainInput: String = "" {
        didSet {
            if mainInput == "1" {
                menuListName = "BURGERS"
                menuListArr = burgers.menuList
                menuListCount = burgers.count
            } else if mainInput == "2" {
                menuListName = "FROZEN CUSTARD"
                menuListArr = frozenCustard.menuList
                menuListCount = frozenCustard.count
            } else if mainInput == "3" {
                menuListName = "DRINKS"
                menuListArr = drinks.menuList
                menuListCount = drinks.count
            } else if mainInput == "4" {
                menuListName = "BEER"
                menuListArr = beer.menuList
                menuListCount = beer.count
            }
        }
    }
    
    private func printMenu() {
        print(" [ \(menuListName) ] ")
        
        for (i, option) in menuListArr.enumerated() {
            print("\(i + 1). \(option.name) | W \(option.price) | \(option.info)")
        }
        
        print("0. 돌아가기")
    }
    
    init(cart: Cart) {
        self.cart = cart
    }   
    
    func showDetailMenu(mainInstance: Main, _ input: String) {
        mainInput = input
        
        func getInput() throws {
           if let choice = readLine() {
               if Int(choice) == nil {
                   print("문자를 입력하셨습니다. 숫자만 입력 가능합니다. 다시 입력해주세요.")
                   try getInput()
               }
               else {
                    let index = Int(choice)! - 1
                    switch choice {
                    case "1" ... "\(menuListCount)":
                        let sendCartData = MenuItem(name: menuListArr[index].name, price: menuListArr[index].price, info: menuListArr[index].info)
                        cart.checkInputCart(mainInstance: mainInstance, cartItem: sendCartData)
                    case "0":
                        print("Main 클래스로 돌아갑니다")
                        mainInstance.kiosk()
                    default:
                        print("다시 입력해주세요 Menu")
                        try getInput()
                    }
               }
           }
       }
        
        do {
            printMenu()
            try getInput()
        } catch {
            print("Err")
        }
    }
}

class Category {
    var menuList: [MenuItem] = []
    var count: Int = 0

    init(menuList: [MenuItem], count: Int) {
        self.menuList = menuList
        self.count = count
    }

    func printOptions(categoryName: String) {
        print(" [ \(categoryName) MENU ] ")
        let count = menuList.count
        for i in 0 ..< count {
            print("\(i+1). \(menuList[i].name) | W \(menuList[i].price) | \(menuList[i].info)")
        }
        print("0. 돌아가기")
    }
}

class Burgers: Category {
    init() {
        super.init(menuList: [
            MenuItem(name: "ShackBurger", price: 6.9, info: "토마토, 양상추, 쉑소스가 토핑된 치즈버거"),
            MenuItem(name: "SmokeShack", price: 8.9, info: "베이컨, 체리 페퍼에 쉑소스가 토핑된 치즈버거"),
            MenuItem(name: "Burger", price: 9.4, info: "몬스터 치즈와 체다 치즈로 속을 채운 베지테리안 버거"),
            MenuItem(name: "Cheeseburger", price: 6.9, info: "포테이토 번과 비프패티, 치즈가 토핑된 치즈버거"),
            MenuItem(name: "Hamburger", price: 5.4, info: "비프패티를 기반으로 야채가 들어간 기본버거")
        ], count: 5)
    }
}

class FrozenCustard: Category {
    init() {
        super.init(menuList: [
            MenuItem(name: "Shake", price: 5.9, info: "바닐라, 초콜렛, 솔티드 카라멜, 블랙 & 화이트,스토로 베리,피넛버터, 커피"),
            MenuItem(name: "Shake of the Week", price: 6.5, info: "특별한 커스터드 플레이버"),
            MenuItem(name: "Red Bean Shake", price: 6.5, info: "신선한 커스터드와 함께 우유와 레드빈이 블렌딩 된 시즈널 쉐이크"),
            MenuItem(name: "Floats", price: 5.9, info: "루트비어, 퍼플 카우, 크림시클"),
            MenuItem(name: "Cups & Cones", price: 4.9, info: "바닐라, 초콜렛, Flavor of the Week"),
            MenuItem(name: "Concretes", price: 5.9, info: "쉐이크쉐의 쫀득한 커스터드와 다양한 믹스-인의 조합")
        ], count: 6)
    }
}

class Drinks: Category {
    init() {
        super.init(menuList: [
            MenuItem(name: "Shack-made Lemonade", price: 3.9, info: "매장에서 직접 만드는 상큼한 레몬에이드 (오리지날/시즈널)"),
            MenuItem(name: "Fresh Brewed Iced Tea", price: 3.4, info: "직접 유기농 홍차를 우려낸 아이스티"),
            MenuItem(name: "Fifty/Fifty", price: 3.5, info: "레몬에이드와 아이스티의 만남"),
            MenuItem(name: "Fountain Soda", price: 2.7, info: "코카콜라, 코카콜라 제로, 스프라이트, 환타오렌지, 환타 그레이프"),
            MenuItem(name: "Abita Root Beer", price: 3.4, info: "청량감 있는 독특한 미국식 무알콜 탄산음료"),
            MenuItem(name: "Bottled Water", price: 1.0, info: "지리산 암반대수층으로 만든 프리미엄 생수")
        ], count: 6)
    }
}

class Beer: Category {
    init() {
        super.init(menuList: [
            MenuItem(name: "ShackMeister Ale", price: 9.8, info: "쉐이크식 버거를 위해 뉴욕 브루클린 브루어리에서 특별히 양조한 에일 맥주"),
            MenuItem(name: "Magpie Brewing Co.", price: 6.8, info: "Pale Ale, Draft")
        ], count: 2)
    }
}
