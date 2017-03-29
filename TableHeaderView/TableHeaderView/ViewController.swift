//
//  ViewController.swift
//  TableHeaderView
//
//  Created by 杨晴贺 on 2017/3/29.
//  Copyright © 2017年 Silence. All rights reserved.
//

import UIKit

let HeadViewHeight = SHeight/3.0

class ViewController: UIViewController {

    let datas = ["下","拉","可","以","出","现","很","神","奇","的","事","情","yo","yo","yo","yo","yo","yo"]
    let tableView = UITableView(frame: SRect)
    let resueIdentifer = "CustomCell"
    let headView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: SWidth, height: HeadViewHeight))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        automaticallyAdjustsScrollViewInsets = false ;
        
        headView.backgroundColor = UIColor.white
        headView.contentMode = .scaleAspectFill
        headView.clipsToBounds = true
        
        view.addSubview(headView)
        
        // 加载图片
//        let url = URL(string: "http://c.hiphotos.baidu.com/zhidao/pic/item/5ab5c9ea15ce36d3c704f35538f33a87e950b156.jpg")
//        let task = URLSession.shared.dataTask(with: url!) { (data, _, error) in
//            guard let data = data,error == nil else {return}
//            // 回到主线程
//            DispatchQueue.main.sync {
//                self.headView.image = UIImage(data: data)
//            }
//        }
//        task.resume()
        
        headView.image = UIImage(named:"pp") ;
        
        tableView.delegate  = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: resueIdentifer)
        tableView.showsVerticalScrollIndicator = false
        // 设置Inset
        tableView.contentInset.top = HeadViewHeight
        tableView.scrollIndicatorInsets.top = HeadViewHeight
        view.addSubview(tableView)
        view.sendSubview(toBack: tableView)
    }
}

// MARK: - Delegate
extension ViewController: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: resueIdentifer, for: indexPath)
        cell.textLabel?.text = datas[indexPath.row]
        cell.textLabel?.textAlignment = .center
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // ScrollView Delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y + scrollView.contentInset.top
        if offsetY <= 0 {
            headView.frame = CGRect(x: 0.0, y: 0.0, width: SWidth, height: HeadViewHeight-offsetY)
        }else {
            let height = (HeadViewHeight-offsetY) <= 0.0 ? 0.0 : (HeadViewHeight-offsetY)
            headView.frame = CGRect(x: 0.0, y: 0.0, width: SWidth, height: height)
            headView.alpha = height/HeadViewHeight
        }
    }
}

