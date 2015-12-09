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

class DetailsViewController: UIViewController, UITableViewDataSource, DLParserManagerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.redColor()
       
        //Automatic tvc height
        self.tableView.estimatedRowHeight = 120;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        
        invokeServiceToFetchData()
    
    }
    
    func invokeServiceToFetchData(){
        let parserManager = DLParserManager()
        parserManager.sharedInstance()
        parserManager.delegate = self
        
        let url = NSString(format: "%@", ROOT_WEB_URL)
        parserManager.hitSyncServiceToFetchData(url as String)
    }
    
    /************* SyncServiceDelegate- Callback Methods **************/
    
    func syncServiceFailedWithErrorCode(error: String, forTag: NSInteger) {
        print("Failed")
    }
    
    func syncServiceFinished(response: NSDictionary, forTag: NSInteger) {
        print("Swift Success")
    }

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "StackCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier,forIndexPath: indexPath) as! StackTableViewCell
        
        cell.lblName.text = "Increase the number of lines according to the content specified"
        cell.lblLocation.text = "#3,RAK Bank HQ, Dubai, Al Karama, PO Box: 686. "
        cell.lblType.text = "Requirement/ Optional"

        return cell
    }
}