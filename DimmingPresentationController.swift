//
//  DimmingPresentationController.swift
//  RPMActionSheet
//
//  Created by Ryan McDonald on 6/21/17.
//  Copyright © 2017 rmickeyd. All rights reserved.
//

import UIKit

class DimmingPresentationController: UIPresentationController {
 
    /// Allows presenting viewController to be visible when presenting a viewController with transparent background
    override var shouldRemovePresentersView: Bool {
        return false
    }
}
