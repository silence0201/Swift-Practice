//
//  ViewController.swift
//  ShapeLayerAnimation
//
//  Created by 杨晴贺 on 2017/3/30.
//  Copyright © 2017年 Silence. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let btn1 = UIButton(frame: CGRect(x: 100, y: 200, width: SWidth-200, height: 30))
    let btn2 = UIButton(frame: CGRect(x: 100, y: 300, width: SWidth-200, height: 30))
    
    var drawView = DrawRectView(frame: CGRect(x: 0, y: 64, width: SWidth, height: SHeight-64))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        title = "画图与动画"
        view.backgroundColor = .white
        
        btn1.setTitle("DrawRect", for: .normal)
        btn1.setTitleColor(.orange, for: .normal)
        btn2.setTitle("CAShapeLayer", for: .normal)
        btn2.setTitleColor(.orange, for: .normal)
        
        btn1.addTarget(self, action: #selector(showView), for: .touchUpInside)
        btn2.addTarget(self, action: #selector(showView), for: .touchUpInside)
        
        view.addSubview(btn1)
        view.addSubview(btn2)
    }
    
    func showView(_ sender: UIButton) {
        if sender.currentTitle == "DrawRect" {
            print("采用drawrect画图")
            view.addSubview(drawView)
        }else {
            print("采用cashapelayer")
            navigationController?.pushViewController(ShapeLayerAnimation(), animated: true)
        }
    }


}

