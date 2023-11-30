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
    var equalOpeSign = ""
    
//    MARK: - view load
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
//    MARK: - function
    func checkDouble(value: Double) -> Bool {
        return value.truncatingRemainder(dividingBy: 1.0) == 0 ? true : false
    }
    
    func basicOperations(_ operatorType: String) {
        
        if numberValue[0] != 0 && numberValue[1] != 0 {
            let result = calculator.calculate(numberValue, operatorType)
            print("결과값 도출 -> \(result)")
            
            numberValue = [result, 0]
            displayLable.text = checkDouble(value: numberValue[0]) ? String(Int(numberValue[0])) : String(numberValue[0])
            
            curreuntDisplay = ""
            
        }
    }
    
//    MARK: - IBAction
    
    @IBAction func didTapNumButton(_ sender: UIButton) {
        curreuntDisplay += sender.currentTitle!
        displayLable.text = curreuntDisplay
    }
        
    @IBAction func didTapCalculateButton(_ sender: UIButton) {
        equalOpeSign = sender.currentTitle!
        
        if numberValue[0] == 0 && curreuntDisplay != "" {
            numberValue[0] = numberValue[1]
            numberValue[1] = Double(curreuntDisplay)!
            
            basicOperations(operatorSign)
        } else {
            numberValue[0] == 0 ? (numberValue[0] = Double(curreuntDisplay)!) : (numberValue[1] = (curreuntDisplay != "" ? Double(curreuntDisplay)! : 0))
                    
            basicOperations(operatorSign)
        }
                
        curreuntDisplay = ""
        operatorSign = sender.currentTitle!
    }
    
    @IBAction func didTapClearButton(_ sender: UIButton) {
//        변수 전체 초기화
        curreuntDisplay = ""
        displayLable.text = "0"
        numberValue = [0,0]
        operatorSign = ""
    }
    
    @IBAction func didTapEqualSignButton(_ sender: UIButton) {
        
        if numberValue[1] == 0 && curreuntDisplay != "" {
            numberValue[1] = Double(curreuntDisplay)!
        } else {
            numberValue[0] = numberValue[1]
            numberValue[1] = Double(curreuntDisplay)!
        }
        
        basicOperations(equalOpeSign)
    }
    
}


// MARK: - Class Calculator
class Calculator {
    var add = AddOperation()
    var sub = SubtractOperation()
    var mul = MultiplyOperation()
    var div = DivideOperation()
    var rem = RemainderOperation()
    
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
            case "%":
                returnResult = rem.operate(numbers)
            default:
                break
        }
        
        return returnResult
    }
}
// MARK: - AbstractOperation Override
class AbstractOperation {
    func operate(_ numbers:[Double]) -> Double {
        return numbers[0] + numbers[1]
    }
}
class AddOperation: AbstractOperation {
    override func operate(_ numbers: [Double]) -> Double {
        return numbers[0] + numbers[1]
    }
}
class SubtractOperation: AbstractOperation {
    override func operate(_ numbers: [Double]) -> Double {
        return numbers[0] - numbers[1]
    }
}
class MultiplyOperation: AbstractOperation {
    override func operate(_ numbers:[Double]) -> Double {
        return numbers[0] * numbers[1]
    }
}
class DivideOperation: AbstractOperation {
    override func operate(_ numbers:[Double]) -> Double {
        return numbers[0] / numbers[1]
    }
}
class RemainderOperation: AbstractOperation {
    override func operate(_ numbers: [Double]) -> Double {
        let value = numbers[0].truncatingRemainder(dividingBy: numbers[1])
        return value
    }
}
