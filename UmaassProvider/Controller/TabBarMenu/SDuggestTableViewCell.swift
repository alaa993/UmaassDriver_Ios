
//
//  SDuggestTableViewCell.swift
//  UmaassProvider
//
//  Created by Hesam on 7/2/1398 AP.
//  Copyright © 1398 Hesam. All rights reserved.
//

import UIKit

class SDuggestTableViewCell: UITableViewCell {

    @IBOutlet weak var suggestionView: UIView!
    @IBOutlet weak var startSuggestionDate: UILabel!
    @IBOutlet weak var endSuggestionDate: UILabel!
    
    @IBOutlet weak var startLab: UILabel!
    @IBOutlet weak var endLab: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setLabelLanguageData(label: startLab,key: "Start date")
        setLabelLanguageData(label: endLab, key: "End date")
        
        cornerViews(view: suggestionView, cornerValue: 6.0, maskToBounds: true)
        
        // Initialization code
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
