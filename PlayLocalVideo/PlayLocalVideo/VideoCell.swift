//
//  VideoCell.swift
//  PlayLocalVideo
//
//  Created by 杨晴贺 on 2017/3/29.
//  Copyright © 2017年 Silence. All rights reserved.
//

import UIKit

struct VideoModel {
    let image: String
    let title: String
    let source: String
}

class VideoCell: UITableViewCell {
    let videoImage = UIImageView(frame: CGRect(x: 0, y: 0, width: ScreenRect.width, height: ScreenRect.height / 3 ))
    let videoTitle = UILabel(frame: CGRect(x: 0, y: ScreenRect.height/3-50, width: ScreenRect.height, height: 30))
    let videoSource = UILabel(frame: CGRect(x: 0, y: ScreenRect.height/3-20, width: ScreenRect.width, height: 20))
    
    private let videoPlay = UIImageView(frame: CGRect(x: 0, y: 0, width: ScreenRect.width, height: ScreenRect.height/3))
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        videoImage.contentMode = .scaleAspectFill
        videoPlay.contentMode = .center
        videoPlay.image = UIImage(named: "playBtn")
        videoTitle.textColor = UIColor.white
        videoTitle.font = UIFont(name: "Zapfino", size: 24)
        videoTitle.textAlignment = .center
        videoSource.textColor = UIColor.gray
        videoSource.font = UIFont(name: "Avenir Next", size: 14)
        videoSource.textAlignment = .center
        
        contentView.addSubview(videoImage)
        contentView.addSubview(videoPlay)
        contentView.addSubview(videoTitle)
        contentView.addSubview(videoSource)
    }
    
    func setModel(model: VideoModel) {
        videoImage.image = UIImage(named: model.image)
        videoTitle.text = model.title
        videoSource.text = model.source
    }
}
