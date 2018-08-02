//
//  ViewController.swift
//  SubmitValue
//
//  Created by sjbyun on 2018. 8. 2..
//  Copyright © 2018년 Byunsangjin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 이메일 주소를 입력받는 텍스트필드
    @IBOutlet var email: UITextField!
    // 자동 갱신 여부를 설정하는 스위치
    @IBOutlet var isUpdate: UISwitch!
    // 갱신 주기를 설정하는 스테퍼
    @IBOutlet var interval: UIStepper!
    // 자동갱신 여부를 표시하는 레이블
    @IBOutlet var isUpdateText: UILabel!
    // 갱신주기를 텍스트로 표시하는 레이블
    @IBOutlet var intervalText: UILabel!
    
    @IBAction func onSwitch(_ sender: UISwitch) {
        if (sender.isOn == true){
            self.isUpdateText.text = "갱신함"
        } else {
            self.isUpdateText.text = "갱신하지 않음"
        }
    }
    
    @IBAction func onStepper(_ sender: UIStepper) {
        let value = Int(sender.value)
        self.intervalText.text = "\(value)분 마다"
    }
    
    @IBAction func onSubmit(_ sender: Any) {
        //VC2의 인스턴스 생성
        guard let rvc = self.storyboard?.instantiateViewController(withIdentifier:
            "RVC") as? ResultViewController else{
            return
        }
        
        // 값을 전달하는 과정
        rvc.paramEmail = self.email.text!
        rvc.paramUpdate = self.isUpdate.isOn
        rvc.paramInterval = self.interval.value
        
        // self.present(rvc, animated: true)
        self.navigationController?.pushViewController(rvc, animated: true)
        
    }
    
    @IBAction func onPerformSegue(_ sender: Any) {
        self.performSegue(withIdentifier: "ManualSubmit", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 목적지 뷰 컨트롤러 인스턴스 읽어오기
        let dest = segue.destination
        
        guard let rvc = dest as? ResultViewController else{
            return
        }
        
        // 값 전달
        rvc.paramEmail = self.email.text!
        rvc.paramUpdate = self.isUpdate.isOn
        rvc.paramInterval = self.interval.value
        
    }
}

