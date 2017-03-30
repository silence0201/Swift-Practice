//
//  ViewController.swift
//  MosaicLayout
//
//  Created by 杨晴贺 on 2017/3/30.
//  Copyright © 2017年 Silence. All rights reserved.
//

import UIKit
import FMMosaicLayout

let SNoNavRect = CGRect(x: 0, y: 0, width: SWidth, height: SHeight - 64)
let SNoTarRect = CGRect(x: 0, y: 0, width: SWidth, height: SHeight - 49)
let SNoNavTarRect = CGRect(x: 0, y: 0, width: SWidth, height: SHeight - 49 - 64)
let SStatusBarFrame = UIApplication.shared.statusBarFrame

class ViewController: UIViewController {

    var collectionView: UICollectionView!
    var images = ["back","birds","sunset","waves"]
    let reuseIdentifier = String(describing: CustomCollectionCell.self)
    let reuseHeaderIdentifier = String(describing: CustomHeaderView.self)
    let HeaderFooterHeight: CGFloat = 44
    let ColumnCount = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        let collectionLayout = FMMosaicLayout()
        collectionView = UICollectionView(frame: SRect, collectionViewLayout: collectionLayout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CustomCollectionCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.register(CustomHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: reuseHeaderIdentifier)
        collectionView.register(CustomHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: reuseHeaderIdentifier)
        view.addSubview(collectionView)
    }

}

extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 22
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CustomCollectionCell
        cell.imageView.image = UIImage(named: images[indexPath.row%4])
        cell.title.text = "第\(indexPath.row+1)个"
        return cell
    }
    
    // 设置分区头和weight
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let viewHF = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reuseHeaderIdentifier, for: indexPath) as! CustomHeaderView
        viewHF.title.text = kind == UICollectionElementKindSectionHeader ? "SECTION \(indexPath.section+1)" : "OVER SECTION \(indexPath.section+1)"
        return viewHF
    }
}

extension ViewController: FMMosaicLayoutDelegate {
    // 列
    func collectionView(_ collectionView: UICollectionView!, layout collectionViewLayout: FMMosaicLayout!, numberOfColumnsInSection section: Int) -> Int {
        return ColumnCount
    }
    
    // item的大小
    func collectionView(_ collectionView: UICollectionView!, layout collectionViewLayout: FMMosaicLayout!, mosaicCellSizeForItemAt indexPath: IndexPath!) -> FMMosaicCellSize {
        return (indexPath.item % 12 == 0) ? FMMosaicCellSize.big : FMMosaicCellSize.small
    }
    
    // 分区内边距
    func collectionView(_ collectionView: UICollectionView!, layout collectionViewLayout: FMMosaicLayout!, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    // 分区间距
    func collectionView(_ collectionView: UICollectionView!, layout collectionViewLayout: FMMosaicLayout!, interitemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    // 头高
    func collectionView(_ collectionView: UICollectionView!, layout collectionViewLayout: FMMosaicLayout!, heightForHeaderInSection section: Int) -> CGFloat {
        return HeaderFooterHeight
    }
    
    // 尾高
    func collectionView(_ collectionView: UICollectionView!, layout collectionViewLayout: FMMosaicLayout!, heightForFooterInSection section: Int) -> CGFloat {
        return HeaderFooterHeight
    }
    
    // 控制分区头尾是否在collectionview之上
    func headerShouldOverlayContent(in collectionView: UICollectionView!, layout collectionViewLayout: FMMosaicLayout!) -> Bool {
        return true
    }
    
    func footerShouldOverlayContent(in collectionView: UICollectionView!, layout collectionViewLayout: FMMosaicLayout!) -> Bool {
        return true
    }
}
