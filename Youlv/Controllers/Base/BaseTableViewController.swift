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
    var currentPage = 1
    var isLoading = false
    
    var httpGet : ((currentPage: Int, pageSize:Int)->Void)?

    
    func getDataArray(currentPage: Int, pageSize:Int)
    {
        if isLoading
        {
            return
        }
        else
        {
            isLoading = true
            httpGet!(currentPage: currentPage, pageSize:10)
        }
    }
    
    func endLoad()
    {
        isLoading = false
        tableView.headerEndRefreshing()
        tableView.footerEndRefreshing()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRefresh()
        currentPage = 1
        dataArray.removeAllObjects()
        getDataArray(currentPage,pageSize:10)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func refreshDataArrary()
    {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.currentPage = 1
            self.dataArray.removeAllObjects()
            self.getDataArray(self.currentPage,pageSize:10)
        })
        

    }
    
    func setupRefresh(){
        self.tableView.addHeaderWithCallback({
            if self.isLoading
            {
                self.tableView.headerEndRefreshing()
                return
            }
                self.refreshDataArrary()
            
            }
        )
        self.tableView.addFooterWithCallback({
            if self.isLoading
            {
                self.tableView.footerEndRefreshing()
                return
            }
                self.getDataArray(self.currentPage,pageSize: 10)
                //self.tableView.setFooterHidden(true)
        })
    }

    
    func viewWillAppear2(animated: Bool)
    {
        currentPage = 1
        dataArray.removeAllObjects()
        getDataArray(currentPage,pageSize:10)

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
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return dataArray.count
    }
    
     func tableView2(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
            if indexPath.item == dataArray.count - 1
            {
                getDataArray(currentPage,pageSize: 10)
            }
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