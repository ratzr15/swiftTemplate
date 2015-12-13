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
    

}