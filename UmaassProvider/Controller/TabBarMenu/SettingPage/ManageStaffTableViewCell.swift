//
//  ManageStaffTableViewCell.swift
//  UmaassProvider
//
//  Created by Hesam on 7/2/1398 AP.
//  Copyright © 1398 Hesam. All rights reserved.
//

import UIKit
import Cosmos
class ManageStaffTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var roleLable: UILabel!
    @IBOutlet weak var numberLable: UILabel!
    @IBOutlet weak var permissionLabel: UILabel!
    @IBOutlet weak var mainView : UIView!
    @IBOutlet weak var rateView : CosmosView!
    
    
    @IBOutlet weak var userNameLab: UILabel!
    @IBOutlet weak var ratLab: UILabel!
    @IBOutlet weak var roleLab: UILabel!
    @IBOutlet weak var phoneLab: UILabel!
    @IBOutlet weak var permissionLab: UILabel!
    
    
    @IBOutlet weak var deleteOutlet: UIButton!
    @IBOutlet weak var editOutlet: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        setLabelLanguageData(label: userNameLab, key: "user name")
        setLabelLanguageData(label: ratLab, key: "rating")
        setLabelLanguageData(label: roleLab, key: "roll")
        setLabelLanguageData(label: phoneLab, key: "phone")
        setLabelLanguageData(label: permissionLab, key: "permission")
        
        setButtonLanguageData(button: deleteOutlet, key: "Delete")
        setButtonLanguageData(button: editOutlet, key: "Edit")
        
        cornerViews(view: mainView, cornerValue: 6.0, maskToBounds: true)
    }
    
    @IBAction func deleteStaffTapped(_ sender: UIButton) {
        staffCellDelegate?.deleteStaff(cell: self)
        
    }
    
    @IBAction func editStaffTapped(_ sender: UIButton) {
        celltag = sender.tag
        staffCellDelegate?.editStaff(cell: self)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

var celltag = 0
