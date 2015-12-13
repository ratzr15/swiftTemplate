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
    *  breif   :   Make the Default textField As per the design
    *  dated   :   1/28/14.
    *  author  :   rathish_citys@eres.ae
    */
    func configureTextField (){
        self.textColor = RTUtilityClass.colorFromHex("");
        self.backgroundColor = RTUtilityClass.colorFromHex("");
        self.userInteractionEnabled = true
        
        //Left Padding view
        let paddingView = UIView?()
        
        if  (paddingView == nil) {
            if RTUtilityClass.isUserUsingAnIpad(){
                paddingView?.frame = CGRectMake(0, 0, 12, 44)
            }else{
                if isArabic{
                    paddingView?.frame = CGRectMake(0, 0, 33, 44)
                }
                else{
                    paddingView?.frame = CGRectMake(0, 0, 12, 44)
                }
            }
        }
        self.leftView=paddingView;
        self.leftViewMode = UITextFieldViewMode.Always;
        
        if isArabic{
            self.textAlignment = NSTextAlignment.Right
        }else{
            self.textAlignment = NSTextAlignment.Left
        }
        
        //Right Padding view
        let rightPaddingView = UIView?()
        
        if  (rightPaddingView == nil) {
            if RTUtilityClass.isUserUsingAnIpad(){
                rightPaddingView?.frame = CGRectMake(0, 0, 40, 44)
            }else{
                if isArabic{
                    rightPaddingView?.frame = CGRectMake(0, 0, 12, 44)
                }
                else{
                    rightPaddingView?.frame = CGRectMake(0, 0, 22, 44)
                }
            }
        }
        self.rightView=rightPaddingView;
        self.rightViewMode = UITextFieldViewMode.Always;
        self.autocorrectionType = UITextAutocorrectionType.No;
    }
    
    /*
    *  breif   :   Its used to Make the Normal textField As per the design - with placeholder text
    *  dated   :   1/28/14.
    *  author  :   rathish_citys@eres.ae
    */
    func configureTextFieldWithPlaceholder (placeholder: String) (){
        self.textColor = RTUtilityClass.colorFromHex("");
        self.backgroundColor = RTUtilityClass.colorFromHex("");
        self.userInteractionEnabled = true
        
        let str: NSAttributedString = NSAttributedString(string: placeholder, attributes: [NSForegroundColorAttributeName: RTUtilityClass.colorFromHex(kTextColor)])
        self.attributedPlaceholder = str
        
        //Left Padding view
        let paddingView = UIView?()
        
        if  (paddingView == nil) {
            if RTUtilityClass.isUserUsingAnIpad(){
                paddingView?.frame = CGRectMake(0, 0, 12, 44)
            }else{
                if isArabic{
                    paddingView?.frame = CGRectMake(0, 0, 33, 44)
                }
                else{
                    paddingView?.frame = CGRectMake(0, 0, 12, 44)
                }
            }
        }
        self.leftView=paddingView;
        self.leftViewMode = UITextFieldViewMode.Always;
        
        if isArabic{
            self.textAlignment = NSTextAlignment.Right
        }else{
            self.textAlignment = NSTextAlignment.Left
        }
        
        //Right Padding view
        let rightPaddingView = UIView?()
        
        if  (rightPaddingView == nil) {
            if RTUtilityClass.isUserUsingAnIpad(){
                rightPaddingView?.frame = CGRectMake(0, 0, 40, 44)
            }else{
                if isArabic{
                    rightPaddingView?.frame = CGRectMake(0, 0, 12, 44)
                }
                else{
                    rightPaddingView?.frame = CGRectMake(0, 0, 22, 44)
                }
            }
        }
        self.rightView=rightPaddingView;
        self.rightViewMode = UITextFieldViewMode.Always;
        self.autocorrectionType = UITextAutocorrectionType.No;
    }
    
    /*
    *  func    :   formatAndValidateUAEMobNo
    *  breif   :   Formats and validates the inputted mobile number with proper format(12 digits)
    *  usage   :   1.Call this methods UITextField - Should change characters in range to validate and format number
               :   2. Can also be used to return formatted number as standalone function
    *  dated   :   13/12/15
    *  author  :   rathish_citys@eres.ae
    */
    func formatAndValidateUAEMobNo(var mobileNumber: NSString, var showAlert wrong: Bool) -> String {
        wrong = false
        
        var arrMobInitials = NSArray()
        arrMobInitials = ["59", "50", "51", "52", "55", "56", "70"]
        
        mobileNumber = mobileNumber.stringByReplacingOccurrencesOfString("00", withString: "")
        mobileNumber = mobileNumber.stringByReplacingOccurrencesOfString(")", withString: "")
        mobileNumber = mobileNumber.stringByReplacingOccurrencesOfString(" ", withString: "")
        mobileNumber = mobileNumber.stringByReplacingOccurrencesOfString("-", withString: "")
        mobileNumber = mobileNumber.stringByReplacingOccurrencesOfString("+", withString: "")
        
        let length: Int = mobileNumber.length
        
        if length == 12 {
            let countryCode: String = mobileNumber.substringToIndex(3).stringByReplacingOccurrencesOfString("00", withString: "")
            let phoneNo: String = mobileNumber.substringFromIndex(3)
            mobileNumber = "\(countryCode)\(phoneNo)"
            return mobileNumber as String
        }
        else {
            if length == 10 {
                let zero: String = mobileNumber.substringToIndex(1)
                let intials: NSString = mobileNumber.substringToIndex(3)
                let tmpMobNo: NSString = mobileNumber as String
                for var i = 0; i < arrMobInitials.count; i++ {
                    if (zero == "0") && (intials.substringFromIndex(1) == arrMobInitials[i] as! String) {
                        mobileNumber = "\("971")\(tmpMobNo.substringFromIndex(length - 9))"
                        return mobileNumber as String
                    }
                    else {
                        wrong = true
                    }
                }
            }
            else {
                if length == 9 {
                    let zero: String = mobileNumber.substringToIndex(1)
                    if (zero != "0"){
                        let intials: NSString = mobileNumber.substringToIndex(2)
                        let tmpMobNo: NSString = mobileNumber as String
                        for var i = 0; i < arrMobInitials.count; i++ {
                            if (intials == arrMobInitials[i] as! String) {
                                mobileNumber = "\("971")\(tmpMobNo.substringFromIndex(length - 9))"
                                return mobileNumber as String
                            }
                            else {
                                wrong = true
                            }
                        }
                    }else{
                        wrong = true
                    }
                }
                else {
                    wrong = true
                }
            }
        }
        /* When above validations fail : return null and display error msg */
        if wrong {
            mobileNumber = ""
            print("Worng number format!")
        }
        return mobileNumber as String
    }
    
    /*
    *  func    :   formatAndValidateMobNo
    *  breif   :   Formats and validates the inputted mobile number with proper format(12 digits)
    *  usage   :   1.Call this methods UITextField - Should change characters in range to validate and format number
               :   2. Can also be used to return formatted number as standalone function
    *  dated   :   13/12/15
    *  author  :   rathish_citys@eres.ae
    */
    
    func formatAndValidateMobNo(var mobileNumber: NSString, var showAlert wrong: Bool) -> String {
        wrong = false
        mobileNumber = mobileNumber.stringByReplacingOccurrencesOfString("00", withString: "")
        mobileNumber = mobileNumber.stringByReplacingOccurrencesOfString(")", withString: "")
        mobileNumber = mobileNumber.stringByReplacingOccurrencesOfString(" ", withString: "")
        mobileNumber = mobileNumber.stringByReplacingOccurrencesOfString("-", withString: "")
        mobileNumber = mobileNumber.stringByReplacingOccurrencesOfString("+", withString: "")
        
        let length: Int = mobileNumber.length
        
        if length == 12 {
            let countryCode: NSString = mobileNumber.substringToIndex(3).stringByReplacingOccurrencesOfString("00", withString: "")
            let phoneNo: NSString = mobileNumber.substringFromIndex(3)
            mobileNumber = "\(countryCode)\(phoneNo)"
            return mobileNumber as String
        }
        else {
            if length == 10 {
                mobileNumber = "\("971")\(mobileNumber.substringFromIndex(length - 9))"
                // Replace country code
                return mobileNumber as String
            }
            else {
                if length == 9 {
                    let zero: String = mobileNumber.substringToIndex(1)
                    if (zero != "0"){
                        mobileNumber = "\("971")\(mobileNumber.substringFromIndex(length - 9))"
                        return mobileNumber as String
                    }
                }
                else {
                    wrong = true
                }
            }
        }
        /* When above validations fail : return null and display error msg */
        if wrong {
            mobileNumber = ""
            wrong = true
        }
        return mobileNumber as String
    }
    
}

    