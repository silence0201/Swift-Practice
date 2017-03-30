//
//  ViewController.swift
//  SwipeableCell
//
//  Created by 杨晴贺 on 2017/3/30.
//  Copyright © 2017年 Silence. All rights reserved.
//

import UIKit

struct CellModel {
    let imageName: String
    var title: String
    
    static func createModel() -> [CellModel] {
        var datas = [CellModel]()
        for index in 0...20 {
            datas.append(CellModel(imageName: String(index%3+1), title: "第\(index+1)行"))
        }
        return datas
    }
}

class ViewController: UIViewController {

    var datas = [CellModel]()
    let tableView = UITableView(frame: SRect, style: .plain)
    let reuseIdentifer = String(describing: CustomCell.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        datas = CellModel.createModel()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomCell.self, forCellReuseIdentifier: reuseIdentifer)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifer, for: indexPath) as! CustomCell
        cell.prepareForCell(model: datas[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .normal, title: "删除") { (action, index) in
            print("删除")
            let alert = UIAlertController(title: "是否删除?", message: "删除了就没有了哟！", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "取消", style: .cancel, handler: { (action) in
                tableView.reloadRows(at: [indexPath], with: .fade)
            })
            let delete = UIAlertAction(title: "确定", style: .destructive, handler: { (action) in
                self.datas.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            })
            alert.addAction(cancel)
            alert.addAction(delete)
            self.present(alert, animated: true, completion: nil)
        }
        delete.backgroundColor = UIColor.red
        
        let edit = UITableViewRowAction(style: .normal, title: "编辑") { (action, index) in
            let alert = UIAlertController(title: "修改名称", message: "随便改！", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "取消", style: .cancel, handler: { (action) in
                tableView.reloadRows(at: [indexPath], with: .fade)
            })
            let delete = UIAlertAction(title: "确定", style: .destructive, handler: { (action) in
                self.datas[indexPath.row].title = (alert.textFields?.first?.text)!
                tableView.reloadRows(at: [indexPath], with: .fade)
            })
            alert.addTextField(configurationHandler: { (textField) in
                textField.placeholder = "输入新的名称！"
                textField.text = self.datas[indexPath.row].title
                textField.clearButtonMode = .whileEditing
            })
            alert.addAction(cancel)
            alert.addAction(delete)
            self.present(alert, animated: true, completion: nil)
        }
        edit.backgroundColor = .blue
        
        let share = UITableViewRowAction(style: .normal, title: "分享") { (action, index) in
            print("分享")
            let firstItem = self.datas[indexPath.row]
            let activityVC = UIActivityViewController(activityItems: [firstItem.title], applicationActivities: nil)
            self.present(activityVC, animated: true, completion: {
                tableView.reloadRows(at: [indexPath], with: .fade)
            })
        }
        share.backgroundColor = .orange
        
        return [delete,share,edit]
    }
}

