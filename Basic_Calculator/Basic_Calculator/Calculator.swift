//
//  Calculator.swift
//  계산 기능
//  Basic_Calculator
//
//  Created by t2023-m0035 on 12/1/23.
//

import Foundation

// MARK: - Class Calculator
class Calculator {
    
    private var abstractOperation: AbstractOperation
    
    init(abstractOperation: AbstractOperation) {
        self.abstractOperation = abstractOperation
    }
    
    func setOperation(operation: AbstractOperation) {
        self.abstractOperation = operation
    }
    func calculate(_ numbers: [Double], _ operatorType: String) -> Double {
        abstractOperation.operate(numbers)
    }
}
// MARK: - AbstractOperation Override
class AbstractOperation {
    func operate(_ numbers:[Double]) -> Double {
        return 0
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
