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
    
//    MARK: - function
    func checkDouble(value: Double) -> Bool {
        return value.truncatingRemainder(dividingBy: 1.0) == 0 ? true : false
    }
    
//    MARK: - IBAction
    
    @IBAction func didTapNumButton(_ sender: UIButton) {
        curreuntDisplay += sender.currentTitle!
        numberValue[1] = Double(curreuntDisplay)!
        
        if operatorSign != "" {
            let result = calculator.calculate(numberValue, operatorSign)
            numberValue[0] = result
            
            displayLable.text = checkDouble(value: numberValue[0]) ? String(Int(numberValue[0])) : String(numberValue[0])
            
            numberValue[1] = 0
        }
        
        displayLable.text = curreuntDisplay
    }
        
    @IBAction func didTapCalculateButton(_ sender: UIButton) {
        
        operatorSign = sender.currentTitle!
        
        if numberValue[1] == 0 { numberValue[1] = 1 }
        if numberValue[0] == 0 { numberValue = [numberValue[1], 1] }
        if (operatorSign == "+" || operatorSign == "-") { numberValue[1] = 0 }
        if numberValue[0] == 0 { numberValue = [numberValue[1], 0] }
        
        let result = calculator.calculate(numberValue, operatorSign)
        numberValue[0] = result
        
        displayLable.text = checkDouble(value: numberValue[0]) ? String(Int(numberValue[0])) : String(numberValue[0])
            
        curreuntDisplay = ""
        
    }
    
    @IBAction func didTapClearButton(_ sender: UIButton) {
//        변수 전체 초기화
        curreuntDisplay = ""
        displayLable.text = "0"
        numberValue = [0,0]
        operatorSign = ""
    }
    
    @IBAction func didTapEqualSignButton(_ sender: UIButton) {
        displayLable.text = checkDouble(value: numberValue[0]) ? String(Int(numberValue[0])) : String(numberValue[0])
        curreuntDisplay = ""
    }
    
}


// MARK: - Class Calculator
class Calculator {
    var add = AddOperation()
    var sub = SubtractOperation()
    var mul = MultiplyOperation()
    var div = DivideOperation()
    
    func calculate(_ numbers: [Double], _ operatorType: String) -> Double {
        
        var returnResult: Double = 0
        switch operatorType {
            case "":
                return 0
            case "+":
                returnResult = add.operate(numbers)
            case "-":
                returnResult = sub.operate(numbers)
            case "x":
                returnResult = mul.operate(numbers)
            case "÷":
                returnResult = div.operate(numbers)
            default:
                break
        }
        
        return returnResult
    }
}
// MARK: - Calculator Protocol
protocol CalculatorProtocol {
    func operate(_ number: [Double]) -> Double
}
class AddOperation: CalculatorProtocol {
    func operate(_ numbers:[Double]) -> Double {
        print("더하기 \(numbers[0] + numbers[1])")
        return numbers[0] + numbers[1]
    }
}
class SubtractOperation: CalculatorProtocol {
    func operate(_ numbers:[Double]) -> Double {
        print("빼기 \(numbers[0] - numbers[1])")
        return numbers[0] - numbers[1]
    }
}
class MultiplyOperation: CalculatorProtocol {
    func operate(_ numbers:[Double]) -> Double {
        print("곱하기 \(numbers[0] * numbers[1])")
        return numbers[0] * numbers[1]
    }
}
class DivideOperation: CalculatorProtocol {
    func operate(_ numbers:[Double]) -> Double {
        print("나누기 \(numbers[0] / numbers[1])")
        return numbers[0] / numbers[1]
    }
}
