//
//  ThirdViewController.swift
//  Chapter03-TabBar
//
//  Created by sjbyun on 2018. 9. 11..
//  Copyright © 2018년 Byunsangjin. All rights reserved.
//

import UIKit
class ThirdViewController : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let title = UILabel(frame: CGRect(x: 0, y: 100, width: 100, height: 30))
        
        title.text = "세 번째 탭"
        title.textColor = UIColor.red // 텍스트는 빨간색
        title.textAlignment = .center // 레이블 내에 중앙 정렬
        title.font = UIFont.boldSystemFont(ofSize: 14) // 폰트는 System Font, 14pt
        
        title.sizeToFit() // 콘텐츠의 내용에 맞게 레이블 크기 변경
        
        title.center.x = self.view.frame.width/2 // x축이 중앙에 오도록
        
        self.view.addSubview(title)
        
        
    }
}
