//
//  BillsTableViewCell.swift
//  Tip Calculator
//
//  Created by Vincent Duong on 12/27/15.
//  Copyright © 2015 Vincent Duong. All rights reserved.
//

import UIKit

class BillsTableViewCell: UITableViewCell {

    @IBOutlet var storeLabel: UILabel!
    @IBOutlet var billLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
