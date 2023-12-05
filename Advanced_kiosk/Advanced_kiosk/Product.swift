//
//  Product.swift
//  Advanced_kiosk
//
//  Created by t2023-m0035 on 12/6/23.
//

struct CartItem {
    var name: String
    var price: Double
    var info: String
}

enum Product: String {
    case burgers = "Burgers"
    case frozencustard = "Frozen Custard"
    case drinks = "Drinks"
    case beer = "Beer"
    
    var name: String { rawValue }
    
    var productName: [String] {
        switch self {
            case .burgers:
                return Burgers.allCases.map { $0.menuName }
            case .frozencustard:
                return FrozenCustard.allCases.map { $0.menuName }
            case .drinks:
                return Drinks.allCases.map { $0.menuName }
            case .beer:
                return Beer.allCases.map { $0.menuName }
        }
    }
    
    var productPrice: [Double] {
        switch self {
            case .burgers:
                return Burgers.allCases.map { $0.menuPrice }
            case .frozencustard:
                return FrozenCustard.allCases.map { $0.menuPrice }
            case .drinks:
                return Drinks.allCases.map { $0.menuPrice }
            case .beer:
                return Beer.allCases.map { $0.menuPrice }
        }
    }
    
    var productInfo: [String] {
        switch self {
            case .burgers:
                return Burgers.allCases.map { $0.menuInfo }
            case .frozencustard:
                return FrozenCustard.allCases.map { $0.menuInfo }
            case .drinks:
                return Drinks.allCases.map { $0.menuInfo }
            case .beer:
                return Beer.allCases.map { $0.menuInfo }
        }
    }
    
    enum Burgers: String, CaseIterable {
        case shackBurger = "ShackBurger"
        case smokeShack = "SmokeShack"
        case shroomBurger = "Shroom Burger"
        case cheeseburger = "Cheeseburger"
        case hamburger = "Hamburger"
        
        var menuName: String { rawValue }
        
        var menuPrice: Double {
            switch self {
            case .shackBurger:
                return 6.9
            case .smokeShack:
                return 8.9
            case .shroomBurger:
                return 9.4
            case .cheeseburger:
                return 6.9
            case .hamburger:
                return 5.4
            }
        }
        
        var menuInfo: String {
            switch self {
            case .shackBurger:
                return "토마토, 양상추, 쉑소스가 토핑된 치즈버거"
            case .smokeShack:
                return "베이컨, 체리 페퍼에 쉑소스가 토핑된 치즈버거"
            case .shroomBurger:
                return "몬스터 치즈와 체다 치즈로 속을 채운 베지테리안 버거"
            case .cheeseburger:
                return "포테이토 번과 비프패티, 치즈가 토핑된 치즈버거"
            case .hamburger:
                return "비프패티를 기반으로 야채가 들어간 기본버거"
            }
        }
    }
    enum FrozenCustard: String, CaseIterable {
        case shake = "Shake"
        case shakeOfTheWeek = "Shake of the Week"
        case redBeanShake = "Red Bean Shake"
        case floats = "Floats"
        case cupNcons = "Cups & Cones"
        case concretes = "Concretes"
        
        var menuName: String { rawValue }
        
        var menuPrice: Double {
            switch self {
            case .shake:
                return 5.9
            case .shakeOfTheWeek:
                return 6.5
            case .redBeanShake:
                return 6.5
            case .floats:
                return 5.9
            case .cupNcons:
                return 4.9
            case .concretes:
                return 5.9
            }
        }
        
        var menuInfo: String {
            switch self {
            case .shake:
                return "바닐라, 초콜렛, 솔티드 카라멜, 블랙 & 화이트,스토로 베리,피넛버터, 커피"
            case .shakeOfTheWeek:
                return "특별한 커스터드 플레이버"
            case .redBeanShake:
                return "신선한 커스터드와 함께 우유와 레드빈이 블렌딩 된 시즈널 쉐이크"
            case .floats:
                return "루트비어, 퍼플 카우, 크림시클"
            case .cupNcons:
                return "바닐라, 초콜렛, Flavor of the Week"
            case .concretes:
                return "쉐이크쉐의 쫀득한 커스터드와 다양한 믹스-인의 조합"
            }
        }
    }
    enum Drinks: String, CaseIterable {
        case shackMadeLemonade = "Shake-made Lemonade"
        case freshBrewedIcedTea = "Fresh Brewed Iced Tea"
        case fiftyFifty = "FiftyFifty"
        case fountainSoda = "Fountation"
        case abitaRootBeer = "Abita Root Beer"
        case bottledWater = "Bottled Water"
        
        var menuName: String { rawValue }
        
        var menuPrice: Double {
            switch self {
            case .shackMadeLemonade:
                return 4.5
            case .freshBrewedIcedTea:
                return 3.9
            case .fiftyFifty:
                return 4.4
            case .fountainSoda:
                return 3.3
            case .abitaRootBeer:
                return 4.4
            case .bottledWater:
                return 1.0
            }
        }
        
        var menuInfo: String {
            switch self {
            case .shackMadeLemonade:
                return "매장에서 직접 만드는 상큼한 레몬에이드 (오리지날/시즈널)"
            case .freshBrewedIcedTea:
                return "직접 유기농 홍차를 우려낸 아이스티"
            case .fiftyFifty:
                return "레몬에이드와 아이스티의 만남"
            case .fountainSoda:
                return "코카콜라, 코카콜라 제로, 스프라이트, 환타오렌지, 환타 그레이프"
            case .abitaRootBeer:
                return "청량감 있는 독특한 미국식 무알콜 탄산음료"
            case .bottledWater:
                return "지리산 암반대수층으로 만든 프리미엄 생수"
            }
        }
    }
    enum Beer: String, CaseIterable {
        case shackmeisterAle = "ShackMeister Ale"
        case magpieBrewingCo = "Magpie Brewing Co."
        
        var menuName: String { rawValue }
        
        var menuPrice: Double {
            switch self {
            case .shackmeisterAle:
                return 9.8
            case .magpieBrewingCo:
                return 6.8
            }
        }
        
        var menuInfo: String {
            switch self {
            case .shackmeisterAle:
                return "쉐이크식 버거를 위해 뉴욕 브루클린 브루어리에서 특별히 양조한 에일 맥주"
            case .magpieBrewingCo:
                return "Pale Ale, Draft"
            }
        }
    }

}
