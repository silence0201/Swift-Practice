//
//  ViewController.swift
//  URLImage
//
//  Created by 杨晴贺 on 2017/3/30.
//  Copyright © 2017年 Silence. All rights reserved.
//

import UIKit

let imageURL = "http://c.hiphotos.baidu.com/zhidao/pic/item/5ab5c9ea15ce36d3c704f35538f33a87e950b156.jpg"

class ViewController: UIViewController {

    let datas = ["普通方式打开","普通方式下载图片","自定义方式下载图片","带进度的下载方式"]
    var images = [UIImageView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        for (index,(x,y)) in [(0,0),(1,0),(0,1),(1,1)].enumerated() {
            images.append(bulid(rect: CGRect(x: SWidth/2*CGFloat(x), y: SHeight/2*CGFloat(y), width: SWidth/2, height: SHeight/2), tag: index, title: datas[index]))
        }
    }
    
    func bulid(rect: CGRect, tag: Int, title: String) -> UIImageView {
        let imageV = UIImageView(frame: rect)
        imageV.contentMode = .center
        imageV.backgroundColor = .white
        imageV.clipsToBounds = true
        imageV.tag = tag
        let label = UILabel(frame: imageV.bounds)
        label.textAlignment = .center
        label.textColor = .orange
        label.text = title
        imageV.addSubview(label)
        view.addSubview(imageV)
        return imageV
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let point = touches.first?.location(in: nil) {
            switch (point.x,point.y) {
            /*区间运算符：...闭区间，..<半闭区间*/
            case (0...SWidth/2,0...SHeight/2):
                loadImage()
                print("左上")
            case (SWidth/2...SWidth,0...SHeight/2):
                downImage()
                print("右上")
            case (0...SWidth/2,SHeight/2...SHeight):
                backgroundDownload()
                print("左下")
            default:
                showLoadProgress()
                print("右下")
            }

        }
    }
    
    /*swift3 GCD:
     使用Global Queue
     DispatchQueue.global().async{//子线程
     DispatchQueue.main.async {//主线程
     self.label?.text="finished"
     }
     }
     优先级：
     * DISPATCH_QUEUE_PRIORITY_HIGH:         .userInitiated
     * DISPATCH_QUEUE_PRIORITY_DEFAULT:      .default
     * DISPATCH_QUEUE_PRIORITY_LOW:          .utility
     * DISPATCH_QUEUE_PRIORITY_BACKGROUND:   .background
     DispatchQueue.global(qos: .userInitiated).async{
     }
     使用DispatchWorkItem
     let queue = DispatchQueue(label: "swift.queue")
     let workItem = DispatchWorkItem(qos: .userInitiated, flags: .assignCurrentContext) {
     }
     queue.async(execute: workItem)
     dispatch_time_t
     let delay = DispatchTime.now() + .seconds(60)
     DispatchQueue.main.after(when: delay) {
     }
     DispatchTime.now()获取当前时间
     */

    
    func loadImage() {
        if let url = URL(string: imageURL) {
            // 最基本的使用方法
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                /*data:获得的数据  response:回复  error:错误*/
                print("默认读取完毕。线程:\(Thread.current)")
                // 回到主线程更新
                DispatchQueue.main.async {
                    self.images.first?.image = UIImage(data: data!)
                }
            }).resume()
        }
    }
    
    func downImage() {
        /*urlsession的task有三种：
         1:dataTask,普通的读取服务端数据操作
         2:downloadTask,下载文件
         3:uploadTask,上传文件
         */
        if let url = URL(string: imageURL) {
            URLSession.shared.downloadTask(with: url, completionHandler: { (location, response, error) in
                /*location:下载好的文件位置(该文件临时缓存，需要移动出来)  response:回复  error:错误*/
                print("默认下载完毕，位置：\(String(describing: location?.path))。线程:\(Thread.current)")
                DispatchQueue.main.async {
                    do {
                        self.images[1].image = try UIImage(data: Data(contentsOf: location!))
                    }catch let err as NSError {
                        print("打开文件失败:\(String(describing: err.localizedFailureReason))")
                    }
                }
            }).resume()
        }
    }

    /*自定义session：
     init(configuration:)
     init(configuration:delegate:delegateQueue:)
     都需要一个SessionConfiguration对象。该对象有三种初始化方法：
     default:该配置使用全局缓存，cookie等信息
     ephemeral:不会对缓存或cookie以及认证信息进行存储，相当于一个私有session
     background:让网络操作在应用切换到后台后还继续工作
     */
    func backgroundDownload() {
        if let url = URL(string: imageURL) {
            let configuartion = URLSessionConfiguration.default
            let session = URLSession(configuration: configuartion)
            session.downloadTask(with: url, completionHandler: { (location, response, error) in
                print("自定义下载完毕，位置：\(String(describing: location?.path))。\(Thread.current)")
                DispatchQueue.main.async {
                    do {
                        self.images[2].image = try UIImage(data: Data(contentsOf: location!))
                    }catch let err as NSError {
                        print("打开文件失败:\(String(describing: err.localizedFailureReason))")
                    }
                }

            }).resume()
        }
    }
    
    //使用代理，上面的方法都是采用闭包的方式处理网络完成的情况，如果需要监听网络操作过程中的事件，需要使用代理
    /*sessionDelegate:网络请求最基本的代理方法
     sessionTaskDelegate:请求任务相关的代理方法
     sessionDownloadDelegate:下载任务代理方法，比如进度
     sessionDataDelegate:普通数据和上传任务代理方法
     */
    //监测下载进度
    func showLoadProgress() {
        if let url = URL(string: imageURL) {
            //后台下载，必须是设置代理的方式才可以后台下载
            let session = URLSession(configuration: .background(withIdentifier: "download"), delegate: self, delegateQueue: nil)
            session.downloadTask(with: url).resume()
        }
    }
}

extension ViewController:URLSessionDownloadDelegate {
    //下载
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        print("下载进度：\(totalBytesWritten)/\(totalBytesExpectedToWrite)")
    }
    
    //重新下载
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didResumeAtOffset fileOffset: Int64, expectedTotalBytes: Int64) {
        print("从\(fileOffset)处恢复下载，一共\(expectedTotalBytes)")
    }
    //下载完毕
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("代理下载完毕，位置：\(location.path)。\(Thread.current)")
        DispatchQueue.main.async {
            do {
                self.images[3].image = try UIImage(data: Data(contentsOf: location))
            }catch let err as NSError {
                print("打开文件失败:\(String(describing: err.localizedFailureReason))")
            }
        }
    }

}

