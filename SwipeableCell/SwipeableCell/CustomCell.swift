//
//  CustomCell.swift
//  SwipeableCell
//
//  Created by 杨晴贺 on 2017/3/30.
//  Copyright © 2017年 Silence. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    func prepareForCell(model: CellModel) {
        imageView?.image = UIImage(named: model.imageName)
        textLabel?.text = model.title
        textLabel?.textAlignment = .center
    }
}


