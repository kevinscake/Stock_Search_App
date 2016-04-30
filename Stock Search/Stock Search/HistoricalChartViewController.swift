//
//  HistoricalChartViewController.swift
//  Stock Search
//
//  Created by Jiayuan Huang on 4/29/16.
//  Copyright © 2016 Jiayuan Huang. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON


class HistoricalChartViewController: UIViewController {
    
    var _json: JSON  = []
    
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        
            super.viewDidLoad()

            //let stockSymbol:String = _json["Symbol"].string!;
            
            let localfilePath = NSBundle.mainBundle().URLForResource("highstock", withExtension: "html");
            let myRequest = NSURLRequest(URL: localfilePath!);
            webView.loadRequest(myRequest);
            //webView.stringByEvaluatingJavaScriptFromString("stockSymbol = \(stockSymbol)");
            //webView.stringByEvaluatingJavaScriptFromString("document.getElementById('historicalCharts').innerHTML = '!!!!!!!!!HELP!!!!!!!!!!'")
        webView.stringByEvaluatingJavaScriptFromString("alertWindow()")
        
        
            print(_json)
    
    }
    
//    func webViewDidFinishLoad(webView: UIWebView) {
//        webView.stringByEvaluatingJavaScriptFromString("document.getElementById('historicalCharts').innerHTML = '!!!!!!!!!HELP!!!!!!!!!!'")
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
