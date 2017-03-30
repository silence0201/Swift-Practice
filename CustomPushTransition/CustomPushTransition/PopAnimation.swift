//
//  PopAnimation.swift
//  CustomPushTransition
//
//  Created by 杨晴贺 on 2017/3/30.
//  Copyright © 2017年 Silence. All rights reserved.
//

import UIKit

class PopAnimation: NSObject,UIViewControllerAnimatedTransitioning {
    var transitionContext: UIViewControllerContextTransitioning?
    
    //转场时间
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2
    }
    
    //转场动画
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        //该参数包含了控制转场动画必要的信息
        self.transitionContext = transitionContext
        //目标VC
        let toVC = transitionContext.viewController(forKey: .to)
        //当前VC
        let fromVC = transitionContext.viewController(forKey: .from)
        //容器View，转场动画都是在该容器中进行的，导航控制的wrapper view就是改容器
        let containerView = transitionContext.containerView
        containerView.addSubview((toVC?.view)!)
        containerView.addSubview((fromVC?.view)!)
        
        let starPath = UIBezierPath(rect: CGRect(x: 0, y: SHeight*0.5-2, width: SWidth, height: 4))
        let finalPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: SWidth, height: SHeight))
        let maskLayer = CAShapeLayer()
        maskLayer.path = finalPath.cgPath
        fromVC?.view.layer.mask = maskLayer
        
        let animation = CABasicAnimation(keyPath: "path")
        animation.fromValue = finalPath.cgPath
        animation.toValue = starPath.cgPath
        animation.duration = transitionDuration(using: transitionContext)
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.delegate = self
        maskLayer.add(animation, forKey: "path")
    }

}

extension PopAnimation: CAAnimationDelegate {
    //动画结束
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        //通知transition完成,该方法一定要调用
        transitionContext?.completeTransition(!(transitionContext?.transitionWasCancelled)!)
        //清除fromVC的mask
        transitionContext?.viewController(forKey: .from)?.view.layer.mask = nil
        transitionContext?.viewController(forKey: .to)?.view.layer.mask = nil
    }
}
