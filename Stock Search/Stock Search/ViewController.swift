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
        Alamofire.request(.GET, "http://gentle-dominion-127300.appspot.com/", parameters: ["lookupInput": term])
            .responseJSON { response in
                if let JSON = response.result.value {
                    print(JSON)
                }
        }
        
        
        
        var countries: [AutocompletableOption] = []
        
        for countryName in self.stockList {
            countries.append(AutocompleteCellData(text: countryName, image: nil))
        }
        
        return countries;
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

