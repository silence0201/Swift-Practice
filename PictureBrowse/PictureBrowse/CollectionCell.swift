//
//  CollectionCell.swift
//  PictureBrowse
//
//  Created by 杨晴贺 on 2017/3/29.
//  Copyright © 2017年 Silence. All rights reserved.
//

import UIKit

class CollectionCell: UICollectionViewCell {
    
    let featureImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: ItemWidth, height: ItemHeight))
    let interestTitleLabel = UILabel(frame: CGRect(x: 0, y: ItemHeight - 50, width: ItemWidth, height: 20))
    let interestDetailLabel = UILabel(frame: CGRect(x: 0, y: ItemHeight - 30, width: ItemWidth, height: 30))
    
    var data: CollectionModel? {
        didSet {
            updateUI()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        interestTitleLabel.backgroundColor = UIColor.gray
        interestTitleLabel.textColor = UIColor.white
        interestTitleLabel.textAlignment = .center
        interestTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: 4)
        
        interestDetailLabel.backgroundColor =  UIColor.gray
        interestDetailLabel.textColor = UIColor.white
        interestDetailLabel.textAlignment = .center
        interestDetailLabel.numberOfLines = 0
        interestDetailLabel.font = UIFont.systemFont(ofSize: 10)
        
        contentView.addSubview(featureImageView)
        contentView.addSubview(interestTitleLabel)
        contentView.addSubview(interestDetailLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateUI() {
        featureImageView.image = data?.featuredImage
        interestDetailLabel.text = data?.title
        interestTitleLabel.text = data?.descriptions
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 5
        featureImageView.clipsToBounds = true
    }
}
