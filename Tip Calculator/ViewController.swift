//
//  ViewController.swift
//  Tip Calculator
//
//  Created by Vincent Duong on 12/15/15.
//  Copyright © 2015 Vincent Duong. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    //Object reference
    @IBOutlet var storeField: UITextField!
    @IBOutlet var billField: UITextField!
    @IBOutlet var tipLabel: UILabel!
    @IBOutlet var totalLabel: UILabel!
    @IBOutlet var tipControl: UISegmentedControl!
    
    // Obtain the object reference to the App Delegate object
    let applicationDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    //---------- Create and Initialize the Arrays -----------------------
    var itemNames = [String]()
    var itemArrays = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        //tipControl.setTitle("15", forSegmentAtIndex: 0)
        // Do any additional setup after loading the view, typically from a nib.
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        billField.becomeFirstResponder()
        itemNames = applicationDelegate.dict_Item_Names.allKeys as! [String]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Clear button tapped
    @IBAction func clearButtonTapped(sender: UIButton) {
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        billField.text = ""
        storeField.text = ""
    }
    
    //Save button tapped
    //*NOTE: it will overwrite the bill info for the store if it's on the same day with the same name
    @IBAction func saveButtonTapped(sender: AnyObject) {
        if storeField.text! == "" || billField.text! == "" {
            showMessage("Please add a store name or bill amount.")
        }
        else {
            let date = NSDate()
            let calendar = NSCalendar.currentCalendar()
            let components = calendar.components([.Day , .Month , .Year], fromDate: date)
            
            let year =  components.year
            let month = components.month
            let day = components.day
            
            let current_date = "\(month)/\(day)/\(year)"
            
            let billAmount = NSString(string: billField.text!).doubleValue
            let bill = String(format: "$%.2f", billAmount)
            
            if itemNames.contains(current_date){
                // Obtain the list of arrays in the given date
                let dict_groupOrderNumber_itemData = applicationDelegate.dict_Item_Names[current_date] as! NSMutableDictionary
                
                //Add item to dictionary
                dict_groupOrderNumber_itemData.setValue([bill, tipLabel.text!, totalLabel.text!], forKey: storeField.text!)
                
                // Update the new list of item for the item group in the NSMutableDictionary
                applicationDelegate.dict_Item_Names.setValue(dict_groupOrderNumber_itemData, forKey: current_date)
                
            } else { // The entered item group does not exist in the current dictionary
                
                // Create an array containing the item group entered
                let itemForDateEntered: NSMutableDictionary = [
                    storeField.text! : [bill, tipLabel.text!, totalLabel.text!]
                ]
                
                // Update the new list in the NSMutableDictionary
                applicationDelegate.dict_Item_Names.setObject(itemForDateEntered, forKey: current_date)
            }
            itemNames = applicationDelegate.dict_Item_Names.allKeys as! [String]
            showMessage("Bill info has been saved.")
        }

    }
    
    func showMessage(msg: String) {
        
        let alertController = UIAlertController(title: "Save", message: msg,
            preferredStyle: UIAlertControllerStyle.Alert)
        
        // Create a UIAlertAction object and add it to the alert controller
        alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        
        // Present the alert controller by calling the presentViewController method
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    //User edit bill
    @IBAction func onEditingChanged(sender: AnyObject) {
        let tipPercentages = [0.18, 0.20, 0.22]
        let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        let billAmount = NSString(string: billField.text!).doubleValue
        let tip = billAmount * tipPercentage
        let total = billAmount + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }

    @IBAction func onTap(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    /// This method is called when the user taps Return on the keyboard
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        
        
        // Deactivate the text field and remove the keyboard
        
        textField.resignFirstResponder()
        
        
        
        return true
        
    }
}

