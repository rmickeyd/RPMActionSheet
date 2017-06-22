//
//  RPMActionTableViewCell.swift
//  RPMActionSheet
//
//  Created by Ryan McDonald on 6/21/17.
//  Copyright © 2017 rmickeyd. All rights reserved.
//

import UIKit

class RPMActionTableViewCell: UITableViewCell {

    @IBOutlet weak var actionTitleLabel: UILabel!
    
    @IBOutlet weak var actionImageView: UIImageView!
    
    @IBOutlet weak var hairlineView: UIView!
    
    @IBOutlet weak var cancelTitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureCell(_ action: RPMAlertAction) {
        switch action.style {
        case .default:
            actionTitleLabel.text = action.title
            actionImageView.image = action.image
            
            if let color = action.titleColor {
                actionTitleLabel.textColor = color
            }
            
            if let color = action.imageColor {
                actionImageView.tintColor = color
            }
            
        case .cancel:
            cancelTitleLabel.text = action.title
            
            if let color = action.titleColor {
                cancelTitleLabel.textColor = color
            }
        }
        

        

    }

}
