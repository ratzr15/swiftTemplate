//
//  DLParseManager.swift
//  FirstSwift
//
//  Created by Rathish on 08/12/15.
//  Copyright © 2015 DubaiLandDept. All rights reserved.
//

import Foundation

protocol DLParserManagerDelegate {
    
    /*!
    *	breif	:	service called has returned with failure
    *	param	:	[in] - NSError*     , error info return by the service
    *          :	[in] - NSString*    , message associated with the error
    *  retun   :   void
    *  dated   :   7th Dec 2015
    *  author  :   rathish_citys@eres.com
    */
    func syncServiceFailedWithErrorCode (error:String, forTag:NSInteger)
    
    /*!
    *	breif	:	service called has returned with image byte data
    *	param	:	[in] NSDictionary * - response dict.
    *          :   [in] NSInteger  - tag value
    *  retun   :   void
    *  dated   :   7th Dec 2015.
    *  author  :   rathish_citys@eres.com
    */
    func syncServiceFinished (response: NSDictionary, forTag:NSInteger)
}


class DLParserManager : SyncServiceManagerDelegate{
    
    var delegate : DLParserManagerDelegate?
    let dataModel = DLDataModel?()
    var arrData   = NSArray()

    var syncServiceManager = DLSyncServiceManager?()

    
    func sharedInstance() -> DLSyncServiceManager {
        if ((syncServiceManager) == nil) {
            syncServiceManager = DLSyncServiceManager()
        }
        syncServiceManager!.delegate = self
        return syncServiceManager!
    }
    
    func hitSyncServiceToFetchData (url: String){
        syncServiceManager?.dlLibIntiateAsyncGETRequest(url, requestType: DLSyncConstants.DLRequestType.DLRequestDefault, tag: 1)
    }
    
    /************* SyncServiceDelegate- Callback Methods **************/
    
    
    func syncServiceFailedWithErrorCode(error: String, forTag: NSInteger) {
        print(error)
    }
    
    func syncServiceFinished(response: NSDictionary, forTag: NSInteger) {
        print(response)
        
        var arr = NSArray()
        arr = [response.objectForKey("Response")!]
        print(arr)
        
        libParseResponseToFormModels(arr, tag: forTag)
    }

     func checkForNULL(value: String) -> String {
        var strReturn: String
        if value.isKindOfClass(NSNull) {
            strReturn = ""
        }
        else {
            strReturn = value
        }
        return strReturn
    }
    
    func libParseResponseToFormModels(array:NSArray, tag:NSInteger){
        print(array)
        
        array.enumerateObjectsUsingBlock({ object, index, stop in
            let model = DLDataModel()
            model.name = (array.objectAtIndex(0).objectAtIndex(index).objectForKey("Service")?.objectForKey("NameEn") as! NSString)
            model.date = (array.objectAtIndex(0).objectAtIndex(index).objectForKey("Service")?.objectForKey("NameEn") as! NSString)
            
            
            print(model.name)
        })
        
    }
    
    
    
    
    
    
}


