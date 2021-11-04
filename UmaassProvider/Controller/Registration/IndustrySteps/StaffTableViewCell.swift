//
//  StaffTableViewCell.swift
//  UmaassProvider
//
//  Created by Hesam on 7/2/1398 AP.
//  Copyright © 1398 Hesam. All rights reserved.
//

import UIKit

protocol manageStaffDelegate {
    func deleteStaff(cell: UITableViewCell)
    func editStaff(cell: UITableViewCell)
}

var staffCellDelegate : manageStaffDelegate?


class StaffTableViewCell: UITableViewCell {

    @IBOutlet weak var staffNameLabel: UILabel!
    @IBOutlet weak var stafRoolLabel: UILabel!
    @IBOutlet weak var staffPhoneLabel: UILabel!
    @IBOutlet weak var staffPermissionsLabel: UILabel!
    @IBOutlet weak var staffView: UIView!
    
    
    
    @IBOutlet weak var deleteStaffOutlet   : UIButton!
    @IBOutlet weak var editStaffOutlet     : UIButton!
    
   
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setButtonLanguageData(button: deleteStaffOutlet, key: "Delete")
        setButtonLanguageData(button: editStaffOutlet, key: "Edit")
        
        
        cornerViews(view: staffView, cornerValue: 8.0, maskToBounds: true)
        // Initialization code
    }
    
    
    @IBAction func editStaffTapped(_ sender: Any) {
        staffCellDelegate?.editStaff(cell: self)
    }
    
    @IBAction func deleteStaffTapped(_ sender: Any) {
        staffCellDelegate?.deleteStaff(cell: self)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
