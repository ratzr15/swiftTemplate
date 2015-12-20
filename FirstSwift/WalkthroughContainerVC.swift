//
//  WalkthroughContainerVC.swift
//  ERESTemplate
//
//  Created by Rathish on 20/12/15.
//  Copyright © 2015 DubaiLandDept. All rights reserved.
//

import Foundation
import UIKit

class WalkthroughContainerVC: UIViewController{
    
    @IBOutlet weak var imgViewContent: UIImageView!
    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var lblSubHeading: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var btnNext: UIButton!
    
    var index = 0
    var heading = ""
    var imageFile = ""
    var content = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblHeading.text = heading
        lblSubHeading.text = content
        imgViewContent.image = UIImage(imageLiteral:imageFile)
        pageControl.currentPage = index
        
        if case 0...1 = index {
            btnNext.setTitle("NEXT", forState: UIControlState.Normal)
        } else if case 2 = index {
            btnNext.setTitle("DONE", forState: UIControlState.Normal)
        }
    }
    
    @IBAction func nextButtonAction(sender: UIButton) {
            switch index {
        case 0...1:
            let pageViewController = parentViewController as!WalkthroughPageVC
        pageViewController.forward(index)
            
        case 2:
                let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(true, forKey: "hasViewedWalkthrough")
        dismissViewControllerAnimated(true, completion: nil)
            
        default: break
            }
    }
    
}