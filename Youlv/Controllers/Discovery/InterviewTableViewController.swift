//
//  InterViewTableViewController.swift
//  Youlv
//
//  Created by Lost on 14/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class InterviewTableViewController: UITableViewController {
    
    var interviewsArray : NSArray?

    override func viewDidLoad() {
        super.viewDidLoad()
        getInterviewList(1,pageSize: 10)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    let client = DataClient()
    func getInterviewList(currentPage: Int, pageSize:Int)
    {
        client.getInterviewList(currentPage, pageSize: pageSize, completion: { (data, error) -> () in
            self.getInterviewListCompleted(data, error: error)
        })
    }
    
    func getInterviewListCompleted(data:NSData?,error:NSError?)
    {
        if error != nil
        {
            return
        }
        
        let errorPointer = NSErrorPointer()
        let dict = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves, error: errorPointer) as! NSDictionary
        
        let dictData = dict.objectForKey("data") as! NSDictionary
        interviewsArray = (dictData.objectForKey("viewList") as? NSArray)!
        dispatch_sync(dispatch_get_main_queue(), { () -> Void in
            self.tableView.reloadData()
        })
        
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

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if interviewsArray == nil
        {
            return 0
        }
        return interviewsArray!.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("InterviewCell", forIndexPath: indexPath) as! InterviewTableViewCell
        cell.displayData(interviewsArray?.objectAtIndex(indexPath.item) as! NSDictionary)
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let basicHeight : CGFloat = 168.0
        let text = (interviewsArray?.objectAtIndex(indexPath.item) as! NSDictionary).objectForKey("view_content") as! String
        let textHeight = calTextSizeWithDefualtFont(text, self.view.frame.width - 32).height
        return textHeight + basicHeight
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goInterviewDetail"
        {
            var vc = segue.destinationViewController as! InterviewDetailViewController
            let selectedIndex = tableView.indexPathForSelectedRow()?.item
            var selectedData = interviewsArray?.objectAtIndex(selectedIndex!) as! NSDictionary
            vc.dataDictFromList = selectedData
            vc.interviewId = selectedData.objectForKey("view_id") as? Int
            
        }
    }
}

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

*/
