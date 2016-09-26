//
//  Data.swift
//  2ition
//
//  Created by Umair Sharif on 9/22/16.
//  Copyright © 2016 2itionAcademy. All rights reserved.
//

import Foundation

class Data {
    
    var index: Int!
    let questionArray: [String] = ["20÷5", "3×7", "4+8", "10-3", "5+3"]
    var answerArray: [String]?
    
    func setup() {
        index = Int(arc4random_uniform(5))
    }
    
    func getQuestion() -> String {
        return questionArray[index]
    }
    
    func getAnswerArray() -> [String] {
        var answerArray = [String]()
        
        switch index {
        case 0:
            answerArray.append("5")
            answerArray.append("-1")
            answerArray.append("10")
            answerArray.append("2")
        case 1:
            answerArray.append("21")
            answerArray.append("17")
            answerArray.append("10")
            answerArray.append("30")
        case 2:
            answerArray.append("12")
            answerArray.append("4")
            answerArray.append("10")
            answerArray.append("14")
        case 3:
            answerArray.append("7")
            answerArray.append("-3")
            answerArray.append("5")
            answerArray.append("6")
        case 4:
            answerArray.append("8")
            answerArray.append("-1")
            answerArray.append("10")
            answerArray.append("2")
        default:
            break
        }
        return answerArray
    }
    
    func getAnswer() -> String {
        var ans: String?
        
        switch index {
        case 0:
            ans = "5"
        case 1:
            ans = "21"
        case 2:
            ans = "12"
        case 3:
            ans = "7"
        case 4:
            ans = "8"
        default:
            break
        }
        return ans!
    }
}
