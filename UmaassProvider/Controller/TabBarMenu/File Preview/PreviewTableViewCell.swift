//
//  PreviewTableViewCell.swift
//  UmaassProvider
//
//  Created by Hesam on 7/13/1398 AP.
//  Copyright © 1398 Hesam. All rights reserved.
//

import UIKit

protocol previewDelegate {
    func sharePreview(cell: UITableViewCell)
    func deletePreview(cell: UITableViewCell)
}

class PreviewTableViewCell: UITableViewCell {

    @IBOutlet weak var mainView            : UIView!
    @IBOutlet weak var avatar              : UIImageView!
    @IBOutlet weak var paitientNameLabel   : UILabel!
    @IBOutlet weak var numberOutlet        : UIButton!
    
    @IBOutlet weak var nameLab: UILabel!
    @IBOutlet weak var numberLab: UILabel!
    
    
    
    //    @IBOutlet weak var shareOutlet         : UIButton!
    
    var previewCellDelegate: previewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setLabelLanguageData(label: nameLab, key: "Client Name")
        setLabelLanguageData(label: numberLab, key: "phone")
        cornerViews(view: mainView, cornerValue: 6.0, maskToBounds: true)
        cornerImage(image: avatar, cornerValue: Float(avatar.frame.height / 2), maskToBounds: true)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}




