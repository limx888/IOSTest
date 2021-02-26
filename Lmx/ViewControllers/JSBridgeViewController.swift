//
//  ViewController.swift
//  JSBridgeIOSSwift
//
//  Created by Lmx on 2021/2/23.
//  Copyright © 2021 Lmx. All rights reserved.
//

import UIKit
import WebKit

//尺寸设置
let aiScreenWidth = UIScreen.main.bounds.size.width
let aiScreenHeight = UIScreen.main.bounds.size.height
let STATUS_BAR_HEIGHT = UIApplication.shared.statusBarFrame.size.height

class JSBridgeViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {
    
    var webView: WKWebView!
    var bridge: WebViewJavascriptBridge!
    var webConfig: WKWebViewConfiguration!
    
    var btn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 初始化 WKWebViewConfiguration 对象
        webConfig = WKWebViewConfiguration()
        
        // 设置 webConfig 属性
        setWebConfig()
        
        // 初始化 WKWebView
        initWebView()
        
        // 注册与 H5 交互的事件函数
        registerHandlers()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        automaticallyAdjustsScrollViewInsets = false
    }
    
    /**
     * 设置 webConfig 属性
     */
    func setWebConfig() {
        
        // 设置偏好设置
        webConfig.preferences = WKPreferences()
        // 默认为0
        webConfig.preferences.minimumFontSize = 10
        // 默认认为YES
        webConfig.preferences.javaScriptEnabled = true
        // 在iOS上默认为NO，表示不能自动通过窗口打开
        webConfig.preferences.javaScriptCanOpenWindowsAutomatically = false
    }
    
    /**
     * 初始化 WKWebView
     */
    func initWebView() {
        webView = WKWebView(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height - 80), configuration: webConfig!)
        // 设置 UserAgent 后缀
        webView.customUserAgent = String(format: webView!.customUserAgent!, "app")
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        let bundlePath = Bundle.main.bundlePath
        let URLSTR = "file://\(bundlePath)/business.html"
//        let URLSTR = "http://95.169.3.56/bussiness.html"
        
        let url = URL(string: URLSTR)
        var urlRequest: URLRequest? = nil
        if let url = url {
            urlRequest = URLRequest(url: url)
        }
        if let urlRequest = urlRequest {
            webView.load(urlRequest)
        }
        view.addSubview(webView)
        btn = UIButton(frame: CGRect(x: 0, y: view.bounds.size.height - 80, width: view.bounds.size.width, height: 80))
        btn.setTitle("返回数据给Html", for: .normal)
        btn.backgroundColor = .blue
        btn.addTarget(self, action: #selector(callbackToHtml), for: .touchUpInside)
        view.addSubview(btn)
    }
    
    /**
     * 初始化布局
     */
    func initLayout() {
        webView.snp.makeConstraints{(make) -> Void in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalToSuperview().offset(80)
        }
        
        btn.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(webView.snp.bottom)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    /**
     * 使用 WebViewJavascriptBridge 注册与 H5 交互的事件函数
     */
    func registerHandlers() {
        // 启用 WebViewJavascriptBridge
        WebViewJavascriptBridge.enableLogging()
        
        // 初始化 WebViewJavascriptBridge
        bridge = WebViewJavascriptBridge(forWebView: webView!);
        bridge.setWebViewDelegate(self);

        // 注册刷新页面的 reloadUrl 函数
        bridge.registerHandler("businessScanRes", handler: { data, responseCallback in
            self.webView?.reload()
            JSBridgeViewController.addToast(with: "刷新成功~", in: self.view)
            responseCallback?("")
        })

        // 注册修改 User 名称的 changeUser 函数
        bridge.registerHandler("businessScan", handler: { data, responseCallback in
            responseCallback?("1111111")
        })
    }
    
    /**
     * 修改 name 按钮被点击时触发
     */
    @objc func callbackToHtml() {
        // 调用 H5 界面的 changeName 事件函数
        bridge.callHandler("businessScanRes", data: "返回数据", responseCallback: { responseData in
            JSBridgeViewController.addToast(with: "返回成功", in: self.view)
        })
    }
    
    
    /**
     * 判断字符串是否为空或者 null 的方法
     */
    class func judgeIsEmpty(with string: String?) -> Bool {
        if (string?.count ?? 0) == 0 || (string == "") || string == nil || string == nil || string?.isEqual(NSNull()) ?? false {
            return true
        }
        return false
    }
    
    /**
     * 模拟 Toast效果 的工具方法
     */
    class func addToast(with string: String?, in view: UIView?) {
        
        let initRect = CGRect(x: 0, y: STATUS_BAR_HEIGHT, width: aiScreenWidth, height: 0)
        let rect = CGRect(x: 0, y: STATUS_BAR_HEIGHT, width: aiScreenWidth, height: 22)
        let label = UILabel(frame: initRect)
        label.text = string
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 14)
        label.backgroundColor = UIColor(red: 0, green: 0.6, blue: 0.9, alpha: 0.6)
        
        view?.addSubview(label)
        
        //弹出label
        UIView.animate(withDuration: 0.5, animations: {
            
            label.frame = rect
        }) { finished in
            //弹出后持续1s
            Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(removeToast(withView:)), userInfo: label, repeats: false)
        }
    }
    
    /**
     * 移除 Toast
     */
    @objc class func removeToast(withView timer: Timer?) {
        
        let label = timer?.userInfo as? UILabel
        
        let initRect = CGRect(x: 0, y: STATUS_BAR_HEIGHT, width: aiScreenWidth, height: 0)
        //    label消失
        UIView.animate(withDuration: 0.5, animations: {
            
            label?.frame = initRect
        }) { finished in
            
            label?.removeFromSuperview()
        }
    }
    
}



