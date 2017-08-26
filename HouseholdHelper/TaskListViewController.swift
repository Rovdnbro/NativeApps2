//
//  TaskListViewController.swift
//  HouseholdHelper
//
//  Created by Robin on 13/08/2017.
//  Copyright © 2017 Robin Van den Broeck. All rights reserved.
//

import UIKit
import CoreData

class TaskListViewController: UIViewController , UITableViewDataSource, UITableViewDelegate{
    
    var selectedPerson : Person?
    
    @IBOutlet weak var currentPerson: UILabel!
   
    
    
    @IBOutlet weak var taskListTableView: UITableView!
    // the coredataContext
    let coredataContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var taskListArray : [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // persoon geselecteerd
        if selectedPerson != nil {
            currentPerson.text = selectedPerson!.namePerson
        }
        else{
            // haal de "user" op als default gebruiker voor de takenlijst
            var userArray : [User] = []
            
            do {
                userArray = try coredataContext.fetch(User.fetchRequest())
            }
            catch{
                print("Fetching User from coredata failed")
            }
            if userArray.count > 0 {
                
                // fill the textfield
                currentPerson.text = userArray[0].userName!
            }
        
        }
        
        // Do any additional setup after loading the view.
        taskListTableView.dataSource = self
        taskListTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Get the data from the coredata database
        getTaskListData()
        
        // fill the tableview
        taskListTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        let taskListItem = taskListArray[indexPath.row]
        var textToDisplay = ""
        
        textToDisplay +=  taskListItem.taskName!
        
        cell.textLabel?.text = textToDisplay
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskListArray.count}
    
    func getTaskListData(){
        // haal de taken op van de geselecteerde persoon
        do {
            let request:NSFetchRequest<Task> = Task.fetchRequest()
            request.predicate = NSPredicate(format: "personName == %@", currentPerson.text!)
            
            // taskListArray = try coredataContext.fetch(Task.fetchRequest())
            taskListArray = try coredataContext.fetch(request)
            
        }
        catch{
            print("Fetching Tasks from coredata failed")
        }
    }

    
    // editing style for deletion
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            let taskListItem = taskListArray[indexPath.row]
            coredataContext.delete(taskListItem)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            // reload the date in the table
            getTaskListData()
            
            taskListTableView.reloadData()
        }
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if (segue.identifier == "addTask"){
            let destinationViewController = segue.destination
            if let taskVC = destinationViewController as?  TaskViewController  {
                taskVC.currentPerson = selectedPerson
            }
            
        }
    }
    
}
