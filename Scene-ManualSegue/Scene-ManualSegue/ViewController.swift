//
//  ViewController.swift
//  Scene-ManualSegue
//
//  Created by sjbyun on 2018. 8. 1..
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

    @IBAction func wind(_ sender: Any) {
        //세그웨이를 실행한다
        self.performSegue(withIdentifier: "ManualWind", sender: self)
    }
    
}

