//
//  ShowImagesVC.swift
//  UmaassProvider
//
//  Created by Hesam on 7/2/1398 AP.
//  Copyright © 1398 Hesam. All rights reserved.
//

import UIKit

class ShowImagesVC: UIViewController , UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView  : UIScrollView!
    @IBOutlet weak var img         : UIImageView!
    
    var passedImgUrl : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let button = UIButton.init(type: .custom)
//        let widthConstraint = button.widthAnchor.constraint(equalToConstant: 50)
//        let heightConstraint = button.heightAnchor.constraint(equalToConstant: 50)
//        heightConstraint.isActive = true
//        widthConstraint.isActive = true
//        button.frame = CGRect.init(x: 0, y: 0, width: 50, height: 50)
//        cornerButton(button: button, cornerValue: 4.0, maskToBounds: true)
//        button.setImage(UIImage.init(named: "umaassIcon.png"), for: UIControl.State.normal)
//        let logoImg = UIBarButtonItem.init(customView: button)
//        self.navigationItem.rightBarButtonItem = logoImg
        
        getImage(urlStr: passedImgUrl ?? "", img: img)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return img
    }
}
