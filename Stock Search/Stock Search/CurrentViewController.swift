//
//  CurrentViewController.swift
//  Stock Search
//
//  Created by Jiayuan Huang on 4/20/16.
//  Copyright © 2016 Jiayuan Huang. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class CurrentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var _json: JSON  = []
    
    //scroller setting
    @IBOutlet weak var currentScroller: UIScrollView!
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        
        //define scrollable content area
        self.currentScroller.frame = self.view.bounds
        self.currentScroller.contentSize.height = 1000
        self.currentScroller.contentSize.width = 0
    }
    
    
    //favourite button
    @IBAction func favouriteButtonClicked(sender: AnyObject) {
    }
    
    
    @IBAction func facebookClicked(sender: AnyObject) {
        ///////////////////////////////////facebook///////////////////////////////////
        let content : FBSDKShareLinkContent = FBSDKShareLinkContent()
        content.contentURL = NSURL(string: "http://chart.finance.yahoo.com/t?s=" + _json["Symbol"].string! + "&lang=en-US&width=600&height=450")
        
        let name = _json["Name"].string!
        let symbol = _json["Symbol"].string!
        let lastPrice = String(format: "%.2f", _json["LastPrice"].double!)
        
        content.contentTitle = "Current Stock Price of " + name  + " is $" + lastPrice
        content.contentDescription = "Stock Information of " + name + " (" + symbol + ")"
        content.imageURL = NSURL(string: "http://chart.finance.yahoo.com/t?s=" + symbol + "&lang=en-US&width=300&height=350")
        
        FBSDKShareDialog.showFromViewController(self, withContent: content, delegate: nil)
    }
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //define the scrollable area that outside of the scrollable content area
        currentScroller.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
        
        ///////////////////////////////////Daily chart/////////////////////////////////
        //decide image width & heigh
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let width = screenSize.width
        let height = screenSize.width*2/3
        
        
        let stockDailyChartURL = "http://chart.finance.yahoo.com/t?s=" + _json["Symbol"].string! + "&lang=en-US&width=" + String(width) + "&height=" + String(height)
        let url = NSURL(string: stockDailyChartURL)
        let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
        dailyStockChartImageView.image = UIImage(data: data!)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //////////////////////table view//////////////////////
    @IBOutlet weak var tableView: UITableView!
    var arrowImage = ["Up": UIImage(named: "Up-52"), "Down": UIImage(named: "Down-52")]
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 11
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Configure the cell...
        switch indexPath.row {
        case 0:
            let noArrowCell = tableView.dequeueReusableCellWithIdentifier("noArrowCell", forIndexPath: indexPath) as! noArrowTableViewCell
            noArrowCell.noArrowCellTitle.text = "Name"
            noArrowCell.noArrowCellDetail.text = _json["Name"].string
            return noArrowCell
        case 1:
            let noArrowCell = tableView.dequeueReusableCellWithIdentifier("noArrowCell", forIndexPath: indexPath) as! noArrowTableViewCell
            noArrowCell.noArrowCellTitle.text = "Symbol"
            noArrowCell.noArrowCellDetail.text = _json["Symbol"].string
            return noArrowCell
        case 2:
            let noArrowCell = tableView.dequeueReusableCellWithIdentifier("noArrowCell", forIndexPath: indexPath) as! noArrowTableViewCell
            noArrowCell.noArrowCellTitle.text = "Last Price"
            noArrowCell.noArrowCellDetail.text = "$" + String(format: "%.2f", _json["LastPrice"].double!)
            return noArrowCell
        case 3:
            let arrowCell = tableView.dequeueReusableCellWithIdentifier("arrowCell", forIndexPath: indexPath) as! arrowTableViewCell
            arrowCell.arrowCellTitle.text = "Change"
            arrowCell.arrowCellDetail.text = String(format: "%.2f", _json["Change"].double!) + "(" + String(format: "%.2f", _json["ChangePercent"].double!) + "%)"
            
            //arrow type
            if(Double(round(1000*_json["Change"].double!)/1000)>0) {
                arrowCell.arrowCellImage.image = arrowImage["Up"]!
            }
            if(Double(round(1000*_json["Change"].double!)/1000)<0) {
                arrowCell.arrowCellImage.image = arrowImage["Down"]!
            }
            
            return arrowCell
        case 4:
            let noArrowCell = tableView.dequeueReusableCellWithIdentifier("noArrowCell", forIndexPath: indexPath) as! noArrowTableViewCell
            noArrowCell.noArrowCellTitle.text = "Time and Date"
            noArrowCell.noArrowCellDetail.text = _json["Timestamp"].string
            return noArrowCell
        case 5:
            let noArrowCell = tableView.dequeueReusableCellWithIdentifier("noArrowCell", forIndexPath: indexPath) as! noArrowTableViewCell
            noArrowCell.noArrowCellTitle.text = "Market Cap"
            noArrowCell.noArrowCellDetail.text = String(format: "%.2f", _json["MarketCap"].double!/1000000000) + "Billion"
            return noArrowCell
        case 6:
            let noArrowCell = tableView.dequeueReusableCellWithIdentifier("noArrowCell", forIndexPath: indexPath) as! noArrowTableViewCell
            noArrowCell.noArrowCellTitle.text = "Volume"
            noArrowCell.noArrowCellDetail.text = String(_json["Volume"].int!)
            return noArrowCell
        case 7:
            let arrowCell = tableView.dequeueReusableCellWithIdentifier("arrowCell", forIndexPath: indexPath) as! arrowTableViewCell
            arrowCell.arrowCellTitle.text = "ChangeYTD"
            arrowCell.arrowCellDetail.text = String(format: "%.2f", _json["Change"].double!) + "(" + String(format: "%.2f", _json["ChangePercentYTD"].double!) + "%)"
            
            //arrow type
            if(Double(round(1000*_json["Change"].double!)/1000)>0) {
                arrowCell.arrowCellImage.image = arrowImage["Up"]!
            }
            if(Double(round(1000*_json["Change"].double!)/1000)<0) {
                arrowCell.arrowCellImage.image = arrowImage["Down"]!
            }
            
            return arrowCell
        case 8:
            let noArrowCell = tableView.dequeueReusableCellWithIdentifier("noArrowCell", forIndexPath: indexPath) as! noArrowTableViewCell
            noArrowCell.noArrowCellTitle.text = "High Price"
            noArrowCell.noArrowCellDetail.text = "$" + String(format: "%.2f", _json["High"].double!)
            return noArrowCell
        case 9:
            let noArrowCell = tableView.dequeueReusableCellWithIdentifier("noArrowCell", forIndexPath: indexPath) as! noArrowTableViewCell
            noArrowCell.noArrowCellTitle.text = "Low Price"
            noArrowCell.noArrowCellDetail.text = "$" + String(format: "%.2f", _json["Low"].double!)
            return noArrowCell
        case 10:
            let noArrowCell = tableView.dequeueReusableCellWithIdentifier("noArrowCell", forIndexPath: indexPath) as! noArrowTableViewCell
            noArrowCell.noArrowCellTitle.text = "Openning Price"
            noArrowCell.noArrowCellDetail.text = "$" + String(format: "%.2f", _json["Open"].double!)
            return noArrowCell
        default:
            //something really bad happened here...
            let noArrowCell = tableView.dequeueReusableCellWithIdentifier("noArrowCell", forIndexPath: indexPath) as! noArrowTableViewCell
            return noArrowCell
            
        }
    }
    
    //////////////////////daily stock chart image view//////////////////////
    
    @IBOutlet weak var dailyStockChartImageView: UIImageView!
    
    
    
}
