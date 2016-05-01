//
//  newsTableCell.swift
//  Stock Search
//
//  Created by Jiayuan Huang on 4/30/16.
//  Copyright © 2016 Jiayuan Huang. All rights reserved.
//

import UIKit

class newsTableCell: UITableViewCell {

    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var content: UILabel!
    
    @IBOutlet weak var publisher: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
