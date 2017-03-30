//
//  ViewController.swift
//  CustomCollectionLayout
//
//  Created by 杨晴贺 on 2017/3/30.
//  Copyright © 2017年 Silence. All rights reserved.
//

import UIKit

let SNoNavRect = CGRect(x: 0, y: 0, width: SWidth, height: SHeight - 64)
let SNoTarRect = CGRect(x: 0, y: 0, width: SWidth, height: SHeight - 49)
let SNoNavTarRect = CGRect(x: 0, y: 0, width: SWidth, height: SHeight - 49 - 64)

class ViewController: UIViewController {

    let tableView = UITableView(frame: SNoNavRect, style:.plain)
    let reuseIdentifer = String(describing: UITableViewCell.self)
    let datas = ["瀑布流","圆形","线性"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        title = "选择布局"
        edgesForExtendedLayout = []
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifer)
        view.addSubview(tableView)
    }
}

extension ViewController: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
         return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifer, for: indexPath)
        cell.textLabel?.text = datas[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20, weight: 5)
        cell.textLabel?.textColor = .orange
        cell.textLabel?.textAlignment = .center
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let show = ShowViewController()
        show.title = datas[indexPath.row]
        switch datas[indexPath.row] {
        case "瀑布流":
            show.style = "waterfall"
        case "圆形":
            show.style = "circle"
        default:
            show.style = "line"
        }
        navigationController?.pushViewController(show, animated: true)

    }
}

