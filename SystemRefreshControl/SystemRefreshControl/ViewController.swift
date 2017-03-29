//
//  ViewController.swift
//  SystemRefreshControl
//
//  Created by 杨晴贺 on 2017/3/29.
//  Copyright © 2017年 Silence. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let tableView = UITableView(frame: SRect, style: .plain)
    let refreshControl = UIRefreshControl()
    
    var contents = ["下下下下下","拉拉拉拉拉","刷刷刷刷刷","新新新新新","哟哟哟哟哟"]
    let news = ["1111","2222","3333","4444","5555","6666"]
    let cellIdentifier = "RefreshCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.refreshControl = refreshControl
        refreshControl.backgroundColor = UIColor.gray
        refreshControl.attributedTitle = NSAttributedString(string: "最后一次更新：\(NSDate())", attributes: [NSForegroundColorAttributeName: UIColor.white])
        refreshControl.tintColor = UIColor.orange  // 菊花的颜色
        refreshControl.addTarget(self, action: #selector(addContent), for: .valueChanged)
        view.addSubview(tableView)
    }
    
    @objc private func addContent() {
        contents.append(contentsOf: news)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) { 
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }


}

extension ViewController: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) ?? UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        cell.textLabel?.text = String(indexPath.row+1) + ":" + contents[indexPath.row]
        cell.textLabel?.textColor = UIColor.black
        cell.textLabel?.backgroundColor = UIColor.clear
        cell.textLabel?.font = UIFont.systemFont(ofSize: 17)
        
        return cell
    }
    
    //MARK: - Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

