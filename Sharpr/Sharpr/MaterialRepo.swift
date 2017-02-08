//
//  MaterialRepo.swift
//  Sharpr
//
//  Created by Umair Sharif on 12/27/16.
//  Copyright © 2016 2itionAcademy. All rights reserved.
//

class MaterialRepo {
    var listOfSubjects = [Subject]()
    
    init() {
        listOfSubjects.append(Subject(name: "Math"))
        listOfSubjects.append(Subject(name: "Science"))
        listOfSubjects.append(Subject(name: "Geography"))
        listOfSubjects.append(Subject(name: "Language"))
    }
    
    func getSubjects() -> [Subject] {
        return listOfSubjects
    }
}
