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
    var player: SJVideoPlayer!
    var url = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        player = SJVideoPlayer()
        
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
        
//        player.deviceVolumeAndBrightnessManager.volume = 1.0
    }
}
