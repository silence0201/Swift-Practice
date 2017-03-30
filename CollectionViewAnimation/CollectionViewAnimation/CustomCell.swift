//
//  CustomCell.swift
//  CollectionViewAnimation
//
//  Created by 杨晴贺 on 2017/3/30.
//  Copyright © 2017年 Silence. All rights reserved.
//

import UIKit

let imageRect = CGRect(x: 0, y: 0, width: ItemWidth, height: ItemHeight)
let textRect = CGRect(x: 0, y: ItemHeight-40, width: ItemWidth, height: 40)

class CustomCell: UICollectionViewCell {
    let imageV = UIImageView(frame: imageRect)
    let textV = UITextView(frame: textRect)
    let backBtn = UIButton(frame: CGRect(x: 10,y:10,width:40,height: 40))
    
    // 定义一个无参数，无返回值的闭包属性，用于处理button被点击的情况
    typealias TapBlock = (() -> ())?
    var backButtonTapped: TapBlock
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageV.contentMode = .scaleAspectFit
        imageV.clipsToBounds = true
        textV.font = UIFont.systemFont(ofSize: 14)
        textV.isUserInteractionEnabled = false
        backBtn.setImage(UIImage(named: "Back-icon"), for: .normal)
        backBtn.isHidden = true
        backBtn.addTarget(self, action: #selector(backBtnTouch), for: .touchUpInside)
        backgroundColor = UIColor.gray

        addSubview(imageV)
        addSubview(textV)
        addSubview(backBtn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func handleCellSelected() {
        backBtn.isHidden = false
        superview?.bringSubview(toFront: self)
    }
    
    @objc private func backBtnTouch() {
        backBtn.isHidden = true
        backButtonTapped!()
    }
    
    func prepareCell(model: CellModel) {
        imageV.frame = imageRect
        textV.frame = textRect
        imageV.image = UIImage(named: model.imageName)
        textV.text = model.title
    }
}
