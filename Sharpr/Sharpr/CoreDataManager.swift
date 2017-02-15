//
//  CoreDataManager.swift
//  Sharpr
//
//  Created by Umair Sharif on 2/14/17.
//  Copyright © 2017 2itionAcademy. All rights reserved.
//

import CoreData

class CoreDataManager {
    
    static func saveQuestion(entity: String, title: String, questionData: NSData, answer: String, d1: String, d2: String, d3: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: entity, in: context)
        let question = NSManagedObject(entity: entity!, insertInto: context)
        question.setValue(title, forKey: "titleString")
        question.setValue(questionData, forKey: "questionData")
        question.setValue(answer, forKey: "answerString")
        question.setValue(d1, forKey: "decoy1String")
        question.setValue(d2, forKey: "decoy2String")
        question.setValue(d2, forKey: "decoy3String")
        do {
            try context.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }

    }
    
    static func fetchModel(entity: String) -> [NSManagedObject] {
        var managedObject = [NSManagedObject]()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        do {
            let results = try context.fetch(fetchRequest)
            managedObject = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        return managedObject
    }
    
    static func fetchObject(entity: String, title: String) -> NSManagedObject {
        var managedObject : NSManagedObject?
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchPredicate = NSPredicate(format: "titleString == %@", title)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.predicate = fetchPredicate
        
        do {
            let results = try context.fetch(fetchRequest) as! [NSManagedObject]
            if !results.isEmpty {
                managedObject = results[0]
            }
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        return managedObject!
    }
    
    static func deleteObject(entity: String, title: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchPredicate = NSPredicate(format: "title == %@", title)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.predicate = fetchPredicate
        
        do {
            let results = try context.fetch(fetchRequest) as! [NSManagedObject]
            for object in results {
                context.delete(object)
            }
            try context.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
}
