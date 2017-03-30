//
//  DrawRectView.swift
//  ShapeLayerAnimation
//
//  Created by 杨晴贺 on 2017/3/30.
//  Copyright © 2017年 Silence. All rights reserved.
//

import UIKit

class DrawRectView: UIView {
    
    var tap: UITapGestureRecognizer?
    
    func removeSelf() {
        self.removeFromSuperview()
    }
    
    override func draw(_ rect: CGRect) {
        if(tap == nil) {
            tap = UITapGestureRecognizer(target: self, action: #selector(removeSelf))
            addGestureRecognizer(tap!)
        }
        
        simpleDraw()
        pathARC()
        pathTriangle()
        pathSecondBezier()
    }
    
    // 圆角矩形
    private func simpleDraw() {
        let path = UIBezierPath(roundedRect: CGRect(x: 20,y: 20,width: 100, height:100), cornerRadius: 20)
        path.lineWidth = 5
        // 填充颜色
        UIColor.green.set()
        path.fill()
        // 线条颜色
        UIColor.red.set()
        path.stroke()
    }
    
    // 圆弧
    private func pathARC() {
        let path = UIBezierPath(arcCenter: CGPoint(x: 20, y: 150), radius: 100, startAngle: 0, endAngle: CGFloat(Double.pi*90/180), clockwise: true)
        // 链接样式
        path.lineCapStyle = .round
        // 链接方式
        path.lineJoinStyle = .round
        path.lineWidth = 5
        
        UIColor.red.set()
        path.stroke()
    }
    
    // 三角形
    private func pathTriangle() {
        let path = UIBezierPath()
        // 起点
        path.move(to: CGPoint(x: 20, y: 300))
        path.addLine(to: CGPoint(x: 150, y: 400))
        path.addLine(to: CGPoint(x: 20, y: 400))
        path.close()
        
        path.lineWidth = 5
        
        UIColor.green.set()
        path.fill()
        
        UIColor.red.set()
        path.stroke()
    }
    
    // 贝塞尔曲线
    private func pathSecondBezier() {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 200, y: 150))
        path.addQuadCurve(to: CGPoint(x: 200, y: 300), controlPoint: CGPoint(x: 50, y: 50))
        path.lineWidth = 5
        
        UIColor.red.set()
        path.stroke()
    }
    
    
    
}
