//
//  Reachability.swift
//  FirstSwift
//
//  Created by Rathish on 07/12/15.
//  Copyright © 2015 DubaiLandDept. All rights reserved.
//

import Foundation
import SystemConfiguration

public class Reachability {
    
    
    /*!
    *  breif	:	 To chceck if connected to internet
    *  retun    :    Yes/ No
    *  dated    :    7th Dec 2015.
    *  author   :    rathish_citys@eres.com
    */

    class func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(&zeroAddress) {
            SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, UnsafePointer($0))
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        let isReachable = flags == .Reachable
        let needsConnection = flags == .ConnectionRequired
        
        return isReachable && !needsConnection
        
        
    }
}


/*!
*	breif	:	 Use rechablity class to check for internet
*  retun    :    Yes/ No
*  dated    :    7th Dec 2015.
*  author   :    rathish_citys@eres.com
*/


/*
if Reachability.isConnectedToNetwork() == true {
    println("Internet connection OK")
} else {
    println("Internet connection FAILED")
}*/