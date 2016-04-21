//
//  arrowTableViewCell.swift
//  Stock Search
//
//  Created by Jiayuan Huang on 4/20/16.
//  Copyright © 2016 Jiayuan Huang. All rights reserved.
//

import UIKit

class arrowTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var arrowCellTitle: UILabel!
    
    
    @IBOutlet weak var arrowCellDetail: UILabel!
    
    
    @IBOutlet weak var arrowCellImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
