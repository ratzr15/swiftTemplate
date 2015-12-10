//
//  SideMenuViewController.swift
//  ERESTemplate
//
//  Created by Rathish on 10/12/15.
//  Copyright © 2015 DubaiLandDept. All rights reserved.
//

import Foundation
import UIKit

enum SAGithubImage: String {
    case avatar
    case gracehoppertocat
    case hipsterPartycat
    case mountietocat
    case octoliberty
    case ProfessortocatV2
}

class SideMenuViewController: UIViewController, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    
    let images = [UIImage(named: SAGithubImage.gracehoppertocat.rawValue), UIImage(named: SAGithubImage.hipsterPartycat.rawValue), UIImage(named: SAGithubImage.mountietocat.rawValue), UIImage(named: SAGithubImage.octoliberty.rawValue), UIImage(named: SAGithubImage.ProfessortocatV2.rawValue)]
   
    override func viewDidLoad() {
       
        setNavigationTitle("")
        
        self.tableView.tableHeaderView = SAStickyHeaderView(frame: CGRectMake(0, 0, CGRectGetWidth(view.frame), 200), table: tableView, image: images)
    }
    
    /************* UITableView Data Source Methods **************/
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "SideCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier,forIndexPath: indexPath) as! SideViewCell
        return cell
    }
    
    func setNavigationTitle (title: String){
        self.title = title
        let font: UIFont = UIFont(name: "Helvetica", size: 18)!
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: font, NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.hidden = true
        
    }

}
