//
//  ViewController.swift
//  LoginView
//
//  Created by 杨晴贺 on 2017/3/30.
//  Copyright © 2017年 Silence. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let passnameField = UITextField(frame: CGRect(x: 20, y: SHeight/2, width: SWidth-40, height: 30))
    let passwordField = UITextField(frame: CGRect(x: 20, y: SHeight/2+30+10, width: SWidth-40, height: 30))
    let loginBtn = UIButton(frame: CGRect(x: 20, y: SHeight/2+30*2+30, width: SWidth-40, height: 30))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        view.backgroundColor = UIColor.white
        passnameField.modificationTextField(placeholer: "请输入手机号", keyboardType: .numberPad, text: nil)
        passwordField.modificationTextField(placeholer: "请输入密码'", keyboardType: .asciiCapable, text: nil)
        loginBtn.modificationButton(title: "登陆")
        
        view.addSubview(passwordField)
        view.addSubview(passnameField)
        view.addSubview(loginBtn)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(note:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHiden(note:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    func keyboardWillShow(note: Notification) {
        let keyBoardHeight = (note.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
         Log("键盘高度：\(keyBoardHeight)")
        if keyBoardHeight/2 == -view.frame.origin.y {
            Log("无需再次移动！")
            return
        }
        UIView.animate(withDuration: 1) {
            self.view.frame = CGRect(x: 0, y: -keyBoardHeight/2, width: SWidth, height:SHeight)
        }
    }
    
    func keyboardWillHiden(note: Notification) {
        if view.frame.origin.x == 0 {
            Log("无需再次复位！")
        }
        UIView.animate(withDuration: 1) {
            self.view.frame = SRect
        }

    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

