//
//  ViewController.swift
//  ColorProgress
//
//  Created by 杨晴贺 on 2017/3/29.
//  Copyright © 2017年 Silence. All rights reserved.
//

import UIKit

let ProgressRect = CGRect(x: 20, y: 200, width: SWidth-40, height: 20)
class ViewController: UIViewController {

    let colorProgress = ColorProgress(frame: ProgressRect)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (time) in
            self.colorProgress.progress += 0.08
            if self.colorProgress.progress >= 1.0 {
                time.invalidate()
            }
        }
    }
    
    func setupView() {
        view.backgroundColor = .black
        view.addSubview(colorProgress)
    }


}

