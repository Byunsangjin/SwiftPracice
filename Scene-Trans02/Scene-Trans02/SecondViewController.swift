//
//  SecondViewController.swift
//  Scene-Trans02
//
//  Created by sjbyun on 2018. 7. 31..
//  Copyright © 2018년 Byunsangjin. All rights reserved.
//

import UIKit
class SecondViewController: UIViewController{
    
    @IBAction func back(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
    @IBAction func back2(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
}
