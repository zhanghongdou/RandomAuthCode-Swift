//
//  ViewController.swift
//  RandomAuthCode-Swift
//
//  Created by haohao on 16/10/19.
//  Copyright © 2016年 haohao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var codeViewSb: RandomAuthCodeSwift!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let view = RandomAuthCodeSwift.sharedRandomAuthCodeViewWithFrame(frame: CGRect(x: 0, y: 100, width: 100, height: 30))
        view.sendCodeMessageClosure = {(text : String) in
            print(text)
        }
        self.view.addSubview(view)
        self.codeViewSb.sendCodeMessageClosure = {(text : String) in
//            print(text)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

