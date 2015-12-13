//
//  RTUtilityClass.swift
//  ERESTemplate
//
//  Created by Eres on 12/10/15.
//  Copyright © 2015 DubaiLandDept. All rights reserved.
//

import UIKit
import Foundation


class RTUtilityClass: NSObject {
    static let sharedInstance = RTUtilityClass()
    
   class  func colorFromHex(hexString:String) -> UIColor{
        var rgb: UInt32 = 0
        let scanner = NSScanner(string: hexString)
        scanner.scanLocation = 1;
        scanner.scanHexInt(&rgb)
        return UIColor(red: CGFloat((rgb & 0xFF0000) >> 16)/255.0, green: CGFloat((rgb &   0xFF00) >>  8)/255.0, blue: CGFloat((rgb &     0xFF)      )/255.0, alpha: 1.0)

    }
    
    func colorFromIndex(index: Int) -> UIColor{
        var color:UIColor!
        
        //Purple
        if(index % 3 == 0){
            color = UIColor(red:0.93,green:0.01, blue:0.55, alpha:1.0)
        }//Blue
        else if(index % 3 == 1){
            color = UIColor(red:0.00,green:0.68, blue:0.94, alpha:1.0)
        }//Blk
        else if(index % 3 == 2){
            color = UIColor.blackColor()
        }
        else if(index % 3 == 3){
            color = UIColor(red:0.00,green:1.0, blue:0.94, alpha:1.0)
        }
        
        return color
        
    }
    
    func colorFromHex(hexString:String,alpha:CGFloat) -> UIColor{
        var rgb: UInt32 = 0
        let scanner = NSScanner(string: hexString)
        if(hexString.characters.count > 0){
            scanner.scanLocation = 1;
        }
        scanner.scanHexInt(&rgb)
        
        return UIColor(red: CGFloat((rgb & 0xFF0000) >> 16)/255.0, green: CGFloat((rgb &   0xFF00) >>  8)/255.0, blue: CGFloat((rgb &     0xFF)      )/255.0, alpha: alpha)
    }
    
    //labelCreation
    func createLbl() -> UILabel {
        let label = UILabel()
        label.backgroundColor = UIColor.clearColor()
        label.numberOfLines = 0;
        return label
    }
    
    func adjustLabel(labelToConvert:UILabel,labelText:String,fontName:String,fontSize:Int,textColor:UIColor) -> UILabel{
        let strAttr = NSAttributedString(string: labelText)
        labelToConvert.attributedText = strAttr
        labelToConvert.textColor = textColor
        labelToConvert.sizeToFit()
        let rect:CGRect = strAttr.boundingRectWithSize(CGSize(width: 220, height: 44), options: NSStringDrawingOptions.UsesLineFragmentOrigin, context: nil)
        var frame:CGRect = labelToConvert.frame
        frame.size.width = rect.size.width
        frame.size.height = rect.size.height
        frame.origin.x = 100
        
        labelToConvert.frame = frame
        return labelToConvert

    }
    
    class func isUserUsingAnIpad() -> Bool {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.Pad) {
            return true
        } else {
            return false
        }
    }

}
