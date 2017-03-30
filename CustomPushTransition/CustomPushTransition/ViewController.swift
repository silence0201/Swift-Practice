//
//  ViewController.swift
//  CustomPushTransition
//
//  Created by 杨晴贺 on 2017/3/30.
//  Copyright © 2017年 Silence. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageView = UIImageView(frame: SRect)
        imageView.image = UIImage(named: "1")
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        
        // 隐藏导航栏
        navigationController?.navigationBar.isHidden = true
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.delegate = self
    }
    
    //VC继承自UIResponder，所以会有该方法
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        navigationController?.pushViewController(PushVC(), animated: true)
    }
}

extension ViewController: UINavigationControllerDelegate {
    // 返回转场动画
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            return PushAnimation()
        }
        return nil
    }
}

