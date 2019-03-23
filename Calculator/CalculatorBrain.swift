//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Manuel de la Torre on 05/12/16.
//  Copyright © 2016 Manuel de la Torre. All rights reserved.
//

import Foundation

class CalculatorBrain {
    
    private var accumulator = 0.0
    
    private var pendingBinaryOperation: BinaryPendingOperation?
    
    private let operators: Dictionary<String, Operation> = [
        "π": Operation.Constant(M_PI),
        "e": Operation.Constant(M_E),
        "√": Operation.UnaryOperation(sqrt),
        "±": Operation.UnaryOperation({ -$0 }),
        "×": Operation.BinaryOperation({ $0 * $1 }),
        "÷": Operation.BinaryOperation({ $0 / $1 }),
        "+": Operation.BinaryOperation({ $0 + $1 }),
        "−": Operation.BinaryOperation({ $0 - $1 }),
        "=": Operation.Equals
    ]
    
    private enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
    }
    
    func setOperand(value: Double) {
        accumulator = value
    }
    
    func performOperation(symbol: String) -> Double {
        if let operation = operators[symbol] {
            switch operation {
            case .Constant(let value):
                accumulator = value
            case .UnaryOperation(let function):
                accumulator = function(accumulator)
            case .BinaryOperation(let function):
                performPendingBinaryOperation()
                pendingBinaryOperation = BinaryPendingOperation(operation: function, operand: accumulator)
            case .Equals:
                performPendingBinaryOperation()
                pendingBinaryOperation = nil
            }
        }
        return accumulator
    }
    
    private func performPendingBinaryOperation() {
        if (pendingBinaryOperation != nil) {
            let function = pendingBinaryOperation!.operation
            let previousOperand = pendingBinaryOperation!.operand
            accumulator = function(previousOperand, accumulator)
        }
    }
    
    private struct BinaryPendingOperation {
        var operation: (Double, Double) -> Double
        var operand: Double
    }
}