//
//  ViewControllerWithTableView.swift
//  Youlv
//
//  Created by Lost on 01/07/2015.
//  Copyright (c) 2015 com.RamyTech. All rights reserved.
//

import UIKit

class ViewControllerWithPagedTableView: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    var mainTableView : UITableView?
    
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
            self.mainTableView?.headerEndRefreshing()
            self.mainTableView?.footerEndRefreshing()
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
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.dataArray.addObjectsFromArray(array! as Array)
                self.mainTableView?.reloadData()
                self.endLoad()
                self.mainTableView?.setNeedsLayout()
                self.mainTableView?.layoutIfNeeded()
                self.mainTableView?.reloadData()
                self.mainTableView?.beginUpdates()
                self.mainTableView?.endUpdates()
            })
            
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupRefresh()
        dataArray.removeAllObjects()
        httpGet()
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
        self.mainTableView?.addHeaderWithCallback({
            if self.isLoading
            {
                self.mainTableView?.headerEndRefreshing()
                return
            }
            self.refreshDataArrary()
            
            }
        )
        self.mainTableView?.addFooterWithCallback({
            if self.isLoading
            {
                self.mainTableView?.footerEndRefreshing()
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
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
     func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return dataArray.count
    }

}
