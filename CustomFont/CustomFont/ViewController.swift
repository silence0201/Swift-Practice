//
//  ViewController.swift
//  CustomFont
//
//  Created by 杨晴贺 on 2017/3/29.
//  Copyright © 2017年 Silence. All rights reserved.
//

import UIKit

/*
 导入字体步骤：
 1.下载ttf文件，加入项目中
 2.在info.plist中，添加一个字段：Fonts provided by application
 3.再添加item，值写入字体的名字
 4.然后就可以通过名字使用了
 */

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight*2/3), style: .plain)
    let button = UIButton(frame: CGRect(x: 0, y: ScreenHeight*2/3, width: ScreenWidth, height: ScreenHeight / 3))
    let data = ["点击一下改变字体","字体就会改变","你相信不","不相信么","点一下试试"]
    let fontNames = ["MFTongXin_Noncommercial-Regular", "MFJinHei_Noncommercial-Regular", "MFZhiHei_Noncommercial-Regular", "Heiti SC"]
    
    var fontNumber = 0 ;
    let reuseIdentifier = "FontCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.black
        
        button.setTitle("改变字体", for: .normal)
        button.backgroundColor = UIColor.orange
        button.addTarget(self, action: #selector(changFont), for: .touchUpInside)
        
        view.addSubview(tableView)
        view.addSubview(button)
    }
    
    
    @objc private func changFont() {
        fontNumber = (fontNumber + 1) % fontNames.count
        tableView.reloadData()
    }
    
    // MARK: - delegate and dataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ScreenHeight*2/3/CGFloat(data.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //??空合运算符，a ?? b，对可选类型a进行判断，为nil默认值为b，不为空就解封
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) ?? UITableViewCell(style: .subtitle, reuseIdentifier: reuseIdentifier)
        let text = data[indexPath.row]
        
        cell.textLabel?.text = text
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.font = UIFont(name: fontNames[fontNumber], size: 24)
        cell.backgroundColor = UIColor.black
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 取消点击效果
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath)
        // 链式调用，最后得到一个可选的string,！强制解包出来
        let str = "当前字体是: "+(cell?.textLabel?.font.fontName)!
        print(str)
    }
    
    // MARK: - 操作
    //设置状态栏样式
    /*设置状态栏：
     @available(iOS 7.0, *)
     open var preferredStatusBarStyle: UIStatusBarStyle { get }//样式
     
     @available(iOS 7.0, *)
     open var prefersStatusBarHidden: Bool { get }//是否隐藏
     */
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }


}

