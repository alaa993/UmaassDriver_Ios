//
//  ServiceTableViewCell.swift
//  UmaassProvider
//
//  Created by Hesam on 7/2/1398 AP.
//  Copyright © 1398 Hesam. All rights reserved.
//

import UIKit

protocol manageServiceDelegate {
    func deleteService(cell: UITableViewCell)
    func editService(cell: UITableViewCell)
}

var serviceCellDelegate : manageServiceDelegate?


class ServiceTableViewCell: UITableViewCell {

    @IBOutlet weak var serviceView: UIView!
    
    @IBOutlet weak var serviceNameLable: UILabel!
    @IBOutlet weak var servicePriceLabel: UILabel!
    @IBOutlet weak var serviceTimeLabel: UILabel!
    
    @IBOutlet weak var servDeleteOutlet: UIButton!
    @IBOutlet weak var editServOutlet: UIButton!
    
    
    @IBOutlet weak var servNameLab: UILabel!
    @IBOutlet weak var servPriceLab: UILabel!
    @IBOutlet weak var servTimeLab: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setLabelLanguageData(label: servNameLab, key: "Service Name")
        setLabelLanguageData(label: servPriceLab, key: "Service Price")
        setLabelLanguageData(label: servTimeLab, key: "Service Time Duration")
        
        setButtonLanguageData(button: servDeleteOutlet, key: "Delete")
        setButtonLanguageData(button: editServOutlet, key: "Edit")
        
        cornerViews(view: serviceView, cornerValue: 8.0, maskToBounds: true)
    }
    
    @IBAction func editServiceTapped(_ sender: Any) {
        serviceCellDelegate?.editService(cell: self)
    }
    
    @IBAction func deleteServiceTapped(_ sender: Any) {
        serviceCellDelegate?.deleteService(cell: self)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
