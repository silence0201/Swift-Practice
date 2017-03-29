//
//  AppDelegate.swift
//  CustomFont
//
//  Created by 杨晴贺 on 2017/3/29.
//  Copyright © 2017年 Silence. All rights reserved.
//

import UIKit

let ScreenRect: CGRect = UIScreen.main.bounds
let ScreenWidth: CGFloat = ScreenRect.width
let ScreenHeight: CGFloat = ScreenRect.height


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: ScreenRect)
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
        
        return true
    }


}

