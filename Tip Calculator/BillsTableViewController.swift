//
//  BillsTableViewController.swift
//  Tip Calculator
//
//  Created by Vincent Duong on 12/23/15.
//  Copyright © 2015 Vincent Duong. All rights reserved.
//

import UIKit

class BillsTableViewController: UITableViewController {
    
    @IBOutlet var billsTable: UITableView!
    // Obtain the object reference to the App Delegate object
    let applicationDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    //---------- Create and Initialize the Arrays -----------------------
    var itemNames = [String]()
    var itemArrays = [String]()
    
    // dataObjectToPass is the data object to pass to the downstream view controller
    var dataObjectToPass: [String] = ["", "", "", "", ""]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.clearsSelectionOnViewWillAppear = false
        
        itemNames = applicationDelegate.dict_Item_Names.allKeys as! [String]
        itemNames.sortInPlace{$0 < $1}
    }
    
    override func viewDidAppear(animated: Bool) {
        itemNames = applicationDelegate.dict_Item_Names.allKeys as! [String]
        itemNames.sortInPlace{$0 < $1}
        billsTable.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return itemNames.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if itemNames.count == 0 {
            return 0
        }
        else {
            // Obtain the name of the given item group
            let givenItemGroup = itemNames[section]
            
            // Obtain the list of arrays in the given item group
            let dict_items = applicationDelegate.dict_Item_Names[givenItemGroup] as! NSMutableDictionary
            
            // Typecast the AnyObject to Swift array of String objects
            let arraysOfGivenItem = dict_items.allKeys as! [String]
            
            return arraysOfGivenItem.count
        }
    }

    // Set the table view section header to be the item group name
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String {
        
        return itemNames[section]
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("itemCell", forIndexPath: indexPath) as! BillsTableViewCell
        
        let sectionNumber = indexPath.section
        let rowNumber = indexPath.row
        
        // Obtain the arrays of the given item group
        let givenItemGroup = itemNames[sectionNumber]
        
        // Obtain the list of items in the given group
        let dict_item = applicationDelegate.dict_Item_Names[givenItemGroup] as! NSMutableDictionary
        
        let item = dict_item.allKeys as! [String]
        
        cell.storeLabel.text = item[rowNumber]
        
        // Typecast the AnyObject to Swift array of String objects and store it into itemArrays
        if let value = dict_item[item[rowNumber]] as? [String]
        {
            itemArrays = value
            cell.billLabel.text = itemArrays[0]
        }
        
        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Obtain the item group of the item to be deleted
            let itemOfGroupToDelete = itemNames[indexPath.section]
            
            // Obtain the list of arrays in the given group
            let dict_itemToRemove_itemData = applicationDelegate.dict_Item_Names[itemOfGroupToDelete] as! NSMutableDictionary
            
            let itemToDelete = dict_itemToRemove_itemData.allKeys as! [String]
            
            //Remove item
            dict_itemToRemove_itemData.removeObjectForKey(itemToDelete[indexPath.row])
            
            if (dict_itemToRemove_itemData.count == 0) {
                //Delete group if no item remains
                applicationDelegate.dict_Item_Names.removeObjectForKey(itemOfGroupToDelete)
                //Update itemNames
                itemNames = applicationDelegate.dict_Item_Names.allKeys as! [String]
                //Sort the item
                itemNames.sortInPlace { $0 < $1 }
            }
            else {
                // Update the new list in the NSMutableDictionary
                applicationDelegate.dict_Item_Names.setValue(dict_itemToRemove_itemData, forKey: itemOfGroupToDelete)
            }
            
            // Reload the rows and sections of the Table View
            billsTable.reloadData()
        }
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //Obtain the name of the date
        let selectedDate = itemNames[indexPath.section]
        
        // Obtain the list of arrays in the given group
        let dict_itemData = applicationDelegate.dict_Item_Names[selectedDate] as! NSMutableDictionary
        
        let item = dict_itemData.allKeys as! [String]
        // Typecast the AnyObject to Swift array of String objects and store it into itemArrays
        if let value = dict_itemData[item[indexPath.row]] as? [String] {
            itemArrays = value;
            //item name
            dataObjectToPass[0] = item[indexPath.row]
            //Date
            dataObjectToPass[1] = selectedDate
            //Bill amount
            dataObjectToPass[2] = itemArrays[0]
            //Tip Amount
            dataObjectToPass[3] = itemArrays[1]
            //Total Amount
            dataObjectToPass[4] = itemArrays[2]
        }
        
        //Perform the segue named detailSegue
        performSegueWithIdentifier("rowClicked", sender: self)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "rowClicked" {
            //Obtain object reference of destination view controller
            let billsInfoViewController:BillsInfoViewController = segue.destinationViewController as! BillsInfoViewController

            //Pass the data object to the destination view controller object
            billsInfoViewController.dataObjectPassed = dataObjectToPass
        }
    }

}
