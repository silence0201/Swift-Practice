//
//  ViewController.swift
//  QRCode
//
//  Created by 杨晴贺 on 2017/3/30.
//  Copyright © 2017年 Silence. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setupView() {
        title = "选择方式"
        view.backgroundColor = .white
        for (index, title) in ["扫描二维码","图片获取"].enumerated() {
            createButton(rect: CGRect(x: 100, y: 100+100*index, width: Int(SWidth)-200, height: 40), title: title)
        }
    }
    
    func createButton(rect: CGRect, title: String) {
        
        let btn = UIButton(frame: rect)
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(.orange, for: .normal)
        btn.addTarget(self, action: #selector(btnSeletecd(sender:)), for: .touchUpInside)
        view.addSubview(btn)
    }
    
    
    func btnSeletecd(sender: UIButton) {
        
        switch sender.currentTitle! {
        case "扫描二维码":
            navigationController?.pushViewController(ScanVC(), animated: true)
        default:
            navigationController?.pushViewController(ImageVC(), animated: true)
        }
    }


}

