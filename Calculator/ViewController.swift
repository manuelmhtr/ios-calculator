//
//  ViewController.swift
//  Calculator
//
//  Created by Manuel de la Torre on 05/12/16.
//  Copyright © 2016 Manuel de la Torre. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var calculatorBrain = CalculatorBrain()
    
    private var userIsWritting = false;
    
    private var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set(value) {
            display.text = String(value)
        }
    }
    
    @IBOutlet private weak var display: UILabel!
    
    @IBAction private func pressDigit(sender: UIButton) {
        if let digit = sender.currentTitle {
            appendStringToDisplay(digit)
        }
    }
    
    
    @IBAction private func pressDot(sender: UIButton) {
        if !userIsWritting {
            appendStringToDisplay("0.")
        } else if (displayValue % 1 == 0) {
            appendStringToDisplay(".")
        }
    }
    
    private func appendStringToDisplay(string: String) {
        if (userIsWritting) {
            display.text = display.text! + string
        } else {
            display.text = string
        }
        
        userIsWritting = true
        calculatorBrain.setOperand(displayValue)
    }
    
    @IBAction private func performOperation(sender: UIButton) {
        if let symbol = sender.currentTitle {
            displayValue = calculatorBrain.performOperation(symbol);
            userIsWritting = false
        }
    }
    
}
