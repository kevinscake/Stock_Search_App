//
//  favouriteTableCell.swift
//  Stock Search
//
//  Created by Jiayuan Huang on 5/2/16.
//  Copyright © 2016 Jiayuan Huang. All rights reserved.
//

import UIKit

class favouriteTableCell: UITableViewCell {
    
    
    @IBOutlet weak var symbol: UILabel!
    
    @IBOutlet weak var companyName: UILabel!

    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var change: UILabel!
    
    @IBOutlet weak var marketCap: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
