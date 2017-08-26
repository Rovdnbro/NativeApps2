//
//  PersonListTableViewCell.swift
//  HouseholdHelper
//
//  Created by Robin on 25/08/2017.
//  Copyright © 2017 Robin Van den Broeck. All rights reserved.
//

import UIKit

class PersonListTableViewCell: UITableViewCell {

    @IBOutlet weak var personCellLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
