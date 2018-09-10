//
//  ViewController.swift
//  Chapter02-Button
//
//  Created by sjbyun on 2018. 9. 10..
//  Copyright © 2018년 Byunsangjin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 버튼 인스턴스를 생성하고, 속성을 설정한다.
        let btn = UIButton(type: UIButtonType.system)
        btn.frame = CGRect(x: 50, y: 100, width: 150, height: 30)
        btn.setTitle("테스트 버튼", for: UIControlState.normal)
        
        // 버튼을 수평 중앙 정렬한다.
        btn.center = CGPoint(x: self.view.frame.size.width/2, y: 100)
        
        // 루트 뷰에 버튼을 추가한다.
        self.view.addSubview(btn)
        
        // 버튼의 이벤트와 메소드 btnOnClick(_:)을 연결한다.
        btn.addTarget(self, action: #selector(btnOnClick(_:)), for: .touchUpInside)
    }
    
    @objc func btnOnClick(_ sender : Any) {
        // 호출한 객체가 버튼이라면
        if let btn = sender as? UIButton {
            btn.setTitle("클릭 되었습니다", for : UIControlState.normal)
        }
    }
}

