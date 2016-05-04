//
//  ViewController.swift
//  Stock Search
//
//  Created by Jiayuan Huang on 4/15/16.
//  Copyright © 2016 Jiayuan Huang. All rights reserved.
//

import UIKit
import CCAutocomplete
import Alamofire
import SwiftyJSON
import Alamofire_Synchronous
import CoreData



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    // Retreive the managedObjectContext from AppDelegate
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    
    ////////////////////////search form////////////////////
    //input text field
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var autocompleteContainerView: UIView!
    //var userInput:String = ""
    var _json: JSON = []
    var isInputValid = false
    
    var isFirstLoad: Bool = true
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if self.isFirstLoad {
            self.isFirstLoad = false
            Autocomplete.setupAutocompleteForViewcontroller(self)
        }
    }
    
    //get quote button
    @IBAction func getQuoteClicked(sender: AnyObject) {
        
    }
    
    
    
    
    //This method is called whenever ANY segue is called
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //check if the identifier of the segue happening is the one we think
        if segue.identifier == "ShowStockDetails" {
            //If segue.destinationViewController can be cast to OtherViewController, then it can be referred to with StockDetailsViewController now.  If not, the if statement evaluates to false, do nothing
            if let StockDetailsViewController: StockDetailsView = segue.destinationViewController as? StockDetailsView {
                
                StockDetailsViewController._json = self._json
                StockDetailsViewController.viewController = self
            }
        }
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject!) -> Bool {
        if identifier == "ShowStockDetails" {
            
            //init
            isInputValid = false
            
            ///////////////////////////////validation///////////////////////////////
            let userInput: String = inputTextField.text!
            
            //1. empty input
            if (inputTextField.text!.isEmpty) {
                
                //alert
                let alertController = UIAlertController(
                    title: "Please Enter a Stock Name or Symbol",
                    message: "", preferredStyle: UIAlertControllerStyle.Alert)
                
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
                
                self.presentViewController(alertController, animated: true, completion: nil)
                
                return false
            }
            
            //2. invalid symbol
            //Synchronous Http call ----- lookup
            let response = Alamofire.request(.GET, "http://gentle-dominion-127300.appspot.com//", parameters: ["lookupInput": userInput]).responseJSON()
            if let value = response.result.value {
                
                //SwiftyJSON's JSON type
                let json = JSON(value)
                
                if(json.isEmpty){
                    
                    //alert
                    let alertController = UIAlertController(
                        title: "Invalid Symbol",
                        message: "", preferredStyle: UIAlertControllerStyle.Alert)
                    
                    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
                    
                    self.presentViewController(alertController, animated: true, completion: nil)
                }
                else {
                    isInputValid = true
                }
            }
            
            //3. valid symbol
            var isStockInfoAvailable = false
            
            if isInputValid {
                
                //Synchronous Http call ----- get quote
                let response = Alamofire.request(.GET, "http://gentle-dominion-127300.appspot.com/", parameters: ["quoteInput": userInput]).responseJSON()
                if let value = response.result.value {
                    
                    //SwiftyJSON's JSON type
                    let json = JSON(value)
                    
                    //no stock info available
                    if(json["Status"] != "SUCCESS"){
                        //alert
                        let alertController = UIAlertController(
                            title: "No Stock Info Available",
                            message: "", preferredStyle: UIAlertControllerStyle.Alert)
                        
                        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
                        
                        self.presentViewController(alertController, animated: true, completion: nil)
                        
                        
                    }
                    //stock info availabe
                    else {
                        isStockInfoAvailable = true
                        self._json = json
                    }
                }
                
                if isStockInfoAvailable {
                    return true
                }
                else {
                    return false
                }
            }
            else {
                return false
            }
        }
        
        // by default, transition
        return true
    }
    
    
    //fetch favourite stock info
    override func viewWillAppear(animated: Bool)
    {
        //hide navigation bar
        self.navigationController?.navigationBarHidden = true
        
        
        super.viewWillAppear(animated)
        //load favourite stock
        //1
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let fetchRequest = NSFetchRequest(entityName: "FavouriteStock")
        
        //3
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            favouriteStock = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        //switch state
        refreshSwitch.addTarget(self, action: Selector("switchIsChanged:"), forControlEvents: UIControlEvents.ValueChanged)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    ////////////////////////favourite list table////////////////////
    var favouriteStock = [NSManagedObject]()
    
    @IBOutlet weak var favouriteTable: UITableView!
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return favouriteStock.count
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("favouriteCell", forIndexPath: indexPath) as! favouriteTableCell
        
        let stock = favouriteStock[indexPath.row]
        
        let symbol = stock.valueForKey("symbol") as? String
        //Synchronous Http call ----- get quote
        let response = Alamofire.request(.GET, "http://gentle-dominion-127300.appspot.com/", parameters: ["quoteInput": symbol!]).responseJSON()
        if let value = response.result.value {
            //SwiftyJSON's JSON type
            let json = JSON(value)
            // Configure the cell...
            cell.symbol.text = json["Symbol"].string!
            cell.companyName.text = json["Name"].string!
            cell.price.text = "$" + String(format: "%.2f", json["LastPrice"].double!)
            cell.change.text = String(format: "%.2f", json["Change"].double!) + "(" + String(format: "%.2f", json["ChangePercent"].double!) + "%)"
            //determine lable background color
            if(Double(round(1000*json["Change"].double!)/1000)>0) {
                cell.change.backgroundColor = UIColor.greenColor()
                cell.change.textColor = UIColor.whiteColor()
            }
            if(Double(round(1000*json["Change"].double!)/1000)<0) {
                cell.change.backgroundColor = UIColor.redColor()
                cell.change.textColor = UIColor.whiteColor()
            }
            
            cell.marketCap.text = "Market Cap: " + String(format: "%.2f", json["MarketCap"].double!/1000000000) + " Billion"
        }
        
        return cell
        
    }
    
    //this tells the UITableView that we can edit(delete) these rows
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    //this method gets called upon performing the swipe-to-delete action
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        // Find the LogItem object the user is trying to delete
        let stockToDelete = favouriteStock[indexPath.row]
        
        // Delete it from the managedContext
        managedObjectContext.deleteObject(stockToDelete)
        
        // Updated favouriteStock & Refresh the table view to indicate that it's deleted
        let fetchRequest = NSFetchRequest(entityName: "FavouriteStock")
        
        do {
            let results = try managedObjectContext.executeFetchRequest(fetchRequest)
            favouriteStock = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        // Tell the table view to animate out that row
        favouriteTable.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
    

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //retieve stock symbol
        let symbol = favouriteStock[indexPath.row].valueForKey("symbol") as? String
        
        //Synchronous Http call ----- get quote
        let response = Alamofire.request(.GET, "http://gentle-dominion-127300.appspot.com/", parameters: ["quoteInput": symbol!]).responseJSON()
        if let value = response.result.value {
            
            //SwiftyJSON's JSON type
            self._json = JSON(value)
            
        }
        
        //view transit
        performSegueWithIdentifier("ShowStockDetails", sender: nil)
        
        //remove selected highlight effect
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    ////////////////////refresh////////////////////
    
    @IBOutlet weak var loadingIndicatorView: UIActivityIndicatorView!
    //manual
    @IBAction func refreshButtonClicked(sender: AnyObject) {
        
        loadingIndicatorView.startAnimating()
        favouriteTable.reloadData()
        loadingIndicatorView.performSelector(#selector(ViewController.stopAnimating), withObject: nil, afterDelay: 2)
    }
    
    func stopAnimating(){
        loadingIndicatorView.stopAnimating()
    }
    
    //auto
    @IBOutlet weak var refreshSwitch: UISwitch!
    var refreshTimer = NSTimer()
    
    func switchIsChanged(mySwitch: UISwitch) {
        if mySwitch.on {
            refreshTimer = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: #selector(self.favouriteTableReload), userInfo: nil, repeats: true)
        }
        else {
            refreshTimer.invalidate()
        }
    }
    
    func favouriteTableReload() {
        loadingIndicatorView.startAnimating()
        favouriteTable.reloadData()
        loadingIndicatorView.performSelector(#selector(ViewController.stopAnimating), withObject: nil, afterDelay: 2)
    }
    
    


}


//let ViewController containing the UITextField conform to AutocompleteDelegate protocol
extension ViewController: AutocompleteDelegate {
    
    ////////////////////required methods////////////////////
    
    //Returns UITextField we want to apply autocomplete for
    func autoCompleteTextField() -> UITextField {
        return self.inputTextField
    }
    
    //Returns minimum number of characters to start showing autocomplete
    func autoCompleteThreshold(textField: UITextField) -> Int {
        return 2
    }
    
    //Returns array of objects that conform to AutocompletableOption to be shown in the list of autocomplete
    func autoCompleteItemsForSearchTerm(term: String) -> [AutocompletableOption] {
        
        //lookup request
        var stocks: [AutocompletableOption] = []
        //userInputSeletedFromCells = false

        
        //Synchronous Http call ----- look up
        let response = Alamofire.request(.GET, "http://gentle-dominion-127300.appspot.com/", parameters: ["lookupInput": term]).responseJSON()
        if let value = response.result.value {
            
            //SwiftyJSON's JSON type
            let json = JSON(value)
            
            if(!json.isEmpty){
                
                var symbol:String
                var name:String
                var exchange:String
                
                for item in json {
                    //get json Object
                    let jsonOfItem = item.1
                    symbol = jsonOfItem["Symbol"].string!
                    name = jsonOfItem["Name"].string!
                    exchange = jsonOfItem["Exchange"].string!
                    
                    let cellText = symbol + "-" + name + "-" + exchange
                    
                    //build return autocomplete items array
                    stocks.append(AutocompleteCellData(text: cellText, image: nil))
                }
            }
        }
        
        //return stocks
        return stocks

    }
    
    //Maximum height which shows autocomplete items
    func autoCompleteHeight() -> CGFloat {
        //height of each cell is 60, 4*60 allows at most display 4 cells
        return 240
    }
    
    //Is getting called when we tapped on the autocomplete item
    func didSelectItem(item: AutocompletableOption) {
        //item.text is what user selected
        //userInputSeletedFromCells = true
        let myStringArr = item.text.componentsSeparatedByString("-")
        inputTextField.text = myStringArr[0]
        
    }
    
    
}

