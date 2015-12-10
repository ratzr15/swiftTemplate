//
//  DLUserDefault.swift
//  ERESTemplate
//
//  Created by Eres on 12/10/15.
//  Copyright © 2015 DubaiLandDept. All rights reserved.
//

import UIKit
import Foundation


class DLUserDefault: NSObject {
    let defaults = NSUserDefaults.standardUserDefaults()
    
    //--------------------------------------------------------------------------------------------------
    //	Function Name	:	UserDefaultsInstance:
    //	Description		:	class level function for create shared instance - Definition
    //  param           :	none
    //	return			:	none
    //-------------------------------------------------------------------------------------------------
    static let sharedInstance = DLUserDefault()

    
    func stringForKey(key: String) -> String?{
        return defaults.stringForKey(key)
    }
    
    //--------------------------------------------------------------------------------------------------
    //	Function Name	:	getObjectValue:
    //	Description		:	calls to get String value from user defaults - Definition
    //  param           :	[in] - String * - key name
    //	return			:	AnyObject
    //-------------------------------------------------------------------------------------------------
    func getObjectValue(key: String) -> AnyObject?{
        return defaults.objectForKey(key)
    }
    
    //--------------------------------------------------------------------------------------------------
    //	Function Name	:	setObjectKey: value:
    //	Description		:	calls to set AnyObject key value in user defaults - Definition
    //	param           :	[in] - AnyObject * - Key name
    //	param           :	[in] - String  - key value
    //-------------------------------------------------------------------------------------------------
    func setObjectKey(value: AnyObject?, forKey key: String){
        defaults.setValue(value, forKey: key)
        defaults.synchronize()
    }
    
    //--------------------------------------------------------------------------------------------------
    //	Function Name	:	getBoolValue:
    //	Description		:	calls to get bool value from user defaults - Definition
    //  param           :	[in] - String * - key value
    //	return			:	BOOL
    //-------------------------------------------------------------------------------------------------
    func getBoolValue(key: String) -> Bool {
        return defaults.boolForKey(key)
    }
    
    //--------------------------------------------------------------------------------------------------
    //	Function Name	:	setBoolValue: value:
    //	Description		:	calls to set bool key value in user defaults - Definition
    //	param           :	[in] - String * - Key name
    //	param           :	[in] - BOOL  - bool value
    //-------------------------------------------------------------------------------------------------
    func setBoolValue(value: Bool?, forKey key: String){
        defaults.setValue(value, forKey: key)
        defaults.synchronize()
    }
    
    //--------------------------------------------------------------------------------------------------
    //	Function Name	:	getIntegerValue:
    //	Description		:	calls to get int value from user defaults - definition
    //	param           :	[in] - String * - key name
    //	return			:	NSInteger
    //-------------------------------------------------------------------------------------------------
    func getIntegerValue(key: String) -> NSInteger {
        return defaults.integerForKey(key)
    }
    
    //--------------------------------------------------------------------------------------------------
    //	Function Name	:	setIntegerValue: value:
    //	Description		:	calls to set interger key value in user defaults - Definiton
    //	param           :	[in] - String * - Key name
    //	param           :	[in] - NSInteger  - int value
    //-------------------------------------------------------------------------------------------------
    func setIntegerValue(value: NSInteger, forKey key: String) {
        defaults.setInteger(value, forKey: key)
        defaults.synchronize()
    }
    
    //--------------------------------------------------------------------------------------------------
    //	Function Name	:	removeObjectForKey:
    //	Description		:	calls to remove key value from user defaults - Definition
    //	param			:	[in] - String * - specific key name
    //-------------------------------------------------------------------------------------------------
    func removeObjectForKey(key: String){
        defaults.removeObjectForKey(key)
        defaults.synchronize()
    }
    
    //--------------------------------------------------------------------------------------------------
    //	Function Name	:	setDictObjectValue:
    //	Description		:	calls to set value for login user
    //	param			:	[in] - String * - specific key name
   //   param			:	[in] - [NSObject : AnyObject] * - value
    //-------------------------------------------------------------------------------------------------
    func setDictObjectValue(value: [NSObject : AnyObject] , forKey key: String){
        defaults.setValue(value, forKey: key)
        defaults.synchronize()
    }
    
}
