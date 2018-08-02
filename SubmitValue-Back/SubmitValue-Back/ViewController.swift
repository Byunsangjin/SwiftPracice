//
//  ViewController.swift
//  SubmitValue-Back
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

    @IBOutlet var resultEmail: UILabel!
    
    @IBOutlet var resultUpdate: UILabel!
    
    @IBOutlet var resultInterval: UILabel!
    
    // 화면이 표시될 때마다 실행되는 메소드
    override func viewWillAppear(_ animated: Bool) {
        
        // UserDefault 객체의 인스턴스를 가져온다
        let ud = UserDefaults.standard
        
        if let email = ud.string(forKey: "email") {
            resultEmail.text = email
        }
        
        let update = ud.bool(forKey: "isUpdate")
        resultUpdate.text = (update == true ? "자동갱신" : "자동갱신안함")
        
        let interval = ud.double(forKey: "interval")
        resultInterval.text = "\(Int(interval))분 마다"
        
    }
    
}

