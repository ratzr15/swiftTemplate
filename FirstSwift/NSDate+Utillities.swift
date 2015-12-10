//
//  NSDate+Utillities.swift
//  ERESTemplate
//
//  Created by Rathish on 09/12/15.
//  Copyright © 2015 DubaiLandDept. All rights reserved.
//

import Foundation

import UIKit

extension NSDate {
   
    /*!
    *	breif	:	formatDate - formats date as per requirement
    *	param	:	[NSString] - dateString*, date to be converted
    *          :	[NSString] - format*    , expected date format
    *  retun   :   void
    *  dated   :   7th Dec 2015
    *  author  :   rathish_citys@eres.com
    */

    class func formatDate (dateString:NSString, format:NSString) ->NSString{
        let currentFormat = NSDateFormatter()
        currentFormat.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = currentFormat.dateFromString(dateString as String)
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = format as String
       return formatter.stringFromDate((date)!)
    }
    
}