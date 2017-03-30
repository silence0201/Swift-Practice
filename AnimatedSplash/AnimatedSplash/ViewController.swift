//
//  ViewController.swift
//  AnimatedSplash
//
//  Created by 杨晴贺 on 2017/3/30.
//  Copyright © 2017年 Silence. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageView = UIImageView(frame: SRect)
        imageView.image = UIImage(named: "screen")
        
        view.addSubview(imageView)
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

}

