//
//  ChildBVC.swift
//  ChildVCTransition
//
//  Created by 杨晴贺 on 2017/3/30.
//  Copyright © 2017年 Silence. All rights reserved.
//

import UIKit

class ChildBVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageView = UIImageView(frame: SRect)
        imageView.image = UIImage(named: "2")
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        
        view.backgroundColor = UIColor.orange
        let tap = UITapGestureRecognizer(target: self, action: #selector(jump))
        view.addGestureRecognizer(tap)
    }
    
    func jump() {
        // 发送跳转通知
        NotificationCenter.default.post(name: NSNotification.Name(rawValue:JumpNotification), object: nil)
    }
}
