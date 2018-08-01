//
//  ResultViewController.swift
//  SubmitValue
//
//  Created by sjbyun on 2018. 8. 2..
//  Copyright © 2018년 Byunsangjin. All rights reserved.
//

import UIKit
class ResultViewController: UIViewController{
    @IBOutlet var resultEmail: UILabel! // 이메일
    
    @IBOutlet var resultUpdate: UILabel! // 자동갱신 여부
    
    @IBOutlet var resultInterval: UILabel! // 갱신주기
    
    var paramEmail: String = ""
    
    var paramUpdate: Bool = false
    
    var paramInterval: Double = 0
    
    override func viewDidLoad() {
        self.resultEmail.text = paramEmail
        self.resultUpdate.text = (self.paramUpdate == true ? "자동갱신" : "자동갱신안함" )
        self.resultInterval.text = "\(Int(paramInterval))분 마다 갱신"
    }
    
    @IBAction func onBack(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
}
