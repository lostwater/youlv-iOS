//
//  BaseTableViewController.swift
//  Youlv
//
//  Created by Lost on 01/07/2015.
//  Copyright (c) 2015 com.RamyTech. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {

    var dataArray = NSMutableArray()
    var isLoading = false
    
    var nextUrl : String?

    
    func getDataArray()
    {
        if isLoading
        {
            return
        }
        else
        {
            isLoading = true
            httpGet()
        }
    }
    
    func endLoad()
    {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.tableView.headerEndRefreshing()
            self.tableView.footerEndRefreshing()
        })
        isLoading = false
    }
    
    func httpGet()
    {
        if isLoading
        {
            return
        }
        else
        {
            isLoading = true
        }

    }
    
    func httpGetNext()
    {
        if isLoading
        {
            return
        }
        else
        {
            isLoading = true
        }
        httpClient.httpGet(nextUrl!) {(dict, error) -> () in
            
            self.httpGetCompleted(dict, error: error)
        }    
    }
    
    func httpGetCompleted(dict : NSDictionary?, error : NSError?)
    {
        
       
        nextUrl = dict?.objectForKey("next") as? String
        let array = dict!.objectForKey("results") as? NSArray
        if (array?.count ?? 0) > 0
        {
            self.endLoad()

            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.dataArray.addObjectsFromArray(array! as Array)
                self.tableView.reloadData()
                
                self.tableView.setNeedsLayout()
                self.tableView.layoutIfNeeded()
                self.tableView.reloadData()
                self.tableView.beginUpdates()
                self.tableView.endUpdates()
                
            })
            
        }
    }
    
    override func awakeFromNib()
    {
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRefresh()
        dataArray.removeAllObjects()
        getDataArray()	
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
//    override func viewDidAppear(animated:Bool)
//    {
//        super.viewDidAppear(animated)
//        
//        
//        tableView.reloadData()
//        tableView.setNeedsLayout()
//        tableView.layoutIfNeeded()
//        tableView.reloadData()
//    }
    
    func refreshDataArrary()
    {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            
            self.dataArray.removeAllObjects()
            self.getDataArray()
        })
        

    }
    
    func setupRefresh(){
        self.tableView.addHeaderWithCallback({
            if self.isLoading
            {
                self.tableView.headerEndRefreshing()
            }
            else
            {
                self.refreshDataArrary()
            }
            
            }
        )
        self.tableView.addFooterWithCallback({
            if self.isLoading
            {
                self.tableView.footerEndRefreshing()
                return
            }
            if (self.nextUrl ?? "").isEmpty
            {
                self.endLoad()
                
            }
            else
            {
                self.httpGetNext()
            }
                //self.tableView.setFooterHidden(true)
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
        return dataArray.count
    }
    

    

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }
    */

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
