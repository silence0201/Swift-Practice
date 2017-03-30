//
//  AnimationViewController.swift
//  BasicAnimation
//
//  Created by 杨晴贺 on 2017/3/30.
//  Copyright © 2017年 Silence. All rights reserved.
//

import UIKit

class AnimationViewController: UIViewController {

    var animationStyle: String!
    let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        imageView.center = view.center
        imageView.backgroundColor = .orange
        view.backgroundColor = .white
        view.addSubview(imageView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animationBegin()
    }
    
    func animationBegin() {
        switch animationStyle {
        case "Position":
            positionAnimation()
        case "Opacity":
            opacityAnimation()
        case "Color":
            colorAnimation()
        case "Scale":
            scaleAnimation()
        default:
            rotationAnimation()
        }
    }
    
    private func positionAnimation() {
        UIView.animate(withDuration: 0.3, animations: {
            self.imageView.center = CGPoint(x: 50, y: 50)
        }) { (_) in
            UIView.animate(withDuration: 0.3, animations: {
                self.imageView.center = CGPoint(x: 50, y: SHeight-50)
            }, completion: { (_) in
                UIView.animate(withDuration: 0.3, animations: {
                    self.imageView.center = CGPoint(x: SWidth-50, y: SHeight-50)
                }, completion: { (_) in
                    UIView.animate(withDuration: 0.3, animations: {
                        self.imageView.center = CGPoint(x: SWidth-50, y: 50)
                    }, completion: { (_) in
                        UIView.animate(withDuration: 0.3, animations: {
                            self.imageView.center = self.view.center
                        }, completion: nil)
                    })
                })
            })
        }
    }
    
    private func opacityAnimation() {
        UIView.animate(withDuration: 0.5) {
            self.imageView.alpha = 0
        }
    }
    
    private func colorAnimation() {
        UIView.animate(withDuration: 0.5) {
            self.imageView.backgroundColor = .red
        }
    }
    
    private func scaleAnimation() {
        UIView.animate(withDuration: 0.5) {
            //这是在最初的基础上进行变化
            self.imageView.transform = CGAffineTransform(scaleX: 2, y: 2)
        }
    }
    
    private func rotationAnimation() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
            //这是基于现在的基础进行变化
            self.imageView.transform = self.imageView.transform.rotated(by: CGFloat(Double.pi))
        }) { [weak self](_) in//由于这里会造成循环引用，导致VC得不到释放的问题，所以，需要在block使self成为弱引用
            if let strongSelf = self {
                strongSelf.rotationAnimation()
            }
        }

    }
    
    deinit {
        print("VC销毁了")
    }
}
