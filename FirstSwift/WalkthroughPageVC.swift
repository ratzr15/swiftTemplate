//
//  WalkthroughPageVC.swift
//  ERESTemplate
//
//  Created by Rathish on 20/12/15.
//  Copyright © 2015 DubaiLandDept. All rights reserved.
//

import Foundation
import UIKit

class WalkthroughPageVC: UIPageViewController, UIPageViewControllerDataSource {
    
    var pageHeadings = ["Personalize", "Locate", "Discover"]
    var pageImages = ["foodpin-intro-1", "foodpin-intro-2", "foodpin-intro-3"]
    var pageContent =
    ["Pin your favorite restaurants and create your own food guide","Search and locate your favourite restaurant on Maps","Find restaurants"];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the data source to itself
        dataSource = self
        // Create the first walkthrough screen
        if let startingViewController = viewControllerAtIndex(0) {
        setViewControllers([startingViewController], direction: .Forward, animated: true, completion: nil)
        }
    }
    
    func viewControllerAtIndex(index: Int) -> WalkthroughContainerVC? {
        if index == NSNotFound || index < 0 || index >= pageHeadings.count {
        return nil
        }
        // Create a new view controller and pass suitable data.
        if let pageContentViewController =
        storyboard?.instantiateViewControllerWithIdentifier("WalkthroughContainer")
        as? WalkthroughContainerVC {
        pageContentViewController.imageFile = pageImages[index]
        pageContentViewController.heading = pageHeadings[index]
        pageContentViewController.content = pageContent[index]
        pageContentViewController.index = index
        return pageContentViewController
        }
        return nil
    }
    
    func forward(index:Int) {
            if let nextViewController = viewControllerAtIndex(index + 1) {
            setViewControllers([nextViewController], direction: .Forward, animated:
            true, completion: nil)
            }
    }
    
    /************* UIPageViewControllerDataSource *************/
    
    func pageViewController(pageViewController: UIPageViewController,
        viewControllerAfterViewController viewController: UIViewController) ->
        UIViewController? {
        var index = (viewController as! WalkthroughContainerVC).index
        index++
        return viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController,
        viewControllerBeforeViewController viewController: UIViewController) ->
        UIViewController? {
        var index = (viewController as! WalkthroughContainerVC).index
        index--
        return viewControllerAtIndex(index)
    }
    
    /************* UIPageViewControllerDelegate *************/
    
  /*  func presentationCountForPageViewController(pageViewController:
        UIPageViewController) -> Int {
        return pageHeadings.count
    }
    
    func presentationIndexForPageViewController(pageViewController:
            UIPageViewController) -> Int {
            if let pageContentViewController =
            storyboard?.instantiateViewControllerWithIdentifier("WalkthroughContainer")
            as? WalkthroughContainerVC {
            return pageContentViewController.index
            }
            return 0
    }*/
    
    
    
    
    
    
}