# Stock_Search_App

> This project is an iOS App that allows users to search stock information and also a good opportunity for me to play with git.


##Development log

---

Date: 04/15/2016

Key Words: description, iOS dev, Swift

---

###1. Achitechture Overview

![Achitechture Overview](https://www.dropbox.com/s/1ya5sk36235jdhr/Achitecture.png?raw=1)


###2. Related technologies

####2.1 iOS/Xcode/Swift

* Swift/iOS dev tutorial

[iOS 9 App Development with Swift 2 Essential Training](http://www.lynda.com/Swift-tutorials/iOS-9-App-Development-Swift-2-Essential-Training/466181-2.html?org=usc.edu)

[Swift 2.0 Essential Training](http://www.lynda.com/Swift-tutorials/Swift-2-0-Essential-Training/422096-2.html?org=usc.edu)

####2.2 Facebook SDK

####2.3 Markit on Demand API

####2.4 AWS/GAE


###3. Prerequisites

####3.1 CocoaPods

>Using it to install many third party modules and frameworks.

* install cocoapods

```
sudo gem install cocoapods
```

* import third part modules

1) create text file named `Podfile` in your Xcode project directory with following contents:

```
platform :ios, '8.0'
use_frameworks!

pod 'CCAutocomplete'

```

2) install third part module using command

```
pod install
```

3) open the Xcode *workspace* instead of the project file when building your project

####3.2 Facebook Developer Application

###4. Create project

App Name: Stock Search

---

Date: 04/16/2016

Key Words: Search form, autocomplete

---

###1. search form

####1. Get Quote `Button`

1) Model-View-Controller Design pattern ---> it is the way we organize code in xCode

1.1) Model 

* some kind of data structure, it is just the raw data

* swift file, XML file, database, ...

1.2) View

* the look of things

* `.storyboard` file

1.3) Controller

* connect Model and View

* `ViewController.swift` file

2) connect `Button` view to controller

* right click button view and drag to  controller code

* outlet/action

> outlet : view object itself as a variable
> 
> action : use view object to trigger an action

####2. input `Text Field`

2.1) CCAutocomplete

* how to import CCAutocomplete module in `ViewController.swift`

```
import CCAutocomplete
```
*build* project to make it work!

* how to use functions of the module

```
extension ViewController: AutocompleteDelegate {
	func autoCompleteTextField() -> UITextField {
        return self.inputTextField
    }

    func ...
}
```

###2. Auto layout

* `Lable` Stock Search 

* `Text Field` input text field

* `Button` Get Quote

* `View` Autocomplete Container View

---

Date: 04/17/2016

Key Words: Swift

---

###1. function

###2. class

###3. protocol

###4. Array, Dictionary, Set

###5. Tuple

###6. String

---

Date: 04/18/2016

Key Words: autocomplete

---


###1. autocomplete

####1) adjust max height for dispaying autocomplete items

####2) CLEAR button in the right of ‘UITextField’

* `Text Field` attribute: Clear Button

####3) Lookup request

#####3.1) HTTP request using Alamofire

##### install

in `Podfile`, add below and 

```
pod 'Alamofire', '~> 3.3'
```

in command line
```
pod install
```

##### usage

* `import Alamofire` and build project

* request and JSON response

```
Alamofire.request(.GET, "xxxxx.com/", parameters: ["lookupInput": term])
            .responseJSON { response in
                if let JSON = response.result.value {
                    print(JSON)
                }
        }
```

#####3.2) parse JSON to array ----> SwiftJSON lib

#####3.3) problem with `Transport Security has Blocked a cleartext HTTP`

>add below to `info.plist`
>
>change `www.yourwebservicedomain.com` to your responding server domain

```
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSExceptionDomains</key>
    <dict>
        <key>www.yourwebservicedomain.com</key>
        <dict>
            <key>NSExceptionAllowsInsecureHTTPLoads</key>
            <true/>
            <key>NSExceptionMinimumTLSVersion</key>
            <string>TLSv1.1</string>
            <key>NSIncludesSubdomains</key>
            <true/>
        </dict>
    </dict>
</dict>
```

#####3.4) Alamofire-Synchronous

* install

```
pod 'Alamofire-Synchronous', :git => 'https://github.com/Dalodd/Alamofire-Synchronous.git'
```

* usage

```
import Alamofire_Synchronous
```

```
//json
let response = Alamofire.request(.GET, "https://httpbin.org/get", parameters: ["foo": "bar"]).responseJSON()
if let json = response.result.value {
    print(json)
}
```

####3.5) empty JSON handle

`if` condition

###2. Get Quote Button

####1) input validation

1.1) empty

1.2) unmatch

* Problem about text in Text Field: select from cell Vs. not select from cell

> define `var userInputSeletedFromCells = false` to check and handle different condition


---

Date: 04/19/2016

Key Words: GET QUOTE

---

###1. Create new view for Stock Details

1.1) create `View Controller` in storyboard

1.2) create `StockDetailsView.swift` and  link new 'View Controller' to it

```
class StockDetailsView: UIViewController {
    
    override func viewDidLoad() {
        //code
    }
    
}
```

###2. transition between Views

* button -> drag to other view -> Action Segue: Show

* Navigation Controller

###3. JSON data transition between views

* segue

```
override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) { ... }
```

###4. input validation

* stop segue

```
override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject!) -> Bool { ... }
```

###4. Set navigation bar title

```
override func viewDidLoad() {
    self.title = _json["Symbol"].string
}
```

###5. Three buttons(Current, Historical, News) to navigate between 3 pages

* segmented control


---

Date: 04/20/2016

Key Words: Stock Details(Current)

---

###1. UIScrollView

###2. send data between UIViewController

* segue

###3. current page

3.1) Scroller

* how to create more space to contain and edit TableView and ImageView

> View Controller -> Simulated Size: Freedom -> width & heigh

3.2) Table view

* Custom Table View Cell

3.3) Daily chart


---

Date: 04/21/2016

Key Words: table view layout, facebook

---

###1. table view layout

###2. facebook

`FBSDKShareLinkContent`  and `FBSDKShareDialog`

---

Date: 04/29/2016

Key Words: historical chart

---

###1. `UIWebView`

#### BUG: `webView.stringByEvaluatingJavaScriptFromString("xxxx")` does not work

---

Date: 04/30/2016

Key Words: historical chart, news

---

###1. `UIWebView`

#### BUG-FIXED: `webView.stringByEvaluatingJavaScriptFromString("xxxx")` does not work

#### Analysis:

At the beginning, I called `stringByEvaluatingJavaScriptFromString` inside `viewDidLoad()`, but `viewDidLoad()` *do not mean* `webViewDidFinishLoad()`, so the calling has not effect since the web page doesn't ready.

Calling `stringByEvaluatingJavaScriptFromString` inside `webViewDidFinishLoad()` ensures we can excute our JS code after everything is ready.


```
func webViewDidFinishLoad(webView: UIWebView) {
        webView.stringByEvaluatingJavaScriptFromString("drawHighstock('\(self.stockSymbol)')");
    }
```

#### Key:

1) `UIWebViewDelegate` and `func webViewDidFinishLoad(webView: UIWebView)`

2) *Do not* miss those sigle quote when pass swift data as JS function parameters

###2. news

BUG: cannot write data into table cell

BUG-FIXed: drag table view to View controller to link table and view controller for `dataSource` and `delegate`.

---

Date: 04/30/2016

Key Words: favourite list

---

###1. adding core data

BUG: how to assign variable from other view controller in swift

DEBUG : using instance reference

key :

1) passing instance reference using segue
























