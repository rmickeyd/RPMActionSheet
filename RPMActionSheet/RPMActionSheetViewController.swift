//
//  RPMActionSheetViewController.swift
//  RPMActionSheet
//
//  Created by Ryan McDonald on 6/21/17.
//  Copyright © 2017 rmickeyd. All rights reserved.
//

import UIKit

class RPMActionSheetViewController: UIViewController {

    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    fileprivate var actions: [RPMAlertAction] = []
    fileprivate var cancelAction: RPMAlertAction!
    fileprivate var selectedAction: RPMAlertAction?
    
    @IBOutlet weak var tableView: UITableView!
    
    /// Required initializer for presenting delegates
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }
    
    
    /// Animates the action sheet away
    /// Dismisses the view controller
    /// Performs action if one exists
    func close() {
        UIView.animate(withDuration: 0.2, animations: {
            self.view.backgroundColor = UIColor.clear
            self.bottomConstraint.constant = -self.tableView.frame.height
        }) { (true) in
            self.dismiss(animated: false, completion: {
                if let action = self.selectedAction {
                    if action.action != nil {
                        action.action!()
                    }
                }
            })
        }
    }
    
    
    /// Add actions to be visible in action sheet
    ///
    /// - Parameter action: The action to be shown in action sheet
    func addAction(_ action: RPMAlertAction) {
        if action.style == .cancel {
            cancelAction = action
        } else {
            actions.append(action)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(close))
        gestureRecognizer.cancelsTouchesInView = false
        gestureRecognizer.delegate = self
        view.addGestureRecognizer(gestureRecognizer)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .clear
        
        self.heightConstraint.constant = 44 * CGFloat(actions.count)
        
        if cancelAction != nil {
            self.heightConstraint.constant += 68
        }
        
        self.view.backgroundColor = UIColor.clear
        self.bottomConstraint.constant = -tableView.frame.height
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        UIView.animate(withDuration: 0.35, animations: {
            self.view.backgroundColor = UIColor(white: 0, alpha: 0.5)
            self.bottomConstraint.constant = 8
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
}

extension RPMActionSheetViewController: UITableViewDelegate, UITableViewDataSource {
    
    fileprivate struct TableViewCellIdentifiers {
        static let actionCell = "actionCell"
        static let cancelCell = "cancelCell"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if cancelAction != nil {
            return 2
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return 1
        }
        return actions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.cancelCell, for: indexPath) as! RPMActionTableViewCell
            cell.configureCell(cancelAction)
            return cell
        }
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.actionCell, for: indexPath) as! RPMActionTableViewCell
        let action = actions[indexPath.row]
        cell.configureCell(action)
        
        // reset in case cell is reused
        cell.hairlineView.isHidden = false
        if indexPath.row == 0 {
            cell.hairlineView.isHidden = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 1 {
            selectedAction = cancelAction
        } else {
            selectedAction = actions[indexPath.row]
        }
        
        close()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return 60
        }
        
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.clipsToBounds = false
        if indexPath.section == 1 { // Rounds all corners of cancel action
            cell.layer.cornerRadius = 10
        } else {
            if indexPath.row == 0 {  // Rounds top corners of top action
                cell.roundCorners(corners: [.topLeft, .topRight], radius: 10)
                
            } else if indexPath.row == actions.count - 1 { // Rounds bottom corners of bottom action
                cell.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 10)
            }
        }
        
    }
}

//MARK: - Presenting Delegates

extension RPMActionSheetViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return DimmingPresentationController(presentedViewController: presented, presenting: presenting)
    }
}

extension RPMActionSheetViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return (touch.view === self.view)
    }
}
