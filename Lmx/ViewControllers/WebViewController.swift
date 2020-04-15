//
//  WebViewController.swift
//  Lmx
//
//  Created by Lmx on 2020/4/13.
//  Copyright © 2020 Lmx. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    var url = ""

    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        webView = WKWebView(frame: view.frame)
        // 下面一行代码意思是充满的意思(一定要加，不然也会显示有问题)
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        view.addSubview(webView)

        let mapwayURL = URL(string: url)!
        let mapwayRequest = URLRequest(url: mapwayURL)
        webView.load(mapwayRequest)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
