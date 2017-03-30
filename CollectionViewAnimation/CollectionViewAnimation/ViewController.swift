//
//  ViewController.swift
//  CollectionViewAnimation
//
//  Created by 杨晴贺 on 2017/3/30.
//  Copyright © 2017年 Silence. All rights reserved.
//

import UIKit

let ItemHeight = SHeight/3-20
let ItemWidth = SWidth-20

//数据结构体
struct CellModel {
    let imageName: String
    let title: String
    
    init(imageName: String?, title: String?) {
        self.imageName = imageName ?? ""
        self.title = title ?? "没有title"
    }
    
    static func getData() -> [CellModel]? {
        let txt = "Hedge fund billionaire Bill Ackman was humbled in 2015. His Pershing Square Capital Management had a terrible year, posting a -19.3% gross return."
        let iamgeNames = ["1","2","3","4","5"]
        let titles = Array(repeating: txt, count: 5)
        var result = [CellModel]()
        for (index,name) in iamgeNames.enumerated() {
            result.append(CellModel(imageName: name, title: titles[index]))
        }
        return result
    }
}


class ViewController: UIViewController {

    var collectionView: UICollectionView!
    var datas = CellModel.getData()
    
    let reuseIdentifier = String(describing: CustomCell.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .vertical//滚动方向
        collectionLayout.itemSize = CGSize(width: ItemWidth, height: ItemHeight)//cell大小
        collectionLayout.minimumLineSpacing = 10//上下间隔
        collectionLayout.minimumInteritemSpacing = 10//左右间隔
        collectionLayout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)//section边界
        collectionView = UICollectionView(frame: SRect, collectionViewLayout: collectionLayout)
        collectionView.backgroundColor = .orange
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        view.addSubview(collectionView)
    }


}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (datas?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CustomCell
        cell.prepareCell(model: (datas?[indexPath.row])!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if !collectionView.isScrollEnabled {
            return
        }
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? CustomCell else {
            return
        }
        collectionView.isScrollEnabled = false
        cell.handleCellSelected()
        cell.backButtonTapped = {
            print("闭包执行")
            collectionView.isScrollEnabled = true
            collectionView.reloadItems(at: [indexPath])
        }
        UIView.animate(withDuration: 1,
                       delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 1,
                       options: [],
                       animations: {
                        cell.frame = CGRect(x: 10, y: self.collectionView.contentOffset.y, width: SWidth-20, height: SHeight)
                        cell.imageV.frame = cell.bounds
                        cell.textV.frame = CGRect(x: 0, y: SHeight-60, width: SWidth-20, height: 60)
        }) { (finish) in
            print("动画结束")
        }
    }
}

