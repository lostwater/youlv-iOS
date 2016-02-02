//
//  MyOpportunitiesTableViewController.swift
//  Youlv
//
//  Created by Lost on 21/04/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class MyOpportunitiesTableViewController: BaseTableViewController {

    
    @IBOutlet weak var switcher: UISegmentedControl!
    
    @IBAction func switcherChanged(sender: AnyObject) {
        if switcher.selectedSegmentIndex == 0
        {
            getMyUpload()
        }
        if switcher.selectedSegmentIndex == 1
        {
            getMyInterst()
        }
        
    }
    
    override func viewDidLoad() {
        //replaceNavTitle()
        super.viewDidLoad()
        if switcher.selectedSegmentIndex == 0
        {
            getMyUpload()
        }
        if switcher.selectedSegmentIndex == 1
        {
            getMyInterst()
        }
    }
    
    
    override func httpGet() {
        
    }
    
    
    func getMyUpload()
    {
        super.httpGet()
        httpClient.getMyUploadedCaseList{(dict, error) -> () in
            self.httpGetCompleted(dict, error: error)
        }

    }
    
    func getMyInterst()
    {
        super.httpGet()
        httpClient.getMyInterestedCaseList{(dict, error) -> () in
            self.httpGetCompleted(dict, error: error)
        }

    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.destinationViewController.isKindOfClass(OpportunityDetailViewController)
        {
            let vc = segue.destinationViewController as! OpportunityDetailViewController
            let selectedIndex = tableView.indexPathForSelectedRow?.item
            vc.dataDict = dataArray.objectAtIndex(selectedIndex!) as? NSDictionary
            
        }
        
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : OpportunityTableViewCell?
        let content = dataArray.objectAtIndex(indexPath.row) as! NSDictionary
        let type = content.objectForKey("type") as! Int
        if type < 3
        {
            cell = tableView.dequeueReusableCellWithIdentifier("CaseCell", forIndexPath: indexPath) as! OpportunityTableViewCell
        }
        else
        {
            cell = tableView.dequeueReusableCellWithIdentifier("InfoCell", forIndexPath: indexPath) as! OpportunityTableViewCell
        }
        cell!.configure(content)
        return cell!
    }
    


   

    func replaceNavTitle()
    {
        let typeSwitcher = UISegmentedControl();
        typeSwitcher.insertSegmentWithTitle("我发布的", atIndex: 0, animated: false)
        typeSwitcher.insertSegmentWithTitle("我收藏的", atIndex: 1, animated: false)
        typeSwitcher.selectedSegmentIndex = 0
        self.navigationItem.titleView = typeSwitcher
    }

 

}
