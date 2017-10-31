//
//  ViewController.swift
//  simple-calc-iOS
//
//  Created by Matthew Ngo on 10/20/17.
//  Copyright © 2017 Matthew Ngo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var start = false
    var calculate = false
    var numOneEntered = false
    var secondStart = false
    var dotEntered = false
    var total: Float = 0
    var numOne: Float = 0
    var numTwo: Float = 0
    var count: Int = 0
    var currentOperation: String = ""
    var history: String = ""
    var currHist: String = ""
    
    @IBOutlet weak var calcLabel: UILabel!
    
    @IBAction func clearCalc(_ sender: UIButton) {
        start = false
        calculate = false
        numOneEntered = false
        secondStart = false
        dotEntered = false
        total = 0
        numOne = 0
        numTwo = 0
        count = 0
        calcLabel.text! = "0"
        currentOperation = ""
    }
    
    @IBAction func pushNumber(_ sender: UIButton) {
        if (!start) {
            calcLabel.text! = ""
            start = true
        }
        if (numOneEntered && !secondStart) {
            calcLabel.text! = ""
            secondStart = true
        }
        let input: String = sender.currentTitle!
        if (input == "." && dotEntered) {
            
        } else {
            calcLabel.text! += input
        }
        if (input == ".") {
            dotEntered = true
        }
    }
    
    @IBAction func pushOperation(_ sender: UIButton) {
        secondStart = false
        dotEntered = false
        let operation = sender.currentTitle!
        // Enter number
        if (!numOneEntered) {
            numOne = Float(calcLabel.text!)!
            numOneEntered = true
            currHist = currHist + "\(calcLabel.text!)\(operation)"
        } else {
            numTwo = Float(calcLabel.text!)!
            currHist = currHist + "\(calcLabel.text!)\(operation)"
        }
        
        // Figure out operation calculation/input
        if (operation == "History") {
            calcLabel.text = history
            start = false
            calculate = false
            numOneEntered = false
            secondStart = false
            dotEntered = false
            total = 0
            numOne = 0
            numTwo = 0
            count = 0
            currentOperation = ""
            currHist = ""
        } else if (operation == "count") {
            currentOperation = operation
            calculate = true
            count += 1
        } else if (operation == "avg") {
            count += 1
            if (currentOperation != "avg") {
                total += numOne
            } else {
                total += numTwo
            }
            currentOperation = operation
            calculate = true
            let res = total/Float(count)
            if (res.truncatingRemainder(dividingBy: 1) == 0) {
                calcLabel.text = String(describing:Int(res))
            } else {
                calcLabel.text = String(describing:res)
            }
        } else if (operation != "=" && !calculate && operation != "fact") {
            currentOperation = operation
            calculate = true
        } else if (operation == "fact" && !calculate) {
            var result: Int = 1
            let input: Int = Int(calcLabel.text!)!
            for n in (1...input).reversed() {
                result *= n
            }
            calcLabel.text = String(describing: result)
        } else if (operation != "=" && calculate) {
            numOne = calculateMath()
            currentOperation = operation
            calculate = true
            if (numOne.truncatingRemainder(dividingBy: 1) == 0) {
                calcLabel.text = String(describing:Int(numOne))
            } else {
                calcLabel.text = String(describing:numOne)
            }
        } else if (operation == "=" && calculate) {
            total = calculateMath()
            calculate = false
            numOneEntered = false
            if (currentOperation == "count") {
                calcLabel.text = String(describing:count)
                history = currHist + "\(calcLabel.text!)"
                currHist = ""
            } else if (total.truncatingRemainder(dividingBy: 1) == 0) {
                calcLabel.text = String(describing:Int(total))
                history = currHist + "\(calcLabel.text!)"
                currHist = ""
            } else {
                calcLabel.text = String(describing:total)
                history = currHist + "\(calcLabel.text!)"
                currHist = ""
            }
            count = 0
        }
    }
    
    func calculateMath() -> Float {
        var result: Float = 0
        switch currentOperation {
        case "+":
            result = numOne + numTwo
        case "-":
            result = numOne - numTwo
        case "/":
            result = numOne / numTwo
        case "*":
            result = numOne * numTwo
        case "%":
            result = numOne.truncatingRemainder(dividingBy: numTwo)
        case "avg":
            count += 1
            total += numTwo
            result = total/Float(count)
        case "count":
            count += 1
        default:
            result = result*1
        }
        return result
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

