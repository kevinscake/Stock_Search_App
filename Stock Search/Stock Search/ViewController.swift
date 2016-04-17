//
//  ViewController.swift
//  Stock Search
//
//  Created by Jiayuan Huang on 4/15/16.
//  Copyright © 2016 Jiayuan Huang. All rights reserved.
//

import UIKit
import CCAutocomplete



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
    
    /////////////required methods////////////
    
    //Returns UITextField we want to apply autocomplete for
    func autoCompleteTextField() -> UITextField {
        return self.inputTextField
    }
    
    //Returns minimum number of characters to start showing autocomplete
    func autoCompleteThreshold(textField: UITextField) -> Int {
        return 0
    }
    
    //Returns array of objects that conform to AutocompletableOption to be shown in the list of autocomplete
    func autoCompleteItemsForSearchTerm(term: String) -> [AutocompletableOption] {
        
        let filteredCountries  = self.stockList.filter { (country) -> Bool in
            return country.lowercaseString.containsString(term.lowercaseString)
        }
        
        
        let countriesAndFlags: [AutocompletableOption] = filteredCountries.map { (var country) -> AutocompleteCellData in
            country.replaceRange(country.startIndex...country.startIndex, with: String(country.characters[country.startIndex]).capitalizedString)
            return AutocompleteCellData(text: country, image: UIImage(named: country))
            }.map( { $0 as AutocompletableOption })
        
        return countriesAndFlags
    }
    
    //Maximum height which shows autocomplete items
    func autoCompleteHeight() -> CGFloat {
        return CGRectGetHeight(self.view.frame) / 3.0
    }
    
    //Is getting called when we tapped on the autocomplete item
    func didSelectItem(item: AutocompletableOption) {
        //item.text is what user selected
    }
}

