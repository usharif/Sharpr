//
//  Module.swift
//  Sharpr
//
//  Created by Umair Sharif on 12/26/16.
//  Copyright © 2016 2itionAcademy. All rights reserved.
//

class Module {
    var name: String
    var listOfQuestions = [Question]()
    
    init(name: String) {
        self.name = name
        listOfQuestions.append(Question(name: "Q1"))
        listOfQuestions.append(Question(name: "Q2"))
        listOfQuestions.append(Question(name: "Q3"))
        listOfQuestions.append(Question(name: "Q4"))
    }
    
    func getQuestions() -> [Question] {
        return listOfQuestions
    }
}
