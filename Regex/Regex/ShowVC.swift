//
//  ShowVC.swift
//  Regex
//
//  Created by 杨晴贺 on 2017/3/30.
//  Copyright © 2017年 Silence. All rights reserved.
//

import UIKit

class ShowVC: UIViewController {

    let textView = UITextView(frame: SRect)
    var province: Province!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func setupView() {
        
        title = province.name
        var str = "省会名称：\(province.name)\n拥有\(province.citys.count)个市\n"
        for city in province.citys {
            str = "\(str)\n市名：\(city.name)\n别名：\(city.alias)\n"
        }
        
        textView.text = str
        textView.font = UIFont.systemFont(ofSize: 20, weight: 5)
        textView.textColor = .orange
        textView.isEditable = false
        view.addSubview(textView)
    }


}
