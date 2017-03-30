//
//  MenuViewController.swift
//  TumblrMenu
//
//  Created by 杨晴贺 on 2017/3/30.
//  Copyright © 2017年 Silence. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    var btns = [UIButton]()
    let transitionManager = MenuTransitionManger()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        transitioningDelegate = transitionManager
        view.backgroundColor = UIColor(white: 1, alpha: 0.5)
        let width: CGFloat = SWidth/2
        let height: CGFloat = SHeight/3
        let names = ["Audio","Chat","Link","Photo","Quote","Text"]
        for index in 0...5 {
            let rect = CGRect(x: width*CGFloat(index%2), y: height*CGFloat(index/2), width: width, height: height)
            let btn = UIButton(frame: rect)
            btn.setTitle(names[index], for: .normal)
            btn.setTitleColor(.white, for: .normal)
            btn.setImage(UIImage(named: names[index]), for: .normal)
            view.addSubview(btn)
            btn.alignContentVerticallyByCenter()
            btn.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
            btns.append(btn)
        }

    }
    
    func dismissView() {
        dismiss(animated: true, completion: nil)
    }

}

extension UIButton {
    //设置按钮图片在上，文字在下的效果
    func alignContentVerticallyByCenter() {
        contentHorizontalAlignment = .center
        contentVerticalAlignment = .center
        
        //图片与title之间有一个默认的间隔10
        let offset: CGFloat = 10
        
        //在有的iOS版本上，会出现获得不到frame的情况，加上下面这两句可以100%得到
        titleLabel?.backgroundColor = backgroundColor
        imageView?.backgroundColor = backgroundColor
        
        //title
        let titleWidth = titleLabel?.frame.size.width
        let titleHeight = titleLabel?.frame.size.height
        let titleLef = titleLabel?.frame.origin.x
        let titleRig = frame.size.width-titleLef!-titleWidth!
        
        //image
        let imageWidth = imageView?.frame.size.width
        let imageHeight = imageView?.frame.size.height
        let imageLef = imageView?.frame.origin.x
        let imageRig = frame.size.width-imageLef!-imageWidth!
        
        imageEdgeInsets = UIEdgeInsets(top: 0, left: -imageLef!, bottom: titleHeight!, right: -imageRig)
        titleEdgeInsets = UIEdgeInsets(top: imageHeight!+offset, left: -titleLef!, bottom: 0, right: -titleRig)
    }
}
