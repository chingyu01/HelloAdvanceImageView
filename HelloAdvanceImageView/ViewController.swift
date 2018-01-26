//
//  ViewController.swift
//  HelloAdvanceImageView
//
//  Created by 胡靜諭 on 2018/1/26.
//  Copyright © 2018年 胡靜諭. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var imageView1: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let original = "http://t.softarts.cc/class/北鼻.jpg"
        guard let encoded = original.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else{
            return
        }
        NSLog("Original:\(original)")
        print("Encoded:\(encoded)")
        
        guard let url = URL(string: encoded) else {
            return
        }
        imageView1.showImage(url: url)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

