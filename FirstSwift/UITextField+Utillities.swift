//
//  UITextField+Utillities.swift
//  ERESTemplate
//
//  Created by Rathish on 13/12/15.
//  Copyright © 2015 DubaiLandDept. All rights reserved.
//

import Foundation

import UIKit

extension UITextField{
    
    /*
    *  breif   :   Its used to Make the Normal textField As per the design
    *  dated   :   1/28/14.
    *  author  :   rathish_citys@eres.ae
    */
    
    
    
     func configureTextField (){
    
        self.textColor = RTUtilityClass.colorFromHex("");
        self.backgroundColor = RTUtilityClass.colorFromHex("");
        self.userInteractionEnabled = true
        
        
            }
    
}