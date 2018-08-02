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
        // UserDefault 객체의 인스턴스를 가져온다
        let ud = UserDefaults.standard
        
        // 값을 저장한다.
        ud.set(self.email.text, forKey: "email")
        ud.set(self.isUpdate.isOn, forKey: "isUpdate")
        ud.set(self.interval.value, forKey: "interval")
        
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
