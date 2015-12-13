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
        
        //setNavigationTitle("Swift Me !!")
        
    }

    @IBAction func actionSignUp(sender: AnyObject) {
        self.performSegueWithIdentifier("DetailsVC", sender: self)
        
        let parserManager = DLParserManager()
        parserManager.sharedInstance()
        
        isArabic.isTrue
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "DetailsVC"){
            let nav = segue.destinationViewController as! DetailsViewController
            nav.viewDidLoad()
        }
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
    
    
}