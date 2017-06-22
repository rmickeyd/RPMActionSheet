//
//  RPMAlertAction.swift
//  RPMActionSheet
//
//  Created by Ryan McDonald on 6/21/17.
//  Copyright © 2017 rmickeyd. All rights reserved.
//

import Foundation
import UIKit

class RPMAlertAction {
    
    enum RPMAlertActionStyle {
        case `default`
        case cancel
    }
    
    var title: String?
    var image: UIImage?
    var action: (() -> ())?
    var style: RPMAlertActionStyle
    var titleColor: UIColor? = nil
    var imageColor: UIColor? = nil
    
    init(title: String?, image: UIImage?, style: RPMAlertActionStyle, action: (() -> ())?) {
        self.title  = title
        self.image  = image?.withRenderingMode(.alwaysTemplate)
        self.action = action
        self.style  = style
    }
}
