//
//  ManageServiceTableViewCell.swift
//  UmaassProvider
//
//  Created by Hesam on 7/2/1398 AP.
//  Copyright © 1398 Hesam. All rights reserved.
//

import UIKit

class ManageServiceTableViewCell: UITableViewCell {

    @IBOutlet weak var serviceMainView: UIView!
    @IBOutlet weak var serviceName: UILabel!
    @IBOutlet weak var serviceTime: UILabel!
    @IBOutlet weak var servicePrice: UILabel!
    
    @IBOutlet weak var servNameLab: UILabel!
    @IBOutlet weak var servTimeLab: UILabel!
    @IBOutlet weak var servPriceLab: UILabel!
    
    @IBOutlet weak var deleteOutlet: UIButton!
    @IBOutlet weak var editOutlet: UIButton!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setLabelLanguageData(label: servNameLab, key: "Service Name")
        setLabelLanguageData(label: servTimeLab, key: "Service Time Duration")
        setLabelLanguageData(label: servPriceLab, key: "Service Price")
        
        
        setButtonLanguageData(button: deleteOutlet, key: "Delete")
        setButtonLanguageData(button: editOutlet, key: "Edit")
        cornerViews(view: serviceMainView, cornerValue: 6.0, maskToBounds: true)
        // Initialization code
    }
    
    @IBAction func deleteServiceTapped(_ sender: Any) {
        serviceCellDelegate?.deleteService(cell: self)
    }
    
    @IBAction func editServiceTapped(_ sender: Any) {
        serviceCellDelegate?.editService(cell: self)
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
