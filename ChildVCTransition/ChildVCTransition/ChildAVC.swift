//
//  ChildAVC.swift
//  ChildVCTransition
//
//  Created by 杨晴贺 on 2017/3/30.
//  Copyright © 2017年 Silence. All rights reserved.
//

import UIKit

class ChildAVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let imageView = UIImageView(frame: SRect)
        imageView.image = UIImage(named: "1")
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        // 添加一个点击手势
        let tap = UITapGestureRecognizer(target: self, action: #selector(jump))
        view.addGestureRecognizer(tap)
    }
    
    func jump() {
        //发送跳转通知
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: JumpNotification), object: nil)
    }

}
