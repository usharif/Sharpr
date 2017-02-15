//
//  QuestionTableViewController.swift
//  Sharpr
//
//  Created by Umair Sharif on 2/14/17.
//  Copyright © 2017 2itionAcademy. All rights reserved.
//

import UIKit
import CoreData

class QuestionTableViewController: UITableViewController {
    var questions = [NSManagedObject]()
    var selectedIndex : Int?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let question = questions[indexPath.row]
        cell.textLabel?.text = question.value(forKey: "titleString") as? String
        return cell
    }
    
    private func getData() {
        questions = CoreDataManager.fetchModel(entity: "CDQuestion")
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        
//        let questionDetailVC = storyboard?.instantiateViewController(withIdentifier: "QuestionDetailViewController") as! QuestionDetailViewController
//        present(questionDetailVC, animated: true, completion: nil)
        self.performSegue(withIdentifier: "questionDetail", sender: self)
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "questionDetail" {
            if let destinationVC = segue.destination as? QuestionDetailViewController {
                let question = questions[selectedIndex!]
                let str = question.value(forKey: "titleString") as? String
                destinationVC.titleStr = str!
            }
        }
    }

}
