//
//  SecondViewController.swift
//  Scene-Trans01
//
//  Created by sjbyun on 2018. 7. 31..
//  Copyright © 2018년 Byunsangjin. All rights reserved.
//

import UIKit
class SecondViewController: UIViewController{
    @IBAction func dismiss(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
}
