//
//  ViewController.swift
//  simple-calc
//
//  Created by Nicholas Olds on 10/17/18.
//  Copyright © 2018 Nicholas Olds. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblNumber: UILabel!
    
    var total = ""
    var opUsed = false
    @IBAction func btnNumber(_ sender: UIButton) {
        opUsed = false
        total = total + sender.currentTitle!
        lblNumber.text = total
    }
    
    @IBAction func btnOp(_ sender: UIButton) {
        if (!opUsed) {
            opUsed = true
            total = total + " " + sender.currentTitle! + " "
            lblNumber.text = total
        }
    }
    
    private func performOp(_ lh : Int, _ opChar: String, _ rh: Int) -> Int {
        var retVal = 0;
        switch opChar {
        case "-":
            retVal = mathOp(lhs: lh, rhs: rh, op: {($0 - $1)})
        case "*":
            retVal = mathOp(lhs: lh, rhs: rh, op: {($0 * $1)})
        case "/":
            retVal = mathOp(lhs: lh, rhs: rh, op: {($0 / $1)})
        case "+":
            retVal = mathOp(lhs: lh, rhs: rh, op: {($0 + $1)})
        default:
            break
        }
        return retVal
    }
    
    func mathOp(lhs: Int, rhs: Int, op: (Int, Int) -> Int) -> Int {
        return op(lhs, rhs)
    }
    @IBAction func btnFact(_ sender: Any) {
        if (!opUsed) {
            opUsed = false
            let array = total.components(separatedBy: " ")
            if (array.count == 1) {
                let num : Int = Int(array[0])!
                total = calcFact(num)
                lblNumber.text = String(total)
            }
        }
        
    }
    @IBAction func btnClear(_ sender: Any) {
        total = ""
        lblNumber.text = "0"
    }
    private func calcFact(_ num: Int) -> String {
        if (num == 0) {
            return "0"
        } else if (num == 1) {
            return "1"
        }
        var count = num
        var tot = 1
        while (count > 0) {
            tot = tot * count
            count = count - 1
        }
        return String(tot)
    }
    @IBAction func btnPerform(_ sender: Any) {
        if (!opUsed) {
            opUsed = false
            let array = total.components(separatedBy: " ")
            let count = 2;
            var totalNum = performOp(Int(array[0]) ?? 0, array[1], Int(array[2]) ?? 0)
            for i in 2..<array.count - 1 {
                if (i % count == 0) {
                    totalNum = performOp(totalNum, array[i+1], Int(array[i+2]) ?? 0)
                }
            }
            lblNumber.text = String(totalNum)
            total = String(totalNum)
        }
    }
}

