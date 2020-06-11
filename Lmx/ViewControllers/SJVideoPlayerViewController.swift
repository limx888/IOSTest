//
//  SJVideoPlayerViewController.swift
//  Lmx
//
//  Created by Lmx on 2020/4/13.
//  Copyright © 2020 Lmx. All rights reserved.
//

import UIKit
import SJVideoPlayer

class SJVideoPlayerViewController: UIViewController {
    var player: SJVideoPlayer = SJVideoPlayer()
    var url = ""
    let appDelegate:AppDelegate = (UIApplication.shared.delegate) as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(player.view)
        player.view.translatesAutoresizingMaskIntoConstraints = false
        player.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        player.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        player.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        player.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        // Do any additional setup after loading the view.
        
//        URL(fileURLWithPath: <#T##String#>)
        let videoPlayerUrl = URL(string: url)!
        let asset = SJVideoPlayerURLAsset(url: videoPlayerUrl)
        
        player.urlAsset = asset
        //调整设备亮度
//        player.deviceVolumeAndBrightnessManager.brightness = 1.0
        //调整设备声音
//        player.deviceVolumeAndBrightnessManager.volume = 1.0
        //是否竖屏时隐藏返回按钮
        player.defaultEdgeControlLayer.isHiddenBackButtonWhenOrientationIsPortrait = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        appDelegate.blockRotation = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        player.vc_viewDidAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        appDelegate.blockRotation = false
        player.vc_viewWillDisappear()
        
        //判断退出时是否是横屏
        if UIApplication.shared.statusBarOrientation.isLandscape {
            //是横屏让变回竖屏
            setNewOrientation(fullScreen: false)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        player.vc_viewDidDisappear()
    }
    
    //横竖屏设置
    func setNewOrientation(fullScreen: Bool) {
        if fullScreen { //横屏
            let resetOrientationTargert = NSNumber(integerLiteral: UIInterfaceOrientation.unknown.rawValue)
            UIDevice.current.setValue(resetOrientationTargert, forKey: "orientation")
            
            let orientationTarget = NSNumber(integerLiteral: UIInterfaceOrientation.landscapeLeft.rawValue)
            UIDevice.current.setValue(orientationTarget, forKey: "orientation")
            
        } else { //竖屏
            let resetOrientationTargert = NSNumber(integerLiteral: UIInterfaceOrientation.unknown.rawValue)
            UIDevice.current.setValue(resetOrientationTargert, forKey: "orientation")
            
            let orientationTarget = NSNumber(integerLiteral: UIInterfaceOrientation.portrait.rawValue)
            UIDevice.current.setValue(orientationTarget, forKey: "orientation")
        }
    }
}
