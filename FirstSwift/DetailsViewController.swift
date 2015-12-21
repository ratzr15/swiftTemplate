//
//  DetailsViewController.swift
//  FirstSwift
//
//  Created by Rathish on 07/12/15.
//  Copyright © 2015 DubaiLandDept. All rights reserved.
//

import Foundation
import UIKit

let  ROOT_WEB_URL = "http://devmobile.dubailand.gov.ae:4000/tuo.Mobile.Server/api/tuo?CustomerId=10662&&custstartindex=0&custrowscounts=20"

class DetailsViewController: UIViewController, UITableViewDataSource, DLParserManagerDelegate, UISearchBarDelegate, CustomSearchControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var arrData = NSMutableArray()
    let managerParser = DLParserManager()
    
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

    }
    
    override func viewWillAppear(animated: Bool) {
        //Service request Method
        invokeServiceToFetchData()
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

    
    func invokeServiceToFetchData(){
        let parserManager = DLParserManager()
        parserManager.sharedInstance()
        parserManager.delegate = self
        
        let url = NSString(format: "%@", ROOT_WEB_URL)
        parserManager.hitSyncServiceToFetchData(url as String)
    }
    
    /************* SyncServiceDelegate- Callback Methods **************/
    
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
    
    /************* UITableView Data Source Methods **************/

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shouldShowSearchResults {
            return filteredArray.count
        }
        else {
            return arrData.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "StackCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier,forIndexPath: indexPath) as! StackTableViewCell
        configureTVCell(cell, indexpath: indexPath)
        return cell
    }
    
    /************* Custom TVCell Data population Method **************/

    func configureTVCell (cell:StackTableViewCell, indexpath:NSIndexPath){
        var model = DLDataModel()

        model  = self.arrData[indexpath.row] as! DLDataModel
        cell.lblName.text = NSString(format: "%i", model.number.integerValue) as String
        cell.lblLocation.text = model.name  as String
        cell.lblType.text = NSDate.formatDate(model.date, format:"MM/dd/yyyy") as String
    }
    
   
}