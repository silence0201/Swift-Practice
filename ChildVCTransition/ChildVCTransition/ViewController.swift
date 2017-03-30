//
//  ViewController.swift
//  ChildVCTransition
//
//  Created by 杨晴贺 on 2017/3/30.
//  Copyright © 2017年 Silence. All rights reserved.
//

import UIKit

let JumpNotification = "JUMP"

class ViewController: UIViewController {

    var currentChildNumber = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        setupChild()
    }
    
    private func setupChild() {
        addChildViewController(ChildAVC())
        addChildViewController(ChildBVC())
        
        view.addSubview((childViewControllers.first?.view)!)
        
        // 监听跳转通知
        NotificationCenter.default.addObserver(self, selector: #selector(jump), name: NSNotification.Name(rawValue: JumpNotification), object: nil)
    }
    
    func jump() {
        //options:跳转的方式
        transition(from: currentChildNumber==0 ? childViewControllers.first! : childViewControllers.last!,
                   to: currentChildNumber==0 ? childViewControllers.last! : childViewControllers.first!,
                   duration: 1,
                   options: currentChildNumber==0 ? .transitionFlipFromLeft : .transitionFlipFromRight,
                   animations: nil,
                   completion: nil)
        currentChildNumber = currentChildNumber == 0 ? 1 : 0
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: JumpNotification), object: nil)
    }


}

