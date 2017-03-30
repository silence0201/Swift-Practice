//
//  ViewController.swift
//  TumblrMenu
//
//  Created by 杨晴贺 on 2017/3/30.
//  Copyright © 2017年 Silence. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        let imageView = UIImageView(frame: SRect)
        imageView.contentMode = .scaleAspectFill
        imageView.image = #imageLiteral(resourceName: "bg")
        view.addSubview(imageView)
        
        let visualView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        visualView.frame = SRect
        view.addSubview(visualView)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        present(MenuViewController(), animated: true, completion: nil)
    }

}

