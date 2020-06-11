//
//  AppDelegate.swift
//  Lmx
//
//  Created by Lmx on 2019/3/29.
//  Copyright © 2019 Lmx. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    // 是否允许横竖屏切换
    var blockRotation: Bool = false
    
    /* 通过blockRotation字段动态设置某个页面开启横竖屏 */
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        if blockRotation {
            return .allButUpsideDown
        }
        
        return .portrait
    }
    
}

