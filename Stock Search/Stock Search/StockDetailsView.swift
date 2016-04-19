//
//  StockDetailsView.swift
//  Stock Search
//
//  Created by Jiayuan Huang on 4/19/16.
//  Copyright © 2016 Jiayuan Huang. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class StockDetailsView: UIViewController {
    
    
    var _json:JSON = []
    
    override func viewDidLoad() {
        print(_json)
    }
    
    ////show navigation bar
    override func viewWillAppear(animated: Bool)
    {
        self.navigationController?.navigationBarHidden = false
    }
    
}