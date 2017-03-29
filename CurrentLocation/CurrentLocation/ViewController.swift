//
//  ViewController.swift
//  CurrentLocation
//
//  Created by 杨晴贺 on 2017/3/29.
//  Copyright © 2017年 Silence. All rights reserved.
//

import UIKit
import CoreLocation

let buttonRect = CGRect(x: 30, y: ScreenHeight-100, width: ScreenWidth-60, height: 80)
let labelRect = CGRect(x: 10, y: 60, width: ScreenWidth-20, height: 20)

class ViewController: UIViewController {

    let button = UIButton(frame: buttonRect)
    let label = UILabel(frame: labelRect)
    let locationManager = CLLocationManager()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 初始化定位
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // 精确度
        locationManager.requestAlwaysAuthorization() // 发送开启定位的请求
        setupView()
    }
    
    private func setupView() {
        //将图片用作当前view的背景
        /*
         SWIFT
         view.layer.contents = UIImage(named:"Image_Name").CGImage
         Objective-C
         view.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"Image_Name"].CGImage);
         */
        self.view.layer.contents = UIImage(named: "bg")?.cgImage
        
        // 添加毛玻璃效果
        let visual = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        visual.frame = ScreenRect
        
        label.text = "未定位"
        label.textColor = UIColor.white
        label.textAlignment = .center
        
        button.setTitle("点击定位", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setBackgroundImage(UIImage(named:"Find my location"), for: .normal)
        button.addTarget(self, action: #selector(findLoaction), for: .touchUpInside)
        
        view.addSubview(visual)
        view.addSubview(button)
        view.addSubview(label)
    }
    
    @objc private func findLoaction() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }else {
            locationManager.requestAlwaysAuthorization()
        }
    }
    

}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        label.text = "Error:" + error.localizedDescription
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let newLocal = locations.first {
            CLGeocoder().reverseGeocodeLocation(newLocal, completionHandler: { (pms, err) in
                if(pms?.last?.location?.coordinate != nil) {
                    manager.stopUpdatingLocation() // 停止定位,节省电量,只获取一个定位
                    // 获取第一个地标
                    let  placemark: CLPlacemark = (pms?.last)!
                    print(placemark)
                    let name = placemark.name ; // 地名
                    //let thoroughfare = placemark.thoroughfare ; // 街道
                    //let locality = placemark.locality; // 城市
                    //别的含义
                    //let location = placemark.location;//位置
                    //let region = placemark.region;//区域
                    //let addressDic = placemark.addressDictionary;//详细地址信息字典,包含以下部分信息
                    //let subLocality=placemark.subLocality; // 城市相关信息，例如标志性建筑
                    //let administrativeArea=placemark.administrativeArea; // 州
                    //let subAdministrativeArea=placemark.subAdministrativeArea; //其他行政区域信息
                    //let postalCode=placemark.postalCode; //邮编
                    //let ISOcountryCode=placemark.ISOcountryCode; //国家编码
                    //let country=placemark.country; //国家
                    //let inlandWater=placemark.inlandWater; //水源、湖泊
                    //let ocean=placemark.ocean; // 海洋
                    //let areasOfInterest=placemark.areasOfInterest; //关联的或利益相关的地标
                    guard let n = name  else{
                        return
                    }
                    self.label.text = n
                    
                }
            })
        }
    }
}

