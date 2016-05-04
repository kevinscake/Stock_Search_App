//
//  NewsViewController.swift
//  Stock Search
//
//  Created by Jiayuan Huang on 4/30/16.
//  Copyright © 2016 Jiayuan Huang. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import Alamofire
import Alamofire_Synchronous

class NewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var _json: JSON = []
    
    var _jsonNews: JSON = []
    
    
    // Define a notification key
    let loadNewsNotificationKey = "loadNews"
    
    
    
    override func viewDidLoad() {
        
        //Synchronous Http call ----- news
        let response = Alamofire.request(.GET, "http://gentle-dominion-127300.appspot.com/", parameters: ["bing_symbol": _json["Symbol"].string!]).responseJSON()
        if let value = response.result.value {
            
            //SwiftyJSON's JSON type
            _jsonNews = JSON(value)
            
        }
        
        //Observe (listen for) "special notification key"
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.reloadNews), name: loadNewsNotificationKey, object: nil)
    }
    
    //Implement function to act on notification
    func reloadNews() {
        //Synchronous Http call ----- news
        let response = Alamofire.request(.GET, "http://gentle-dominion-127300.appspot.com/", parameters: ["bing_symbol": _json["Symbol"].string!]).responseJSON()
        if let value = response.result.value {
            
            //SwiftyJSON's JSON type
            _jsonNews = JSON(value)
            
        }
        
        newsTable.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    
    //////////////////news table view//////////////////
    @IBOutlet weak var newsTable: UITableView!
    
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("newsCell", forIndexPath: indexPath) as! newsTableCell
        
        let _jsonSignleNews: JSON = _jsonNews["d"]["results"][indexPath.row]
        
        // Configure the cell...
        cell.title.text = _jsonSignleNews["Title"].string!
        cell.content.text = _jsonSignleNews["Description"].string!
        cell.publisher.text = _jsonSignleNews["Source"].string!
        cell.date.text = _jsonSignleNews["Date"].string!
        
        return cell;
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //open url in safari when cell is cliced
        let _jsonSignleNews: JSON = _jsonNews["d"]["results"][indexPath.row]
        let url: String = _jsonSignleNews["Url"].string!
        UIApplication.sharedApplication().openURL(NSURL(string: url)!)
        
        //remove selected highlight effect
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    
}