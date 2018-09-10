//
//  ViewController.swift
//  Chapter02-InputForm
//
//  Created by sjbyun on 2018. 9. 10..
//  Copyright © 2018년 Byunsangjin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // 입력용 컨트롤4
    var paramEmail : UITextField! // 이메일 입력 필드
    var paramUpdate : UISwitch! // 스위치 객체
    var paramInterval : UIStepper! // 스테퍼
    
    // 출력용 레이블
    var txtUpdate : UILabel!
    var txtInterval : UILabel! // 스테퍼 컨트롤의 값을 표현할 레이블
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 내비게이션 바 타이틀을 입력한다.
        self.navigationItem.title = "설정"
        
        // 이메일 레이블을 생성하고 영역과 기본 문구를 설정한다.
        let lblEmail = UILabel();
        lblEmail.frame = CGRect(x: 30, y: 100, width: 100, height: 30)
        lblEmail.text = "이메일"
        
        // 레이블의 폰트를 설정한다.
        lblEmail.font = UIFont.systemFont(ofSize: 14)
        
        // 레이블을 루트 뷰에 추가한다.
        self.view.addSubview(lblEmail)
        
        // 자동갱신 레이블을 생성하고 루트 뷰에 추가한다.
        let lblUpdate = UILabel();
        lblUpdate.frame = CGRect(x: lblEmail.frame.origin.x, y: lblEmail.frame.origin.y + 50, width: lblEmail.bounds.width, height: lblEmail.bounds.height)
        lblUpdate.text = "자동갱신"
        lblUpdate.font = UIFont.systemFont(ofSize: 14)
        
        self.view.addSubview(lblUpdate)
        
        // 갱신주기 레이블을 생성하고 루트 뷰에 추가한다.
        let lblInterval = UILabel()
        lblInterval.frame = CGRect(x: lblEmail.frame.origin.x, y: lblEmail.frame.origin.y + 100, width: lblEmail.bounds.width, height: lblEmail.bounds.height)
        lblInterval.text = "갱신주기"
        lblInterval.font = UIFont.systemFont(ofSize: 14)
        
        self.view.addSubview(lblInterval)
        
        // 이메일 입력을 위한 텍스트 필드를 추가한다.
        self.paramEmail = UITextField()
        self.paramEmail.frame = CGRect(x: lblEmail.frame.origin.x + 90, y: lblEmail.frame.origin.y, width: 220, height: lblEmail.bounds.height)
        self.paramEmail.font = UIFont.systemFont(ofSize: 13)
        self.paramEmail.borderStyle = UITextBorderStyle.roundedRect
        self.paramEmail.placeholder = "qustkdwls1@naver.com"
        self.paramEmail.autocapitalizationType = .none
        
        self.view.addSubview(self.paramEmail)
        
        // 스위치 객체를 생성한다.
        self.paramUpdate = UISwitch()
        self.paramUpdate.frame = CGRect(x: paramEmail.frame.origin.x, y: paramEmail.frame.origin.y + 50, width: 50, height: lblEmail.bounds.height)
        
        // 스위치가 On되어 있는 상태를 기본값으로 설정한다.
        self.paramUpdate.setOn(true, animated: true)
        
        self.view.addSubview(paramUpdate)
        
        // 갱신주기를 위한 스테퍼를 추가한다.
        self.paramInterval = UIStepper()
        
        self.paramInterval.frame = CGRect(x: paramEmail.frame.origin.x, y: paramEmail.frame.origin.y + 100, width: 50, height: lblEmail.bounds.height)
        self.paramInterval.minimumValue = 0 // 스테퍼가 가질 수 있는 최소값
        self.paramInterval.maximumValue = 100 // 스테퍼가 가질 수 있는 최대값
        self.paramInterval.stepValue = 1 // 스테퍼의 값 변경 단위
        self.paramInterval.value = 0 // 초기 값 설정
        
        self.view.addSubview(paramInterval)
        
        // 스위치 객체의 값을 표현할 레이블을 추가한다.
        self.txtUpdate = UILabel()
        self.txtUpdate.frame = CGRect(x: lblEmail.frame.origin.x + 220, y: paramEmail.frame.origin.y + 50, width: 100, height: lblEmail.bounds.height)
        self.txtUpdate.font = UIFont.systemFont(ofSize: 12)
        self.txtUpdate.textColor = UIColor.red // 텍스트 색상 설정
        self.txtUpdate.text = "갱신함" // "갱신함" or "갱신하지 않음"
        
        self.view.addSubview(txtUpdate)
        
        // 스테퍼의 값을 텍스트로 표현할 레이블을 추가한다.
        self.txtInterval = UILabel()
        self.txtInterval.frame = CGRect(x: txtUpdate.frame.origin.x, y: paramEmail.frame.origin.y + 100, width: 100, height: lblEmail.bounds.height)
        self.txtInterval.font = UIFont.systemFont(ofSize: 12)
        self.txtInterval.textColor = UIColor.red
        self.txtInterval.text = "0분마다"
        
        self.view.addSubview(txtInterval)
        
        // 스위치와 스테퍼 컨트롤 Value Changed 이벤트를 각각 액션 메소드에 연결한다.
        self.paramUpdate.addTarget(self, action: #selector(presentUpdateValue), for: .valueChanged)
        self.paramInterval.addTarget(self, action: #selector(presentIntervalValue), for: .valueChanged)
        
        // 전송 버튼을 내비게이션 아이템에 추가하고, submit 메소드에 연결한다.
        let submitBtn = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(submit(_:)))
        self.navigationItem.rightBarButtonItem = submitBtn
    }
    
    // 스위치와 상호반응할 액션 메소드
    @objc func presentUpdateValue(_ sender: UISwitch) {
        self.txtUpdate.text = (sender.isOn == true ? "갱신함" : "갱신하지 않음")
    }
    
    // 스테퍼와 상호반응할 액션 메소드
    @objc func presentIntervalValue(_ sender: UIStepper) {
        self.txtInterval.text = ("\(Int(sender.value))분마다")
    }

    // 전송버튼과 상호반응할 액션 메소드
    @objc func submit(_ sender : Any) {
        let rvc = ReadViewController()
        rvc.pEmail = self.paramEmail.text
        rvc.pUpdate = self.paramUpdate.isOn
        rvc.pInterval = self.paramInterval.value
        
        self.navigationController?.pushViewController(rvc, animated: true)
    }
    
}

