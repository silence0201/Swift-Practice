//
//  ViewController.swift
//  WelcomView
//
//  Created by 杨晴贺 on 2017/3/29.
//  Copyright © 2017年 Silence. All rights reserved.
//

import UIKit

let ScreenRect = UIScreen.main.bounds
let ScreenHeight = ScreenRect.height
let ScreenWidth = ScreenRect.width

class ViewController: UIViewController, UIScrollViewDelegate {

    let scrollBG = UIScrollView(frame: ScreenRect)
    let images = ["1","2","3"]
    let pageControl = UIPageControl(frame: CGRect(x: 0, y: ScreenHeight - 30, width: ScreenWidth, height: 20))
    var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    private func setupView() {
        // 遍历数组,同时获取index
        for (index, value) in images.enumerated() {
            let rect = CGRect(x: ScreenWidth*CGFloat(index), y: 0, width: ScreenWidth, height: ScreenHeight)
            let imageView = UIImageView(frame: rect)
            imageView.image = UIImage(named: value)
            // 限制边界
            imageView.clipsToBounds = true
            imageView.contentMode = .scaleAspectFill
            scrollBG.addSubview(imageView)
        }
        
        scrollBG.delegate = self
        scrollBG.isPagingEnabled = true
        scrollBG.contentSize = CGSize(width: ScreenWidth * CGFloat(images.count), height: ScreenHeight)
        
        pageControl.currentPage = currentPage
        pageControl.numberOfPages = images.count
        pageControl.isEnabled = false
        pageControl.pageIndicatorTintColor = UIColor.white
        pageControl.currentPageIndicatorTintColor = UIColor.gray
        
        view.addSubview(scrollBG)
        view.addSubview(pageControl)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let number = Int(round(scrollBG.contentOffset.x / ScreenWidth))
        if number >= 0 && number <= 2 && number != currentPage {
            currentPage = number
            pageControl.currentPage = currentPage
        }
    }


}

