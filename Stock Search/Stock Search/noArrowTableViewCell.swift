//
//  noArrowTableViewCell.swift
//  Stock Search
//
//  Created by Jiayuan Huang on 4/20/16.
//  Copyright © 2016 Jiayuan Huang. All rights reserved.
//

import UIKit

class noArrowTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var noArrowCellTitle: UILabel!
    
    
    @IBOutlet weak var noArrowCellDetail: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
