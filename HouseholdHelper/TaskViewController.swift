//
//  TaskViewController.swift
//  HouseholdHelper
//
//  Created by Robin on 17/08/2017.
//  Copyright © 2017 Robin Van den Broeck. All rights reserved.
//

import UIKit

class TaskViewController: UIViewController {

    
    var currentPerson : Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    @IBOutlet weak var nameTask: UITextField!
  
    
    @IBAction func btnAddTask(_ sender: Any) {
    
        // get the database context
        
        let coredataContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let newTask =  Task(context: coredataContext)
        
        
        // check personname filled
        if nameTask.text != nil {
            newTask.taskName = nameTask.text!
            newTask.personName = currentPerson!.namePerson
        }
        
        
        // Save the data
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        // return to the personsTableView
        
        navigationController?.popViewController(animated: true)
 
    }
    

}
