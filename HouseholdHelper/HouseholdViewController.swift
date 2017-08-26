//
//  ViewController.swift
//  HouseholdHelper
//
//  Created by Robin on 12/08/2017.
//  Copyright © 2017 Robin Van den Broeck. All rights reserved.
//

import UIKit

class HouseholdViewController: UIViewController , UITableViewDataSource, UITableViewDelegate {
   
    
    // the coredataContext
    private let coredataContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private var shoppinglistItemsArray : [ShoppingListItem] = []
    
    @IBOutlet weak var shoppingListTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shoppingListTableView.dataSource = self
        shoppingListTableView.delegate = self
      
    }

    override func viewWillAppear(_ animated: Bool) {
        // Get the data from the coredata database
        getShoppingListData()
        
        // fill the tableview
        shoppingListTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        let shoppingListItem = shoppinglistItemsArray[indexPath.row]
        
        var textToDisplay = ""
        
        
        if shoppingListItem.quantity > 0 {
            if Helper.isInteger(nbr: shoppingListItem.quantity){
                textToDisplay = String(Int(shoppingListItem.quantity))
            }
            else{
                textToDisplay = String(shoppingListItem.quantity)
            }
            textToDisplay +=  " "
        }
        
        if shoppingListItem.colli! != "" {
            textToDisplay +=  shoppingListItem.colli!
            textToDisplay +=  " "
        }
        
        textToDisplay +=  shoppingListItem.itemName!

       // cell.textLabel?.text = String(shoppingListItem.quantity) + shoppingListItem.colli! + shoppingListItem.itemName!
        
        cell.textLabel?.text = textToDisplay
        
        return cell

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppinglistItemsArray.count    }
    
    func getShoppingListData(){
        
        
        do {
        shoppinglistItemsArray = try coredataContext.fetch(ShoppingListItem.fetchRequest())
        }
        catch{
            print("Fetching ShoppingListItems from coredata failed")
        }
    }
    
    // editing style for deletion
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            
            let shoppingListItem = shoppinglistItemsArray[indexPath.row]
            coredataContext.delete(shoppingListItem)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        // reload the date in the table
        getShoppingListData()
            
        shoppingListTableView.reloadData()
        }
    }
    

}

