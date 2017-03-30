//
//  AppDelegate.swift
//  ShapeLayerAnimation
//
//  Created by 杨晴贺 on 2017/3/30.
//  Copyright © 2017年 Silence. All rights reserved.
//

import UIKit

let SRect = UIScreen.main.bounds
let SHeight = SRect.size.height
let SWidth = SRect.size.width

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: SRect)
        
        let nav = UINavigationController(rootViewController: ViewController())
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        
        return true
    }


}

