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
        
        self.currentScroller.frame = self.view.bounds
        self.currentScroller.contentSize.height = 400
        self.currentScroller.contentSize.width = 0
    }
    
    
    //favourite button
    @IBAction func favouriteButtonClicked(sender: AnyObject) {
    }
    
    //facebook button
    @IBAction func fbButtonClicked(sender: AnyObject) {
    }
    
    
    override func viewDidLoad() {
        
        currentScroller.contentInset = UIEdgeInsetsMake(0, 0, 400, 0)
        
        //Lbl.text = _json["Name"].string
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //////////////////////table view//////////////////////
    @IBOutlet weak var tableView: UITableView!
    
    
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
        let cell = tableView.dequeueReusableCellWithIdentifier("noArrowCell", forIndexPath: indexPath) as! noArrowTableViewCell
        
        // Configure the cell...
        switch indexPath.row {
        case 0:
            cell.noArrowCellTitle.text = "Name"
            cell.noArrowCellDetail.text = _json["Name"].string
        case 1:
            cell.noArrowCellTitle.text = "Symbol"
            cell.noArrowCellDetail.text = _json["Symbol"].string
        case 2:
            cell.noArrowCellTitle.text = "Last Price"
            cell.noArrowCellDetail.text = "$" + String(format: "%.2f", _json["LastPrice"].double!)
        case 3:
            cell.noArrowCellTitle.text = "Change"
            cell.noArrowCellDetail.text = String(format: "%.2f", _json["Change"].double!) + "(" + String(format: "%.2f", _json["ChangePercent"].double!) + "%)"
        case 4:
            cell.noArrowCellTitle.text = "Time and Date"
            cell.noArrowCellDetail.text = _json["Timestamp"].string
        case 5:
            cell.noArrowCellTitle.text = "Market Cap"
            cell.noArrowCellDetail.text = String(format: "%.2f", _json["MarketCap"].double!/1000000000) + "Billion"
        case 6:
            cell.noArrowCellTitle.text = "Volume"
            cell.noArrowCellDetail.text = String(_json["Volume"].int!)
        case 7:
            cell.noArrowCellTitle.text = "Change YTD"
            cell.noArrowCellDetail.text = String(_json["ChangeYTD"].double!) + "(" + String(format: "%.2f", _json["ChangePercentYTD"].double!) + "%)"
        case 8:
            cell.noArrowCellTitle.text = "High Price"
            cell.noArrowCellDetail.text = "$" + String(format: "%.2f", _json["High"].double!)
        case 9:
            cell.noArrowCellTitle.text = "Low Price"
            cell.noArrowCellDetail.text = "$" + String(format: "%.2f", _json["Low"].double!)
        case 10:
            cell.noArrowCellTitle.text = "Openning Price"
            cell.noArrowCellDetail.text = "$" + String(format: "%.2f", _json["Open"].double!)
        default: break
            
        }
        
        return cell
    }
    
    
}
