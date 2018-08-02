//
//  FormViewController.swift
//  SubmitValue-Back
//
//  Created by sjbyun on 2018. 8. 2..
//  Copyright © 2018년 Byunsangjin. All rights reserved.
//

import UIKit
class FormViewController: UIViewController{
    
    @IBOutlet var email: UITextField!
    
    @IBOutlet var isUpdate: UISwitch!
    
    @IBOutlet var interval: UIStepper!
    
    @IBOutlet var isUpdateText: UILabel!
    
    @IBOutlet var intervalText: UILabel!
    
    
    
    @IBAction func onSubmit(_ sender: Any) {
        // presentingViewController 속성을 통해 이전 화면 객체를 읽어온 다음, ViewController 타입으로 캐스팅한다.
        let preVC = self.presentingViewController
        guard let vc = preVC as? ViewController else{
            return
        }
        
        // 값을 전달한다
        vc.paramEmail = self.email.text
        vc.paramUpdate = self.isUpdate.isOn
        vc.paramInterval = self.interval.value
        
        // 이전 화면으로 복귀한다
        self.presentingViewController?.dismiss(animated: true)
    }
    
    @IBAction func onSwitch(_ sender: UISwitch) {
        if(sender.isOn == true){
            isUpdateText.text = "갱신함"
        } else{
            isUpdateText.text = "갱신하지 않음"
        }
    }
    
    @IBAction func onStepper(_ sender: UIStepper) {
        let value = Int(sender.value)
        intervalText.text = "\(value)분 마다"
    }
    
}
