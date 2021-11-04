//
//  PreviweDetailsTableViewCell.swift
//  UmaassProvider
//
//  Created by Hesam on 7/13/1398 AP.
//  Copyright © 1398 Hesam. All rights reserved.
//

import UIKit

protocol EditPreviewDelegate {
    func editPreview(cell: UITableViewCell)
    func didSet(cell: UITableViewCell)
}


class PreviweDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var mainView                  : UIView!
    @IBOutlet weak var topLabel                  : UILabel!
    @IBOutlet weak var descriptipnLabel          : UILabel!
    @IBOutlet weak var clientNameLbl             : UILabel!
//    @IBOutlet weak var clientAgeLbl              : UILabel!
    @IBOutlet weak var statusLbl                 : UILabel!
    
    @IBOutlet weak var clientnameLab: UILabel!
//    @IBOutlet weak var clienAgeLab: UILabel!
    @IBOutlet weak var descLab: UILabel!
    @IBOutlet weak var statusLab: UILabel!
    @IBOutlet weak var moreDetailsLab: UILabel!
    
    
     var previewCellDelegate : EditPreviewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setLabelLanguageData(label: clientnameLab, key: "Client Name")
//        setLabelLanguageData(label: clienAgeLab, key: "client age")
        setLabelLanguageData(label: descLab, key: "description")
        setLabelLanguageData(label: statusLab, key: "status")
        setLabelLanguageData(label: moreDetailsLab, key: "More details")
        cornerViews(view: mainView, cornerValue: 6.0, maskToBounds: true)
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}



 // Configure the view for the selected state
