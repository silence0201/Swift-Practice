//
//  CVC.swift
//  TabbarController
//
//  Created by 杨晴贺 on 2017/3/30.
//  Copyright © 2017年 Silence. All rights reserved.
//

import UIKit

class CVC: UIViewController {

    //该imageView可以替换成当前页面的快照，利用快照可以做出界面缩放的效果
    let imageView = UIImageView(frame: SRect)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        imageView.alpha = 0
        imageView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.imageView.alpha = 1
            self.imageView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: nil)
    }

    private func setupView() {
        imageView.alpha = 0
        imageView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        imageView.image = UIImage(named: "Preview1")
        view.addSubview(imageView)
    }

}
