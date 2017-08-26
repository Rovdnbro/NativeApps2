//
//  PreferencesViewController.swift
//  HouseholdHelper
//
//  Created by Robin on 18/08/2017.
//  Copyright © 2017 Robin Van den Broeck. All rights reserved.
//

import UIKit

class PreferencesViewController: UIViewController {
    
    
    // get the database context
    private let coredataContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    

    private var userArray : [User] = []
    
    
    @IBOutlet weak var currentUser: UILabel!
    
    @IBOutlet weak var myUserName: UITextField!

    @IBAction func btnSaveUserName(_ sender: Any) {
        
  
        // check personname filled
        if myUserName.text != nil {
            if ( myUserName.text != "" && myUserName.text != "Enter your name"){
                //delete the existing user
                getUserData()
                for u in userArray{
                    coredataContext.delete(u)
                }
                (UIApplication.shared.delegate as! AppDelegate).saveContext()
                
                
                let newUser =  User(context: coredataContext)
                newUser.userName = myUserName.text!
                // Save the new data
                (UIApplication.shared.delegate as! AppDelegate).saveContext()
                
                //refetch the data
                getUserData()
                currentUser.text = "Current user is " + userArray[0].userName!

                let alert = UIAlertController(title: "Info", message: "Username saved", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            
        }
        
        
                 //
        

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Get the data from the coredata database
        getUserData()
        if userArray.count > 0 {
            
            // fill the textfield
            currentUser.text = "Current user is " + userArray[0].userName!
        }
    }
    
    func getUserData(){
        
        do {
            userArray = try coredataContext.fetch(User.fetchRequest())
        }
        catch{
            print("Fetching User from coredata failed")
        }
    }


}
