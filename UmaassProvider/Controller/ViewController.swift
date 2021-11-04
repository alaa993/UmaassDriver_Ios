//
//  ViewController.swift
//  UmaassProvider
//
//  Created by Hesam on 7/2/1398 AP.
//  Copyright © 1398 Hesam. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

var pleaseWait = String()
extension UIViewController : NVActivityIndicatorViewable {
   
    func loading(){
        let size = CGSize(width: 60, height: 60)
        setMessageLanguageData(&pleaseWait, key: "Please wait")
        startAnimating(size, message: pleaseWait, type: NVActivityIndicatorType.ballClipRotateMultiple)
    }
    func dismissLoding(){
        stopAnimating()
    }
    
}
