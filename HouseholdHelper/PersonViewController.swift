//
//  PersonViewController.swift
//  HouseholdHelper
//
//  Created by Robin on 13/08/2017.
//  Copyright © 2017 Robin Van den Broeck. All rights reserved.
//

import UIKit

class PersonViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var namePerson: UITextField!
    
    @IBAction func btnAddPerson(_ sender: Any) {
    

        // get the database context
    
        let coredataContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
        let person = Person(context: coredataContext)
        
    
        // check personname filled
        if namePerson.text != nil {
          person.namePerson = namePerson.text!
        }
        
        // Save the data
    
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    
        // return to the personsTableView
    
        navigationController?.popViewController(animated: true)
    }
    
    

}
