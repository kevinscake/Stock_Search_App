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
    
    var viewController: ViewController? = nil
    
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
        
        let segueID:String = segue.identifier!
        
        //check if the identifier of the segue happening is the one we think
        if segueID == "CurrentSegue" {
 
            if let currentViewController: CurrentViewController = segue.destinationViewController as? CurrentViewController {
                
                currentViewController._json = self._json
                currentViewController.viewController = self.viewController
            }
            
        }
        if segueID == "HistoricalSegue" {

            if let historicalChartViewController: HistoricalChartViewController = segue.destinationViewController as? HistoricalChartViewController {
                
                historicalChartViewController._json = self._json
            }
        }
        if segueID == "NewsSegue" {

            if let newsViewController: NewsViewController = segue.destinationViewController as? NewsViewController {
                
                newsViewController._json = self._json
            }
        }
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