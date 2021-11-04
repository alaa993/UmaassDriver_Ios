//
//  RequestTableViewCell.swift
//  UmaassProvider
//
//  Created by Hesam on 7/2/1398 AP.
//  Copyright © 1398 Hesam. All rights reserved.
//

import UIKit

class RequestTableViewCell: UITableViewCell {

    @IBOutlet weak var apptMainView          : UIView!
    @IBOutlet weak var smallView             : UIView!
    @IBOutlet weak var providerNameLabel     : UILabel!
    @IBOutlet weak var serviceNameLabel      : UILabel!
    @IBOutlet weak var servLab: UILabel!
    @IBOutlet weak var PatientLabel          : UILabel!
    @IBOutlet weak var dateLabel             : UILabel!
    @IBOutlet weak var timeLabel             : UILabel!
    @IBOutlet weak var AppoinmentStatusLabel : UILabel!
    @IBOutlet weak var statusImage           : UIImageView!
    
    @IBOutlet weak var applicantNameLab: UILabel!
    @IBOutlet weak var nameLab: UILabel!
    @IBOutlet weak var dateLab: UILabel!
    @IBOutlet weak var timeLab: UILabel!
    
    override func awakeFromNib(){
        super.awakeFromNib()
        
        setLabelLanguageData(label: applicantNameLab, key: "Applicant Name")
        setLabelLanguageData(label: servLab, key: "Service")
        setLabelLanguageData(label: nameLab, key: "Name")
        setLabelLanguageData(label: dateLab, key: "date")
        setLabelLanguageData(label: timeLab, key: "time")
        
        cornerViews(view: apptMainView, cornerValue: 4.0, maskToBounds: true)
        cornerViews(view: smallView, cornerValue: 4.0, maskToBounds: true)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
