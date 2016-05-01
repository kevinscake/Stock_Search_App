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


class HistoricalChartViewController: UIViewController, UIWebViewDelegate {
    
    var _json: JSON  = []
    var stockSymbol:String = ""
    
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        webView.delegate = self
        
        stockSymbol = _json["Symbol"].string!;
        
        let localfilePath = NSBundle.mainBundle().URLForResource("highstock", withExtension: "html");
        let myRequest = NSURLRequest(URL: localfilePath!);
        webView.loadRequest(myRequest);
        

    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        webView.stringByEvaluatingJavaScriptFromString("drawHighstock('\(self.stockSymbol)')");
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
