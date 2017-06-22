//
//  ViewController.swift
//  RPMActionSheet
//
//  Created by Ryan McDonald on 6/21/17.
//  Copyright © 2017 rmickeyd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var instrumentImageView: UIImageView!

    @IBAction func selectFavoriteInstrument(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let actionVC = storyboard.instantiateViewController(withIdentifier: "RPMActionSheetViewController") as! RPMActionSheetViewController
        
        let guitarAction = RPMAlertAction(title: "Guitar", image: #imageLiteral(resourceName: "guitar"), style: .default) {
            self.instrumentImageView.image = #imageLiteral(resourceName: "guitar")
        }
        guitarAction.imageColor = UIColor.green
        guitarAction.titleColor = UIColor.red
        
        let pianoAction = RPMAlertAction(title: "Piano", image: #imageLiteral(resourceName: "piano"), style: .default) {
            self.instrumentImageView.image = #imageLiteral(resourceName: "piano")
        }
        
        let trumpetAction = RPMAlertAction(title: "Trumpet", image: #imageLiteral(resourceName: "trumpet"), style: .default) { 
            self.instrumentImageView.image = #imageLiteral(resourceName: "trumpet")
        }
        
        let cancelAction = RPMAlertAction(title: "Cancel", image: nil, style: .cancel, action: nil)
        cancelAction.titleColor = UIColor.purple
        
        actionVC.addAction(guitarAction)
        actionVC.addAction(pianoAction)
        actionVC.addAction(trumpetAction)
        actionVC.addAction(cancelAction)
        
        present(actionVC, animated: false, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

}

