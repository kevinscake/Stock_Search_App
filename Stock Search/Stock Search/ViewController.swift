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



class ViewController: UIViewController {
    
    
    
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
    
    //hide navigation bar
    override func viewWillAppear(animated: Bool)
    {
        self.navigationController?.navigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

