//
//  ViewController.swift
//  FirstSwift
//
//  Created by Rathish on 05/12/15.
//  Copyright © 2015 DubaiLandDept. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()        
        view.backgroundColor = UIColor.orangeColor()
        setNavigationTitle("Swift !!")
        
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
            self.performSegueWithIdentifier("SecondVC", sender: self)
        }
        alertController.addAction(OKAction)
      
    }
    
    func setNavigationTitle (title: String){
        self.title = title
        let font: UIFont = UIFont(name: "Helvetica", size: 18)!
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: font, NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.translucent = false
        
        let homeBtn: UIImage! = UIImage(named: "arrow-list-item-en")!
        let imgLeft = UIImage(imageLiteral: "arrow-list-item-ar")
        self.navigationController!.setLeftNavBarBtn(imgLeft, selctedImage: homeBtn, atTarget: self, action: nil, interaction: true)
        

    }
    

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "SecondVC"){
            _ = segue.destinationViewController as! SecondViewController
        }
    }
}

