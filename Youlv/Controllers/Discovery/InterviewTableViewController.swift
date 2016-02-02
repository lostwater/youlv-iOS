//
//  InterViewTableViewController.swift
//  Youlv
//
//  Created by Lost on 14/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class InterviewTableViewController: BaseTableViewController {
    override func awakeFromNib() {
            }

    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }


    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("InterviewCell", forIndexPath: indexPath) as! InterviewTableViewCell
        cell.displayData(dataArray.objectAtIndex(indexPath.item) as! NSDictionary)
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let basicHeight : CGFloat = 168.0
        let text = (dataArray.objectAtIndex(indexPath.item) as! NSDictionary).objectForKey("view_content") as! String
        let textHeight = calTextSizeWithDefualtFont(text, width: self.view.frame.width - 32).height
        return textHeight + basicHeight
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goInterviewDetail"
        {
            let vc = segue.destinationViewController as! InterviewDetailViewController
            let selectedIndex = tableView.indexPathForSelectedRow?.item
            let selectedData = dataArray.objectAtIndex(selectedIndex!) as! NSDictionary
            vc.dataDictFromList = selectedData
            vc.interviewId = selectedData.objectForKey("view_id") as? Int
            
        }
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
}


