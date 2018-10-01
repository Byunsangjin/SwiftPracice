//
//  FrontVIewController.swift
//  Chapter04-SideBarDIY
//
//  Created by Byunsangjin on 01/10/2018.
//  Copyright © 2018 Byunsangjin. All rights reserved.
//

import UIKit

class FrontVIewController: UIViewController {
    
    var delegate: RevealViewController?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 사이드 바 오픈용 버튼 정의
        let btnSideBar = UIBarButtonItem(image: UIImage(named: "sidemenu.png"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(moveSide(_:)))
        
        // 버튼을 내비게이션 바의 왼쪽 영역에 추가
        self.navigationItem.leftBarButtonItem = btnSideBar
        
        // 화면 끝에서 다른 쪽으로 패닝하는 제스처를 정의
        let dragLeft = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(moveSide(_:)))
        dragLeft.edges = UIRectEdge.left // 시작 모서리는 왼쪽
        self.view.addGestureRecognizer(dragLeft)
        
        // 화면 스와이프하는 제스처를 정의(사이드 메뉴 닫기용)
        let dragRight = UISwipeGestureRecognizer(target: self, action: #selector(moveSide(_:)))
        dragRight.direction = .left
        self.view.addGestureRecognizer(dragRight)
    }
    
    
    
    @objc func moveSide(_ sender: Any) {
        if sender is UIScreenEdgePanGestureRecognizer {
            self.delegate?.openSideBar(nil)
        } else if sender is UISwipeGestureRecognizer {
            self.delegate?.closeSideBar(nil)
        } else if sender is UIBarButtonItem {
            if self.delegate?.isSideBarSowing == false {
                self.delegate?.openSideBar(nil) //사이드 바를 연다.
            } else {
                self.delegate?.closeSideBar(nil) // 사이드 바를 닫는다.
            }
        }
    }

}
