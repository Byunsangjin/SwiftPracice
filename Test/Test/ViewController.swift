//
//  ViewController.swift
//  Test
//
//  Created by sjbyun on 2018. 8. 31..
//  Copyright © 2018년 Byunsangjin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var sum = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var count = 0
        for row in 5...10 {
            count += 1
            self.sum += row
        }
        
        print("총 합은 \(self.sum), \(count)회 실행되었습니다")
    }
}

