//
//  CustomHeaderView.swift
//  MosaicLayout
//
//  Created by 杨晴贺 on 2017/3/30.
//  Copyright © 2017年 Silence. All rights reserved.
//

import UIKit

class CustomHeaderView: UICollectionReusableView {
    
    let title = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        title.frame = bounds
        title.font = UIFont.systemFont(ofSize: 20)
        title.textColor = UIColor.orange
        title.textAlignment = .center
        addSubview(title)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
