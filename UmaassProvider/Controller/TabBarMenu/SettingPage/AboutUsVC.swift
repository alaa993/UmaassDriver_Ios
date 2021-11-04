//
//  AboutUsVC.swift
//  UmaassProvider
//
//  Created by Hesam on 7/2/1398 AP.
//  Copyright © 1398 Hesam. All rights reserved.
//

import UIKit



class AboutUsVC: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var whoeWeLab: UILabel!

    @IBOutlet weak var scrollView: UIScrollView!
    
    
//    @IBOutlet weak var bannerView: GADBannerView!
    
    var passedtext      : String?
    var passedValueType = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.layer.cornerRadius = 8.0
        scrollView.layer.masksToBounds = true
        if #available(iOS 11.0, *) {
            scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: textLabel.bottomAnchor).isActive = true
        } else {
            scrollView.bottomAnchor.constraint(equalTo:textLabel.bottomAnchor).isActive = true
        }
        
        setLabelLanguageData(label: whoeWeLab, key: "Who we are")
        
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
        
        // ------------- banner view --------------
     
        
        
        setMessageLanguageData(&aboutusPageTitle, key: "about us")
        self.navigationItem.title = aboutusPageTitle
        let data = self.passedtext?.data(using: String.Encoding.unicode)!
        if data != nil {
            let attrStr = try? NSMutableAttributedString(data: data!,options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],documentAttributes: nil)
            
            attrStr!.addAttributes([NSMutableAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14), NSMutableAttributedString.Key.foregroundColor: UIColor.black], range: NSMakeRange(0, attrStr!.length))
            
            self.textLabel.attributedText = attrStr
          
        }else{
            self.textLabel.text = "About app ..."
        }
        
    }
}




