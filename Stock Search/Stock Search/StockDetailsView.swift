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
    
    
    
    
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var currentView: UIView!
    @IBOutlet weak var historicalView: UIView!
    @IBOutlet weak var NewsView: UIView!
    
    
    @IBAction func indexChanged(sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            currentView.hidden = false
            historicalView.hidden = true
            NewsView.hidden = true
        case 1:
            currentView.hidden = true
            historicalView.hidden = false
            NewsView.hidden = true
        case 2:
            currentView.hidden = true
            historicalView.hidden = true
            NewsView.hidden = false
        default:
            break;
        }
    }
    
    
    
    
    override func viewDidLoad() {
        
        //set navigation bar title
        self.title = _json["Symbol"].string
        
        print(_json)
        
        //set initial page to show
        currentView.hidden = false
        historicalView.hidden = true
        NewsView.hidden = true
        
        //set segmentedControl title size
        let font = UIFont.systemFontOfSize(22)
        segmentedControl.setTitleTextAttributes([NSFontAttributeName: font], forState: UIControlState.Normal)
    }
    
    ////show navigation bar
    override func viewWillAppear(animated: Bool)
    {
        self.navigationController?.navigationBarHidden = false
    }
    
}