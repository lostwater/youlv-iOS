//
//  TopicsTableViewController.swift
//  Youlv
//
//  Created by Lost on 22/04/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class TopicsTableViewController: UITableViewController {

    @IBOutlet var searchBar: UISearchBar!
    
    var topicsArray : NSArray?
    var currentPage = 1
    
    var selectedGroupId : Int
        {
        get{
            if let selectedIndex = tableView.indexPathForSelectedRow
            {
              
                let dataDict = topicsArray!.objectAtIndex(selectedIndex.item) as! NSDictionary
                return dataDict.objectForKey("group_id") as! Int
            }
            else
            {
                return 0
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = searchBar
        tableView.headerViewForSection(0)?.textLabel!.textColor = appBlueColor
        tableView.headerViewForSection(0)?.textLabel!.text = "热门"
        getTopicList(currentPage, pageSize:10)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    
    let client = DataClient()
    func getTopicList(currentPage: Int, pageSize:Int)
    {
        client.getTopicGroupList(currentPage, pageSize: pageSize, completion: { (dict, error) -> () in
            self.getTopicListCompleted(dict, error: error)
        })
    }
    
    func getTopicListCompleted(dict:NSDictionary?,error:NSError?)
    {

        let dictData = dict!.objectForKey("data") as! NSDictionary
        topicsArray = (dictData.objectForKey("groupList") as? NSArray)!
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
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return topicsArray?.count ?? 0
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TopicCell", forIndexPath: indexPath) 
        let dataDict = topicsArray!.objectAtIndex(indexPath.item) as! NSDictionary
        //cell.imageView?.sd_setImageWithURL(url: NSURL(dataDict.objectForKey("") as! String))
        cell.textLabel!.text =  dataDict.objectForKey("group_name") as? String
        //cell.detailTextLabel!.text = dataDict.objectForKey("") as? String
        cell.tag = dataDict.objectForKey("group_id") as! Int

        return cell
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

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
