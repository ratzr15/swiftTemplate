//
//  UINavigationController+DLNavCategory.swift
//  FirstSwift
//
//  Created by Rathish on 06/12/15.
//  Copyright © 2015 DubaiLandDept. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
    
    /*!
    *	breif	:	setLeftNavBarBtn - Sets up navigation button -left/right with specified image
    *	param	:	[UIImage] - selecteddimg*     , img when button is pressed
    *          :	[UIImage] - image*    , target img
    *  retun   :   void
    *  dated   :   7th Dec 2015
    *  author  :   rathish_citys@eres.com
    */

    func setLeftNavBarBtn (image:UIImage, selctedImage:UIImage, atTarget:AnyObject, action:Selector, interaction:Bool){
        let button = UIButton(type: UIButtonType.Custom)
        button.userInteractionEnabled = true;
        button.setBackgroundImage(image, forState: UIControlState.Normal)
        button.setBackgroundImage(image, forState: UIControlState.Selected)
        button.frame = CGRectMake(0, 0,  image.size.width,  image.size.width)
        button .addTarget(atTarget, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        self.topViewController?.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
             
}
    
    func setNavigationTitle (title: String){
        self.title = title
        let font: UIFont = UIFont(name: "Helvetica", size: 22)!
        self.navigationBar.titleTextAttributes = [NSFontAttributeName: font, NSForegroundColorAttributeName: RTUtilityClass.colorFromHex("#246296")]
        self.navigationBar.translucent = true
        setupLeftMenuButton()
        
        func getColorFromHex(rgbValue:UInt32)->UIColor{
            let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
            let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
            let blue = CGFloat(rgbValue & 0xFF)/256.0
            return UIColor(red:red, green:green, blue:blue, alpha:1.0)
        }
        
        self.navigationBar.tintColor = getColorFromHex(0xFFC400)
        self.navigationBar.barTintColor = getColorFromHex(0xFFC400)
        
        let menu = UIImage(imageLiteral: "menu-icon")
        self.setLeftNavBarBtn(menu, selctedImage: menu, atTarget: self, action:#selector(leftDrawerButtonPress(_:)) , interaction: true)
        
    }

    func setupLeftMenuButton() {
        let leftDrawerButton = MMDrawerBarButtonItem(target: self, action: #selector(leftDrawerButtonPress(_:)))
        self.navigationItem.setLeftBarButtonItem(leftDrawerButton, animated: true)
    }
    
    func setupRightMenuButton() {
        let rightDrawerButton = MMDrawerBarButtonItem(target: self, action: #selector(rightDrawerButtonPress(_:)))
        self.navigationItem.setRightBarButtonItem(rightDrawerButton, animated: true)
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


}