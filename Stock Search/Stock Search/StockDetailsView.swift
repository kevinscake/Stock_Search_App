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
    
    //This method is called whenever ANY segue is called
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        switch (self.segmentedControl.selectedSegmentIndex) {
        case 0:
            
            print("cur")
            
            if let currentViewController: CurrentViewController = segue.destinationViewController as? CurrentViewController {
                
                currentViewController._json = self._json
            }
            
//            if let historicalChartViewController: HistoricalChartViewController = segue.destinationViewController as? HistoricalChartViewController {
//                
//                historicalChartViewController._json = self._json
//            }
//            break;
        case 1:
            print("his")
//            
//            if let historicalChartViewController: HistoricalChartViewController = segue.destinationViewController as? HistoricalChartViewController {
//                
//                historicalChartViewController._json = self._json
//            }
            break;
        case 2:
            break;
        default:
            break;
        }
        
        
        
        
        //check if the identifier of the segue happening is the one we think
//        if segue.identifier == "CurrentSegue" {
//            
//            print("cur")
// 
//            if let currentViewController: CurrentViewController = segue.destinationViewController as? CurrentViewController {
//                
//                currentViewController._json = self._json
//            }
//        }
//        if segue.identifier == "HistorySegue" {
//            
//            print("his")
//
//            if let historicalChartViewController: HistoricalChartViewController = segue.destinationViewController as? HistoricalChartViewController {
//                
//                historicalChartViewController._json = self._json
//            }
//        }
//        if segue.identifier == "NewsSegue" {
//
//            if let StockDetailsViewController: StockDetailsView = segue.destinationViewController as? StockDetailsView {
//                
//                StockDetailsViewController._json = self._json
//            }
//        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //set navigation bar title
        self.title = _json["Symbol"].string
        
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