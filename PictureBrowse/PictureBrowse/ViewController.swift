//
//  ViewController.swift
//  PictureBrowse
//
//  Created by 杨晴贺 on 2017/3/29.
//  Copyright © 2017年 Silence. All rights reserved.
//

import UIKit

let ScreenRect = UIScreen.main.bounds
let ScreenHeight = ScreenRect.height
let ScreenWidth = ScreenRect.width

let ItemWidth = ScreenWidth - 40
let ItemHeight = ScreenHeight/3.0

class ViewController: UIViewController {

    let backgroudImageView = UIImageView(frame: ScreenRect)
    let data = CollectionModel.createInterests()
    let reuseIdentifier = "CollectionCell"
    let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style:.light))
    
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        backgroudImageView.image = UIImage(named: "blue")
        
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .horizontal // 滚动方向
        collectionLayout.itemSize = CGSize(width: ItemWidth, height: ItemHeight) // Cell大小
        collectionLayout.minimumLineSpacing = 20 // 上下间隔
        collectionLayout.minimumInteritemSpacing = 20 // 左右间距
        collectionLayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: (ScreenHeight - ItemHeight)/2, width: ScreenWidth, height: ItemHeight),collectionViewLayout:collectionLayout)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CollectionCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        visualEffectView.frame = ScreenRect
        
        view.addSubview(backgroudImageView)
        view.addSubview(visualEffectView)
        view.addSubview(collectionView)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }


}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionCell
        cell.data = self.data[indexPath.row]
        return cell
    }
}
