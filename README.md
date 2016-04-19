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

Key Words: 

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

* parse JSON to array ----> SwiftJSON lib

#####problem with `Transport Security has Blocked a cleartext HTTP`

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

#####


















