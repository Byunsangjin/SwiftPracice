//
//  ViewController.swift
//  Chapter03-Alert
//
//  Created by sjbyun on 2018. 9. 12..
//  Copyright © 2018년 Byunsangjin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 기본 알림창 버튼 생성
        let defaultAlertBtn = UIButton(type: .system)
        defaultAlertBtn.frame = CGRect(x: 0, y: 100, width: 100, height: 30)
        defaultAlertBtn.center.x = self.view.frame.width/2
        defaultAlertBtn.setTitle("기본 알림창", for: .normal)
        defaultAlertBtn.addTarget(self, action: #selector(defaultAlert(_:)), for: .touchUpInside)
        
        self.view.addSubview(defaultAlertBtn)
    }
    
    @objc func defaultAlert(_ sender : Any) {
        // 알림창을 정의한다.
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        // 버튼을 정의한다.
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        // 버튼을 알림창에 추가한다.
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        
        // 알림창에 들어갈 뷰 컨트롤러
        let v = UIViewController()
        v.view.backgroundColor = UIColor.red
        
        alert.setValue(v, forKey: "contentViewController")
        
        // 알림창을 화면에 표시한다.
        self.present(alert, animated: false)
    }

}

