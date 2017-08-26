//
//  PersonListTableViewController.swift
//  HouseholdHelper
//
//  Created by Robin on 13/08/2017.
//  Copyright © 2017 Robin Van den Broeck. All rights reserved.
//

import UIKit

class PersonListTableViewController: UITableViewController
{
    
    
    // the coredataContext
    private let coredataContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
  
    
    private var personListItemsArray : [Person] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        // Get the data from the coredata database
        getPersonData()
        
        // fill the tableview
        self.tableView.reloadData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of rows
        return personListItemsArray.count
    }
    
    
 /*   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // row selected
        self.performSegue(withIdentifier: "showPersonTasks", sender: indexPath)
        
        
    }
*/
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
     
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell", for: indexPath as IndexPath) as! PersonListTableViewCell
        
        let person = personListItemsArray[indexPath.row]
        
        var textToDisplay = ""
        
        textToDisplay +=  person.namePerson!
        
        // cell.textLabel?.text = String(shoppingListItem.quantity) + shoppingListItem.colli! + shoppingListItem.itemName!
        
        cell.personCellLabel.text = textToDisplay
        
        return cell
        
    }
    
    func getPersonData(){
        
        do {
            personListItemsArray = try coredataContext.fetch(Person.fetchRequest())
        }
        catch{
            print("Fetching Persons from coredata failed")
        }
    }
    
    // editing style for deletion
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            let person = personListItemsArray[indexPath.row]
            coredataContext.delete(person)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            // reload the date in the table
            getPersonData()
            
            self.tableView.reloadData()
        }
    }
    
    
    
    
    // Voorbereiden segue voor naar detail taak personen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if (segue.identifier == "showPersonTasks"){
            let destinationViewController = segue.destination
            if let personsVC = destinationViewController as?  TaskListViewController  {
                let indexPath = self.tableView.indexPathForSelectedRow!
                let row = indexPath.row
                personsVC.selectedPerson = personListItemsArray[row]
            }
            //in geval view controller vanuit navigation controller komt

            if let navVC = destinationViewController as?  UINavigationController  {
                let indexPath = self.tableView.indexPathForSelectedRow!
                let row = indexPath.row
                let personsVC = navVC.topViewController as! TaskListViewController
                personsVC.selectedPerson = personListItemsArray[row]
            }
            
        }
    }
    
    
}
