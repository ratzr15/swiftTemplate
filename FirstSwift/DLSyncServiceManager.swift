//
//  DLSyncServiceManager.swift
//  FirstSwift
//
//  Created by Rathish on 07/12/15.
//  Copyright © 2015 DubaiLandDept. All rights reserved.
//

import Foundation


protocol SyncServiceManagerDelegate {
    
    /*!
    *	breif	:	service called has returned with failure
    *	param	:	[in] - NSError*     , error info return by the service
    *          :	[in] - NSString*    , message associated with the error
    *  retun   :   void
    *  dated   :   7th July 2015
    *  author  :   rathish_citys@eres.com
    */
    func syncServiceFailedWithErrorCode (error:String, forTag:NSInteger)
    
    /*!
    *	breif	:	service called has returned with image byte data
    *	param	:	[in] NSDictionary * - response dict.
    *          :   [in] NSInteger  - tag value
    *  retun   :   void
    *  dated   :   7th July 2015.
    *  author  :   rathish_citys@eres.com
    */
    func syncServiceFinished (response: NSDictionary, forTag:NSInteger)
}


class DLSyncServiceManager {
    
    var delegate: SyncServiceManagerDelegate?
    
    //--------------------------------------------------------------------------------------------------
    //	Function Name	:	initiateAsyncGetRequest:isSecure:tag:
    //	Description		:   initiate asynchronous web service get request
    //	param			:	[in] NSString* service parameters
    //                  :   [in] DLRequestType - enum for type of request(ex: html, pdf, etc...)
    //                  :   [in] NSInteger - tag value
    //	return			:	void
    //--------------------------------------------------------------------------------------------------
    
    func dlLibIntiateAsyncGETRequest (params: String, requestType:DLSyncConstants.DLRequestType, tag: NSInteger){
        print(params)
        
        let strURL:String = params.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        let request = NSMutableURLRequest()
        request.HTTPMethod = "GET"
        request.URL = NSURL(string: strURL)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 20.0
        
        if Reachability.isConnectedToNetwork(){
            let config = NSURLSessionConfiguration.defaultSessionConfiguration()
            let session = NSURLSession(configuration: config)
            
            func handler (data: NSData!, response: NSURLResponse!, error: NSError!) {
                
            }
            
            var jsonObject = AnyObject?()
            
            
            let task : NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler: {(let data , response, error) in
                
                if data == nil{
                    self.delegate!.syncServiceFailedWithErrorCode("Data is not availabe", forTag: 1)
                }else{
                    do {
                        jsonObject = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as! [String:AnyObject]
                    } catch {
                        print("json error: \(error)")
                    }
                }
                
                var dict = NSDictionary()
                
                /*if ((jsonObject?.isKindOfClass(NSArray)) != nil) {
                if let dataArray = jsonObject!["orders"] as? NSArray {
                print(dataArray)
                }
                
                }
                else {
                dict = (jsonObject)!as! NSDictionary
                NSLog("jsonDictionary - %@", dict)
                }*/
                
                dict = (jsonObject)!as! NSDictionary
                NSLog("jsonDictionary - %@", dict)
                
                let type = requestType
                
                switch type{
                case DLSyncConstants.DLRequestType(rawValue: 0)!:
                    
                    /* Delegate-Callback */
                    
                    if dict["Code"]?.integerValue != 0 {
                        self.delegate!.syncServiceFailedWithErrorCode("Data is not availabe", forTag: tag)
                    }else if(dict["Response"]!.isKindOfClass(NSNull) && dict["Response"]!.isKindOfClass(NSString)){
                        self.delegate!.syncServiceFailedWithErrorCode("Data is not availabe", forTag: tag)
                    }else if dict["Message"]!.isKindOfClass(NSNull) || (dict["Message"]! as! String == "An error has occured") {
                        self.delegate!.syncServiceFailedWithErrorCode("Data is not availabe", forTag: tag)
                    }else if dict.count == 1 {
                        self.delegate!.syncServiceFailedWithErrorCode("Data is not availabe", forTag: tag)
                    }else{
                        self.delegate!.syncServiceFinished(dict, forTag: tag)
                    }
                    print("Default Type !!")
                    
                case DLSyncConstants.DLRequestType(rawValue: 1)!:
                    self.delegate!.syncServiceFailedWithErrorCode("Data is not availabe", forTag: tag)
                    print("b")
                case DLSyncConstants.DLRequestType(rawValue: 2)!:
                    self.delegate!.syncServiceFailedWithErrorCode("Data is not availabe", forTag: tag)
                    print("c")
                case DLSyncConstants.DLRequestType(rawValue: 3)!:
                    self.delegate!.syncServiceFailedWithErrorCode("Data is not availabe", forTag: tag)
                    print("d")
                default:
                    print("d")
                }
                
                
            });
            
            task.resume()
            
            
        }
        
    }
    
    
    
}