//
//  ViewController.swift
//  Basic_Calculator
//
//  Created by t2023-m0035 on 11/27/23.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
//    MARK: - IBOutlet
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var numButton: UIButton!
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var displayLable: UILabel!
    @IBOutlet weak var equalSignButton: UIButton!
    
    //    MARK: - 변수
    var curreuntDisplay = "" // 내가 지금 입력한 값을 보여주기 위한 문자열
    var numberValue: [Double] = [0,0] // 입력받은 값
    var operatorSign = "" // 입력받은 연산자
    var calculator = Calculator() // 계산 클래스
    
//    MARK: - view load
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
//    MARK: - IBAction
    
    @IBAction func didTapNumButton(_ sender: UIButton) {
        curreuntDisplay += sender.currentTitle!
        numberValue[1] = Double(curreuntDisplay)!
        
        if operatorSign != "" {
            let result = calculator.calculate(numberValue, operatorSign)
            numberValue[0] = result
            
            displayLable.text = calculator.checkDouble(value: result) ? String(Int(result)) : String(result)
            
            numberValue[1] = 0
        }
        
        displayLable.text = curreuntDisplay
        
        print(numberValue)
    }
        
    @IBAction func didTapCalculateButton(_ sender: UIButton) {
        
        operatorSign = sender.currentTitle!
        
        if numberValue[1] == 0 { numberValue[1] = 1 }
        if numberValue[0] == 0 { numberValue = [numberValue[1], 1] }
        if (operatorSign == "+" || operatorSign == "-") { numberValue[1] = 0 }
        if numberValue[0] == 0 { numberValue = [numberValue[1], 0] }
        
        let result = calculator.calculate(numberValue, operatorSign)
        numberValue[0] = result
        
        displayLable.text = calculator.checkDouble(value: result) ? String(Int(result)) : String(result)
            
        curreuntDisplay = ""
        
    }
    
//    초기화
    @IBAction func didTapClearButton(_ sender: UIButton) {
        curreuntDisplay = ""
        displayLable.text = "0"
        numberValue = [0,0]
        operatorSign = ""
    }
    
//
    @IBAction func didTapEqualSignButton(_ sender: UIButton) {
        displayLable.text = calculator.checkDouble(value: numberValue[0]) ? String(Int(numberValue[0])) : String(numberValue[0])
        curreuntDisplay = ""
    }
    
}

// MARK: - Class Calculator
class Calculator {
    
    func calculate(_ numbers: [Double], _ operatorType: String) -> Double {
        
        var returnResult: Double = 0
        
        switch operatorType {
        case "+":
            returnResult = numbers[0] + numbers[1]
        case "-":
            returnResult = numbers[0] - numbers[1]
        case "x":
                returnResult = numbers[0] * numbers[1]
        case "÷":
                returnResult = numbers[0] / numbers[1]
        default:
            break
        }
        
        print("result - \(returnResult)")
        return returnResult
    }
    
    func checkDouble(value: Double) -> Bool {
        return value.truncatingRemainder(dividingBy: 1.0) == 0 ? true : false
    }
}