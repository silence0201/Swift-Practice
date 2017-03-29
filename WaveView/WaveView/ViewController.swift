//
//  ViewController.swift
//  WaveView
//
//  Created by 杨晴贺 on 2017/3/29.
//  Copyright © 2017年 Silence. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let wave = WaveView(frame: CGRect(x: 0.0, y: 200.0, width: SWidth, height: 31))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        wave.waveSpeed = 10
        wave.angularSpeed = 1.5
        view.addSubview(wave)
        
        let whiteView = UIView(frame: CGRect(x: 0.0, y: 230, width: SWidth, height: SHeight-230))
        whiteView.backgroundColor = .white
        view.addSubview(whiteView)
        
        let btn = UIButton(frame: CGRect(x: 100, y: 400, width: SWidth-200, height: 30))
        btn.setTitle("开始", for: .normal)
        btn.setTitle("结束", for: .selected)
        btn.setTitleColor(.orange, for: .normal)
        view.addSubview(btn)
        btn.addTarget(self, action: #selector(changeStatus(_:)), for: .touchUpInside)
    }
    
    @objc private func changeStatus(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        sender.isSelected ? wave.startWave() : wave.stopWaver()
    }

}

