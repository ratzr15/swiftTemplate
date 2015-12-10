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
        view.backgroundColor = UIColor.orangeColor()
        setNavigationTitle("Swift Me !!")

        let VCIDs : [String] = ["SecondViewController", "DetailsViewController"]
        let buttonTitles : [String] = ["Home", "Places"]
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
            self.performSegueWithIdentifier("SecondVC", sender: self)
        }
        alertController.addAction(OKAction)
      
    }
    
    func setupLeftMenuButton() {
        let leftDrawerButton = MMDrawerBarButtonItem(target: self, action: "leftDrawerButtonPress:")
        self.navigationItem.setLeftBarButtonItem(leftDrawerButton, animated: true)
    }
    
    func setupRightMenuButton() {
        let rightDrawerButton = MMDrawerBarButtonItem(target: self, action: "rightDrawerButtonPress:")
        self.navigationItem.setRightBarButtonItem(rightDrawerButton, animated: true)
    }
    
    
    func setNavigationTitle (title: String){
        self.title = title
        let font: UIFont = UIFont(name: "Helvetica", size: 18)!
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: font, NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.translucent = false
        setupLeftMenuButton()
    
        let menu = UIImage(imageLiteral: "menu-icon")
        self.navigationController!.setLeftNavBarBtn(menu, selctedImage: menu, atTarget: self, action:"leftDrawerButtonPress:" , interaction: true)

    }
    
    // MARK: - Button Handlers
    
    func leftDrawerButtonPress(sender: AnyObject?) {
        self.mm_drawerController?.toggleDrawerSide(.Left, animated: true, completion: nil)
    }
    
    func rightDrawerButtonPress(sender: AnyObject?) {
        self.mm_drawerController?.toggleDrawerSide(.Right, animated: true, completion: nil)
    }
    
    func doubleTap(gesture: UITapGestureRecognizer) {
        self.mm_drawerController?.bouncePreviewForDrawerSide(.Left, completion: nil)
    }
    
    func twoFingerDoubleTap(gesture: UITapGestureRecognizer) {
        self.mm_drawerController?.bouncePreviewForDrawerSide(.Right, completion: nil)
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "SecondVC"){
            _ = segue.destinationViewController as! SecondViewController
        }
    }
}

