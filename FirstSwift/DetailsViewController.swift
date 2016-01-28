//
//  DetailsViewController.swift
//  FirstSwift
//
//  Created by Rathish on 07/12/15.
//  Copyright © 2015 DubaiLandDept. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

let  ROOT_WEB_URL = "http://devmobile.dubailand.gov.ae:4000/tuo.Mobile.Server/api/tuo?CustomerId=10662&&custstartindex=0&custrowscounts=20"

class DetailsViewController: UIViewController, UITableViewDataSource,UITableViewDelegate, DLParserManagerDelegate, UISearchBarDelegate, CustomSearchControllerDelegate, PZPullToRefreshDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var arrData = NSMutableArray()
    let managerParser = DLParserManager()
    
    //Cloud
    var restaurants:[CKRecord] = []
    
    //Pull2Refresh
    var pull2Refresh: PZPullToRefreshView?
    
    // Search objects
    var dataArray = [String]()
    var filteredArray = [String]()
    var shouldShowSearchResults = false
    var searchController: UISearchController!
    var customSearchController: CustomSearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.redColor()
        
        //Automatic tvc height
        self.tableView.estimatedRowHeight = 120;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        
        //Setup Search - Bar
        configureCustomSearchController()
        
        //Pull2Refresh
        addPullToRefreshControl()
    }
    
    override func viewWillAppear(animated: Bool) {
        /*Service request Method
        invokeServiceToFetchData()*/
        
        //Invoke data fetch from cloud
        getRecordsFromCloud()
        
    }
    
    
    func configureCustomSearchController() {
        customSearchController = CustomSearchController(searchResultsController: self, searchBarFrame: CGRectMake(0.0, 0.0, tableView.frame.size.width, 50.0), searchBarFont: UIFont(name: "Futura", size: 16.0)!, searchBarTextColor: UIColor.orangeColor(), searchBarTintColor: UIColor.blackColor())
        
        customSearchController.customSearchBar.placeholder = "Search in this awesome bar..."
        tableView.tableHeaderView = customSearchController.customSearchBar
        
        customSearchController.customDelegate = self
    }
    
    // MARK: CustomSearchControllerDelegate functions
    
    func didStartSearching() {
        shouldShowSearchResults = true
        tableView.reloadData()
    }
    
    
    func didTapOnSearchButton() {
        if !shouldShowSearchResults {
            shouldShowSearchResults = true
            tableView.reloadData()
        }
    }
    
    func didTapOnCancelButton() {
        shouldShowSearchResults = false
        tableView.reloadData()
    }
    
    
    func didChangeSearchText(searchText: String) {
        // Filter the data array and get only those countries that match the search text.
        filteredArray = dataArray.filter({ (country) -> Bool in
            let countryText: NSString = country
            
            return (countryText.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch).location) != NSNotFound
        })
        
        // Reload the tableview.
        tableView.reloadData()
    }
    
    func addPullToRefreshControl(){
        if pull2Refresh == nil {
            let view = PZPullToRefreshView(frame: CGRectMake(0, 0 - tableView.bounds.size.height, tableView.bounds.size.width, tableView.bounds.size.height))
            view.delegate = self
            tableView.addSubview(view)
            pull2Refresh = view
        }
    }
    
    // MARK:UIScrollViewDelegate
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        pull2Refresh?.refreshScrollViewDidScroll(scrollView)
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        pull2Refresh?.refreshScrollViewDidEndDragging(scrollView)
    }
    
    // MARK:PZPullToRefreshDelegate
    
    func pullToRefreshDidTrigger(view: PZPullToRefreshView) -> () {
        pull2Refresh?.isLoading = true
        
        let delay = 3.0 * Double(NSEC_PER_SEC)
        let time  = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue(), {
            print("Complete loading!")
            self.pull2Refresh?.isLoading = false
            self.pull2Refresh?.refreshScrollViewDataSourceDidFinishedLoading(self.tableView)
            self.getRecordsFromCloud()
        })
    }
    
    func pullToRefreshLastUpdated(view: PZPullToRefreshView) -> NSDate {
        return NSDate()
    }

    
    // MARK: SyncServiceDelegate- Request Methods **************/
    
    func invokeServiceToFetchData(){
        let parserManager = DLParserManager()
        parserManager.sharedInstance()
        parserManager.delegate = self
        
        let url = NSString(format: "%@", ROOT_WEB_URL)
        parserManager.hitSyncServiceToFetchData(url as String)
    }
    
    // MARK: SyncServiceDelegate- Callback Methods **************/
    
    func parsingFailedWithError(error: String, forTag: NSInteger) {
        print("Failed")
    }
    
    func parsingFinished(response: NSMutableArray, forTag: NSInteger) {
        if (response.count>0){
            self.arrData = response
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadData()
            });
        }
    }
    
    // MARK: CloudKit functions
    
    func getRecordsFromCloud() {
        // Fetch data using Convenience API
        let cloudContainer = CKContainer.defaultContainer()
        let publicDatabase = cloudContainer.publicCloudDatabase
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Restaurants", predicate: predicate)
        
        publicDatabase.performQuery(query, inZoneWithID: nil, completionHandler: {
            (results, error) -> Void in
            
            if error != nil {
                print(error)
                return
            }
            
            if let results = results {
                print("Completed the download of Restaurant data")
                self.restaurants = results
                NSOperationQueue.mainQueue().addOperationWithBlock() {
                    self.tableView.reloadData()
                }
            }
        })
    }
    
    
    // MARK: UITableView Data Source Methods **************/
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //From service
        
        /* if shouldShowSearchResults {
        return filteredArray.count
        }
        else {
        return arrData.count
        }*/
        
        //From Cloud
        return restaurants.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "StackCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier,forIndexPath: indexPath) as! StackTableViewCell
        configureTVCell(cell, indexpath: indexPath)
        return cell
    }
    
    // MARK: Custom TVCell Data population Method **************/
    
    func configureTVCell (cell:StackTableViewCell, indexpath:NSIndexPath){
        //From service
        
        /*  var model = DLDataModel()
        model  = self.arrData[indexpath.row] as! DLDataModel
        cell.lblName.text = NSString(format: "%i", model.number.integerValue) as String
        cell.lblLocation.text = model.name  as String
        cell.lblType.text = NSDate.formatDate(model.date, format:"MM/dd/yyyy") as String*/
        
        //From Cloud
        let restaurant                  = restaurants[indexpath.row]
        cell.lblName?.text              = restaurant.objectForKey("name") as? String
        cell.lblLocation?.text              = restaurant.objectForKey("location") as? String
        cell.lblType?.text              = restaurant.objectForKey("type") as? String

        
        if let image = restaurant.objectForKey("image") {
            let imageAsset = image as! CKAsset
            cell.imgViewThumbNail?.image = UIImage(data: NSData(contentsOfURL: imageAsset.fileURL)!)
        }
        
    }
    
    
}