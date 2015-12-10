//
//  AppDelegate.swift
//  FirstSwift
//
//  Created by Rathish on 05/12/15.
//  Copyright © 2015 DubaiLandDept. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UINavigationControllerDelegate {

    var window: UIWindow?
    var centerContainer: MMDrawerController?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        /**/
        /*!
        *	breif	:	formatDate - formats date as per requirement
        *	param	:	[NSString] - dateString*, date to be converted
        *          :	[NSString] - format*    , expected date format
        *  retun   :   void
        *  dated   :   7th Dec 2015
        *  author  :   rathish_citys@eres.com
        */
        func setUpMMDC(){
            _ = self.window!.rootViewController
            
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            
            let centerViewController = mainStoryboard.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
            let leftViewController = mainStoryboard.instantiateViewControllerWithIdentifier("SideMenuVC") as! SideMenuViewController
            let rightViewController = mainStoryboard.instantiateViewControllerWithIdentifier("SideMenuVC") as! SideMenuViewController
            
            let leftSideNav = UINavigationController(rootViewController: leftViewController)
            let centerNav = UINavigationController(rootViewController: centerViewController)
            _ = UINavigationController(rootViewController: rightViewController)
            
            centerContainer = MMDrawerController(centerViewController: centerNav, leftDrawerViewController: leftSideNav,rightDrawerViewController:nil)
            centerContainer!.openDrawerGestureModeMask = MMOpenDrawerGestureMode.All;
            centerContainer!.closeDrawerGestureModeMask = MMCloseDrawerGestureMode.All;
            
            window!.rootViewController = centerContainer
            window!.makeKeyAndVisible()
        }
        
        setUpMMDC()
        
        //UnComment below if Nav Bar properties required in all views
        
       /* func getColorFromHex(rgbValue:UInt32)->UIColor{
            let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
            let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
            let blue = CGFloat(rgbValue & 0xFF)/256.0
            return UIColor(red:red, green:green, blue:blue, alpha:1.0)
        }
        
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.tintColor = UIColor.clearColor()
        navigationBarAppearace.barTintColor = UIColor.clearColor()*/
        
        return true
    }
  
    func application(application: UIApplication, viewControllerWithRestorationIdentifierPath identifierComponents: [AnyObject], coder: NSCoder) -> UIViewController? {
        if let key = identifierComponents.last as? String {
            if key == "Drawer" {
                return self.window?.rootViewController
            } else if key == "ExampleCenterNavigationControllerRestorationKey" {
                return (self.window?.rootViewController as! MMDrawerController).centerViewController
            } else if key == "ExampleRightNavigationControllerRestorationKey" {
                return (self.window?.rootViewController as! MMDrawerController).rightDrawerViewController
            } else if key == "ExampleLeftNavigationControllerRestorationKey" {
                return (self.window?.rootViewController as! MMDrawerController).leftDrawerViewController
            } else if key == "ExampleLeftSideDrawerController" {
                if let leftVC = (self.window?.rootViewController as? MMDrawerController
                    )?.leftDrawerViewController {
                    if leftVC.isKindOfClass(UINavigationController) {
                        return (leftVC as! UINavigationController).topViewController
                    } else {
                        return leftVC
                    }
                }
            } else if key == "ExampleRightSideDrawerController" {
                if let rightVC = (self.window?.rootViewController as? MMDrawerController)?.rightDrawerViewController {
                    if rightVC.isKindOfClass(UINavigationController) {
                        return (rightVC as! UINavigationController).topViewController
                    } else {
                        return rightVC
                    }
                }
            }
        }
        
        return nil
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

