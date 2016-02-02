//
//  ContactsTableViewController.swift
//  Youlv
//
//  Created by Lost on 09/07/2015.
//  Copyright (c) 2015 com.RamyTech. All rights reserved.
//

import UIKit

class GeneralContactsTableViewController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    var isSelectable = false
    var selectedContactHeads : NSMutableArray
        {
        get
        {
            let heads = NSMutableArray()
            if let selected = tableView.indexPathsForSelectedRows
            {
                for s in selected
                {
                    let dataDict = dataArray.objectAtIndex((s ).item) as! NSDictionary
                    let headUrl = dataDict.objectForKey("lawyer_name") as! String
                    heads.addObject(headUrl)
                }
            }
            return heads
        }
    }
    
    var selectedContactIds : NSMutableArray
        {
        get
        {
            let heads = NSMutableArray()
            if let selected = tableView.indexPathsForSelectedRows
            {
                for s in selected
                {
                    let dataDict = dataArray.objectAtIndex((s ).item) as! NSDictionary
                    let userId = dataDict.objectForKey("lawyer_id") as! Int
                    heads.addObject(userId)
                }
            }
            return heads
        }
    }

    
    
    var dataArray = NSMutableArray()
    
    
    func  getFriendsList()
    {

    }
    
    func getFriendsListCompleted(dict:NSDictionary?,error:NSError?)
    {
        
        let dictData = dict!.objectForKey("data") as! NSDictionary
        dataArray.addObjectsFromArray(dictData.objectForKey("lawyerList") as! [AnyObject])
        dispatch_sync(dispatch_get_main_queue(), { () -> Void in
            self.tableView.reloadData()
        })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getFriendsList()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 66
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : ContactTableViewCell
        if isSelectable
        {
             cell = tableView.dequeueReusableCellWithIdentifier("selectableContactCell", forIndexPath: indexPath) as! ContactTableViewCell
        }
        else
        {
             cell = tableView.dequeueReusableCellWithIdentifier("contactCell", forIndexPath: indexPath) as! ContactTableViewCell
        }
       
        let dataDict = dataArray.objectAtIndex(indexPath.item) as! NSDictionary
        cell.userHead.sd_setImageWithURL(NSURL(string:dataDict.objectForKey("lawyer_photoUrl") as! String), placeholderImage: headImage)
        cell.userName.text =  dataDict.objectForKey("lawyer_name") as? String
        //cell.detailTextLabel!.text = dataDict.objectForKey("") as? String
        cell.tag = dataDict.objectForKey("lawyer_id") as! Int
        
        return cell
    }
    
    


}
