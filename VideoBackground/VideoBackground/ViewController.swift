//
//  ViewController.swift
//  VideoBackground
//
//  Created by 杨晴贺 on 2017/3/29.
//  Copyright © 2017年 Silence. All rights reserved.
//

import UIKit
import AVKit
import MediaPlayer

let loginBtnRect = CGRect(x: 30, y: SHeight-150, width: SWidth-60, height: 50)
let regisBtnRect = CGRect(x: 30, y: SHeight-75, width: SWidth-60, height: 50)

class ViewController: UIViewController {

    let playVC = AVPlayerViewController()
    let loginBtn = UIButton(frame: loginBtnRect)
    let regisBtn = UIButton(frame: regisBtnRect)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupMoviePlayer()
    }

    private func setupView() {
        view.backgroundColor = UIColor.white
        loginBtn.customBtn(customTitle: "登陆")
        regisBtn.customBtn(customTitle: "注册")
        
        loginBtn.addTarget(self, action: #selector(buttonTap(_:)), for: .touchUpInside)
        regisBtn.addTarget(self, action: #selector(buttonTap(_:)), for: .touchUpInside)
        
        view.addSubview(loginBtn)
        view.addSubview(regisBtn)
    }
    
    private func setupMoviePlayer() {
        let url = URL(fileURLWithPath: (Bundle.main.path(forResource: "moments", ofType: "mp4"))!)
        playVC.player = AVPlayer(url: url)   // 指定播放源
        playVC.showsPlaybackControls = false // 是否显示工具栏
        playVC.videoGravity = AVLayerVideoGravityResizeAspectFill // 视频画面适应方式
        playVC.view.frame = SRect
        playVC.view.alpha = 0
        // 监听视频播放完的状态
        NotificationCenter.default.addObserver(self, selector: #selector(repeatPlay), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playVC.player?.currentItem)
        view.addSubview(playVC.view)
        view.sendSubview(toBack: playVC.view) // 设置到最底部
        UIView.animate(withDuration: 1) { 
            self.playVC.view.alpha = 1
            self.playVC.player?.play()
        }
    }
    
    @objc private func repeatPlay() {
        playVC.player?.seek(to: kCMTimeZero)
        playVC.player?.play()
    }
    
    @objc private func buttonTap(_ btn: UIButton) {
        print("点击的按钮"+btn.currentTitle!)
    }

}


extension UIButton {
    func customBtn(customTitle title: String) {
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        layer.cornerRadius = 5.0
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1.0
    }
}

