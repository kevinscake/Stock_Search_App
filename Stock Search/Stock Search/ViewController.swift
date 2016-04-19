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



class ViewController: UIViewController {
    
    
    
    ////////////////////////search form////////////////////
    //input text field
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var autocompleteContainerView: UIView!
    
    let stockList = ["African Union",
                     "Andorra",
                     "Armenia",
                     "Austria",
                     "Bahamas",
                     "Barbados",
                     "Belarus",
                     "Belgium",
                     "Benin",
                     "Bolivia",
                     "Bosnia and Herzegovina",
                     "Botswana",
                     "Brazil",
                     "Bulgaria",
                     "Burkina Faso"
                    ]
    
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
        
        //validation

        //valid input: request to server
        
        //invalid input: alert message, no request
        
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
        
        Alamofire.request(.GET, "http://gentle-dominion-127300.appspot.com/", parameters: ["lookupInput": term])
            .responseJSON{ response in
                
                //error check
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print("error happen!")
                    return
                }
                
                //get SwityJSON's JSON type
                if let value = response.result.value {
                    let json = JSON(value)
                    
                    var symbol:String
                    //                    var name:String = json[0]["Name"].string!
                    //                    var exchange:String = json[0]["Exchange"].string!
                    
                    for item in json {
                        let jsonOfItem = item.1
                        
                        symbol = jsonOfItem["Symbol"].string!
                        
                        stocks.append(AutocompleteCellData(text: symbol, image: nil))
                    }
                    
                    //debug
                    print(stocks)
                    
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
    }
    
    
}

