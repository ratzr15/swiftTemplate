//
//  ViewController.swift
//  FirstSwift
//
//  Created by Rathish on 05/12/15.
//  Copyright © 2015 DubaiLandDept. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var swiftPagesViewController: SwiftPages!
    override func viewDidLoad() {
        super.viewDidLoad()        
        self.navigationController?.setNavigationTitle("Login")

        let VCIDs : [String] = ["DetailsViewController"]
        let buttonTitles : [String] = ["Places"]
        swiftPagesViewController.initializeWithVCIDsArrayAndButtonTitlesArray(VCIDs, buttonTitlesArray: buttonTitles)

        
    }
    @IBOutlet weak var btnPress: UIButton!

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func btnActions(sender: AnyObject) {
        
        let alertController = UIAlertController(title: "Alert", message: "Do you want to proceed ?", preferredStyle: .Alert)
        presentViewController(alertController, animated: true, completion: nil)
      
        let destroyAction = UIAlertAction(title: "No", style: .Cancel) { (action) in
            print(action)
        }
        alertController.addAction(destroyAction)
        
        let OKAction = UIAlertAction(title: "Yes", style: .Default) { (action) in
            self.performSegueWithIdentifier("IntialLoginViewController", sender: self)
        }
        alertController.addAction(OKAction)
      
    }
    
    
    @IBAction func actionSignUp(sender: AnyObject) {
        self.performSegueWithIdentifier("mainVC", sender: self)
        
        let parserManager = DLParserManager()
        parserManager.sharedInstance()
        
    }
    

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "DetailsVC"){
            _ = segue.destinationViewController as! DetailsViewController
        }
    }
}

