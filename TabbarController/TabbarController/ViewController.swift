//
//  ViewController.swift
//  TabbarController
//
//  Created by 杨晴贺 on 2017/3/30.
//  Copyright © 2017年 Silence. All rights reserved.
//

import UIKit

class ViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor.white
        
        let avc = AVC()
        avc.title = "AVC"
        avc.tabBarItem.title = "A"
        avc.tabBarItem.image = UIImage(named: "Game")
        
        let bvc = BVC()
        let bnv = UINavigationController(rootViewController: bvc)
        bvc.title = "BVC"
        bvc.tabBarItem.title = "B"
        bvc.tabBarItem.image = UIImage(named: "Home")
        
        let cvc = CVC()
        cvc.title = "CVC"
        cvc.tabBarItem.title = "C"
        cvc.tabBarItem.image = UIImage(named: "Setting")
        
        viewControllers = [avc, bnv, cvc]
    }


}

