//
//  ViewController.swift
//  PlayLocalVideo
//
//  Created by 杨晴贺 on 2017/3/29.
//  Copyright © 2017年 Silence. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let reuseIdentifer = "VideoCell"
    
    let tableView = UITableView(frame: ScreenRect, style: .plain)
    
    var playViewController: AVPlayerViewController?
    var playView: AVPlayer?
    
    let datas = [
        VideoModel(image: "videoScreenshot01", title: "Introduce 3DS Mario", source: "Youtube - 06:32"),
        VideoModel(image: "videoScreenshot02", title: "Emoji Among Us", source: "Vimeo - 3:34"),
        VideoModel(image: "videoScreenshot03", title: "Seals Documentary", source: "Vine - 00:06"),
        VideoModel(image: "videoScreenshot04", title: "Adventure Time", source: "Youtube - 02:39"),
        VideoModel(image: "videoScreenshot05", title: "Facebook HQ", source: "Facebook - 10:20"),
        VideoModel(image: "videoScreenshot06", title: "Lijiang Lugu Lake", source: "Allen - 20:30")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(VideoCell.self, forCellReuseIdentifier: reuseIdentifer)
        view.addSubview(tableView)
    }
    
    private func playVideos() {
        let path = Bundle.main.path(forResource: "emoji zone", ofType: "mp4")
        guard let p = path else {
            print("没有该文件!")
            return
        }
        // 经过上面可以判断Path肯定有值
        
        playView = AVPlayer(url: URL(fileURLWithPath: p))
        playViewController = AVPlayerViewController()
        playViewController?.player = playView
        self.present(playViewController!, animated: true) { 
            self.playView?.play()
        }
    }
    
    // MARK: - Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ScreenRect.height / 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /*
         !强制解析值，解析前一定确保可选是有值的
         
         类型转换：
         as?:返回一个向下转型的类型的可选值
         as!:强制转型，并且解包
         is:检查能够向下转化成指定类型
         as:向上转换成超类
         当不确定是否可以转成功时，用as?，确定时，用as!
         */
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifer, for: indexPath) as! VideoCell
        cell.setModel(model: datas[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        playVideos()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }


}

