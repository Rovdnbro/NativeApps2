//
//  ShoppingItemListViewController.swift
//  HouseholdHelper
//
//  Created by Robin on 12/08/2017.
//  Copyright © 2017 Robin Van den Broeck. All rights reserved.
//

import UIKit

class ShoppingItemViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var shoppingListItem: UITextField!

    @IBOutlet weak var quantity: UITextField!
    
    @IBOutlet weak var colli: UITextField!
    
    @IBAction func btnAddShoppingItem(_ sender: Any) {
    
    
        // get the database context
        
        let coredataContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let shoppingItem = ShoppingListItem(context: coredataContext)
        
        // check shoppinglistItem filled
        if shoppingListItem.text != nil {
            shoppingItem.itemName = shoppingListItem.text!
        }
        
        //check quantity flled and numeric double
        if quantity.text != nil {
            if Double(quantity.text!) != nil{
                shoppingItem.quantity = Double(quantity.text!)!
            }
        }
     
        // check colli filled
        if colli.text != nil {
            shoppingItem.colli = colli.text!
        }

        
        // Save the data
        
         (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        // return to the shoppingTableView
        
        navigationController?.popViewController(animated: true)
    
    }



}
