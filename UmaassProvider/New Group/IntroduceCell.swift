//
//  IntroduceCell.swift
//  QDorProvider
//
//  Created by AlaanCo on 7/11/20.
//  Copyright © 2020 Hesam. All rights reserved.
//

import UIKit
import Cosmos
import SDWebImage

protocol DelegateIntroduce {
    func comment(model:Introduce?)
    func delete(model:Introduce?)
}

class IntroduceCell: UICollectionViewCell {
    
    var model:Introduce? {
        didSet {
            lbName.text = model?.name
            lbIncome.text = "\(model?.income ?? 0)"
            let url = URL(string: model?.avatar?.url_md ?? "")
            imageProfile.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "user"), options: .continueInBackground, completed: nil)
         //   imageProfile.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "staff"), options: .continueInBackground, context: nil)
            rating.rating = Double(model?.rate ?? 0)
        }
    }
    
    
   
    @IBOutlet var btnDelete: UIButton!
    @IBOutlet var rating: CosmosView!
    @IBOutlet var imageProfile: UIImageView!
    @IBOutlet var lbName: UILabel!
    @IBOutlet var lbIncome: UILabel!
    @IBOutlet var btnComments: UIButton!
    
    var delegate:DelegateIntroduce?
    
   override func awakeFromNib() {
          super.awakeFromNib()
        
        btnComments.setTitle(setMessage(key: "comments"), for: .normal)
        btnComments.setTitleColor(UIColor.blue, for: .normal)
        
        btnDelete.setTitle(setMessage(key: "Delete"), for:.normal)
        btnDelete.setTitleColor(UIColor.red, for: .normal)
    
    
        imageProfile.layer.cornerRadius = 60/2
        imageProfile.layer.masksToBounds = true
        
        
    }
    @IBAction func btnDelete(_ sender: Any) {
        delegate?.delete(model: model)
    }
    
    @IBAction func btnComment(_ sender: Any) {
        delegate?.comment(model: model)
        
    }
    
}
