//
//  Subject.swift
//  Sharpr
//
//  Created by Umair Sharif on 12/26/16.
//  Copyright © 2016 2itionAcademy. All rights reserved.
//

class Subject {
    var name: String
    var listOfModules = [Module]()
    
    init(name: String) {
        self.name = name
        listOfModules.append(Module(name: "Grade 1"))
        listOfModules.append(Module(name: "Grade 2"))
        listOfModules.append(Module(name: "Grade 3"))
        listOfModules.append(Module(name: "Grade 4"))
    }
    
    func getModules() -> [Module] {
        return listOfModules
    }
}
