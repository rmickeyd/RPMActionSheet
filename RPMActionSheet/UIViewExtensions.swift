//
//  UIViewExtensions.swift
//  RPMActionSheet
//
//  Created by Ryan McDonald on 6/21/17.
//  Copyright © 2017 rmickeyd. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    /// Allows rounding of specific corners on an UIView
    ///
    /// - Parameters:
    ///   - corners: The corners of the view to be rounded
    ///   - radius: Radius of corner to be rounded
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}

