//
//  BillsInfoViewController.swift
//  Tip Calculator
//
//  Created by Vincent Duong on 12/27/15.
//  Copyright © 2015 Vincent Duong. All rights reserved.
//

import UIKit

class BillsInfoViewController: UIViewController {
    @IBOutlet var billLabel: UILabel!
    @IBOutlet var tipLabel: UILabel!
    @IBOutlet var totalLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    var dataObjectPassed: [String] = ["", "", "", "", ""]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = dataObjectPassed[0]
        billLabel.text = dataObjectPassed[2]
        tipLabel.text = dataObjectPassed[3]
        totalLabel.text = dataObjectPassed[4]
        dateLabel.text = dataObjectPassed[1]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
