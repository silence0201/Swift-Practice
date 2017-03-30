//
//  AppDelegate.swift
//  AnimatedSplash
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
    let mask = CALayer()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: SRect)
        window?.rootViewController = ViewController()
        
        mask.contents = UIImage(named: "twitter")?.cgImage // 这里需要是CGImage
        mask.contentsGravity = "resizeAspect" // 图片显示风格
        mask.bounds = CGRect(x: 0, y: 0, width: 100, height: 100) // 边界
        mask.position = CGPoint(x: SWidth/2, y: SHeight/2) // 位置

        window?.rootViewController?.view.layer.mask = mask
        window?.backgroundColor = UIColor(red: 31/255.0, green: 150/255.0, blue: 1, alpha: 1)
        
        animateMask()
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func animateMask() {
        let keyFrameAnimation = CAKeyframeAnimation(keyPath: "bounds")
        keyFrameAnimation.delegate = self
        keyFrameAnimation.duration = 0.6
        keyFrameAnimation.beginTime =  CACurrentMediaTime() + 0.5
        keyFrameAnimation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut),CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)]
        let firstBounds = NSValue(cgRect: mask.bounds)
        let secondBounds = NSValue(cgRect: CGRect(x: 0, y: 0, width: 300, height: 300))
        let finalBounds = NSValue(cgRect: CGRect(x: 0, y: 0, width: 1100, height: 1100))
        keyFrameAnimation.values = [firstBounds, secondBounds, finalBounds]
        keyFrameAnimation.keyTimes = [0, 0.8, 1]
        mask.add(keyFrameAnimation, forKey: "bounds")
    }
}

extension AppDelegate: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        window?.rootViewController?.view.layer.mask = nil
    }
}

