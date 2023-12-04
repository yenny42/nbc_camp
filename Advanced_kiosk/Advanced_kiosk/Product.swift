//
//  Product.swift
//  Advanced_kiosk
//
//  Created by t2023-m0035 on 12/4/23.
//

import Foundation

class Menu {
    var name: String = ""
    var price: Decimal = 0
}
class Cart: Menu {
    var count: Int = 0
}

//enum MainMenu: String {
//    case burgers = "Burgers"
//    case frozencustard = "Frozen Custard"
//    case drinks = "Drinks"
//    case beer = "Beer"
//    
//    var name: String { rawValue }
//}

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
    
    var productPrice: [Decimal] {
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
    
    enum Burgers: String, CaseIterable {
        case hamburger = "Hamburger"
        case cheeseburger = "Cheese Burger"
        case baconBurger = "Bacon Burger"
        case baconCheeseburger = "Bacon Cheese Burger"
        
        var menuName: String { rawValue }
        
        var menuPrice: Decimal {
            switch self {
            case .hamburger:
                return 13.4
            case .cheeseburger:
                return 14.9
            case .baconBurger:
                return 15.9
            case .baconCheeseburger:
                return 17.4
            }
        }
    }
    enum FrozenCustard: String, CaseIterable {
        case shakers = "Shakers"
        case shakeOfTheWeek = "Shake of the Week"
        case redBeanShake = "Red Bean Shake"
        case floats = "Floats"
        
        var menuName: String { rawValue }
        
        var menuPrice: Decimal {
            switch self {
            case .shakers:
                return 5.9
            case .shakeOfTheWeek:
                return 6.5
            case .redBeanShake:
                return 6.5
            case .floats:
                return 5.9
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
        
        var menuPrice: Decimal {
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
    }
    enum Beer: String, CaseIterable {
        case shackmeisterAle = "ShackMeister Ale"
        case magpieBrewingCo = "Magpie Brewing Co."
        
        var menuName: String { rawValue }
        
        var menuPrice: Decimal {
            switch self {
            case .shackmeisterAle:
                return 9.8
            case .magpieBrewingCo:
                return 6.8
            }
        }
    }

}
