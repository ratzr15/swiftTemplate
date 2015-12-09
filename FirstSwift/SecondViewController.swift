//
//  SecondViewController.swift
//  FirstSwift
//
//  Created by Rathish on 06/12/15.
//  Copyright © 2015 DubaiLandDept. All rights reserved.
//

import Foundation
import UIKit


class SecondViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.redColor()
        
    }
    
    
    
    @IBAction func actionSignUp(sender: AnyObject) {
        self.performSegueWithIdentifier("DetailsVC", sender: self)
        
        let parserManager = DLParserManager()
        parserManager.sharedInstance()
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "DetailsVC"){
            let nav = segue.destinationViewController as! DetailsViewController
            nav.viewDidLoad()
        }
    }
}