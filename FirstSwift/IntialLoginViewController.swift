//
//  SecondViewController.swift
//  FirstSwift
//
//  Created by Rathish on 06/12/15.
//  Copyright © 2015 DubaiLandDept. All rights reserved.
//

import Foundation
import UIKit


class IntialLoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = RTUtilityClass.colorFromHex("#FFC400");        
        self.navigationController?.setNavigationTitle("Login")

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let hasViewedWalkthrough = defaults.boolForKey("hasViewedWalkthrough")
        
        if hasViewedWalkthrough {
            return
        }
        
        if let pageViewController =
            storyboard?.instantiateViewControllerWithIdentifier("WalkthroughController")
                as? WalkthroughPageVC {
            presentViewController(pageViewController, animated: true, completion: nil)
        }
    }

}