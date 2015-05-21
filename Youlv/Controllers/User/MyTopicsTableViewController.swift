//
//  DiscussTableViewController.swift
//  Youlv
//
//  Created by Lost on 27/04/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class MyTopicsTableViewController: UITableViewController {
    
    @IBOutlet var typeSwitcher: UISegmentedControl!
    
    @IBAction func typeSwitcherChanged(sender: AnyObject) {
       iniTableData()
    }
    

    func iniTableData()
    {
        currntPage = 1
        if typeSwitcher.selectedSegmentIndex == 0
        {
            getMyPostTopics(currntPage,pageSize: 10)
        }
        else if typeSwitcher.selectedSegmentIndex == 1
        {
            getMyMarkedTopics(currntPage,pageSize: 10)

        }
        else if typeSwitcher.selectedSegmentIndex == 2
        {
            getMyRepliedTopics(currntPage,pageSize: 10)

        }
    }
    
    
    var discussArray : NSArray?
    var currntPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        iniTableData()
    }
    
    
    let client = DataClient()
    func getMyPostTopics(currentPage: Int, pageSize:Int)
    {
        client.getMyPostTopics(currentPage, pageSize: pageSize, completion: { (data, error) -> () in
            self.getMyPostTopicsCompleted(data, error: error)
        })
    }
    
    func getMyPostTopicsCompleted(data:NSData?,error:NSError?)
    {
        if error != nil
        {
            return
        }
        
        let errorPointer = NSErrorPointer()
        let dict = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves, error: errorPointer) as! NSDictionary
        
        let dictData = dict.objectForKey("data") as! NSDictionary
        discussArray = (dictData.objectForKey("topicList") as? NSArray)!
        dispatch_sync(dispatch_get_main_queue(), { () -> Void in
            self.tableView.reloadData()
        })
        
    }
    
    func getMyMarkedTopics(currentPage: Int, pageSize:Int)
    {
        client.getMyMarkedTopics(currentPage, pageSize: pageSize, completion: { (data, error) -> () in
            self.getMyMarkedTopicsCompleted(data, error: error)
        })
    }
    
    func getMyMarkedTopicsCompleted(data:NSData?,error:NSError?)
    {
        if error != nil
        {
            return
        }
        
        let errorPointer = NSErrorPointer()
        let dict = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves, error: errorPointer) as! NSDictionary
        
        let dictData = dict.objectForKey("data") as! NSDictionary
        discussArray = (dictData.objectForKey("topicList") as? NSArray)!
        dispatch_sync(dispatch_get_main_queue(), { () -> Void in
            self.tableView.reloadData()
        })
        
    }
    
    func getMyRepliedTopics(currentPage: Int, pageSize:Int)
    {
        client.getMyRepliedTopics(currentPage, pageSize: pageSize, completion: { (data, error) -> () in
            self.getMyRepliedTopicsCompleted(data, error: error)
        })
    }
    
    func getMyRepliedTopicsCompleted(data:NSData?,error:NSError?)
    {
        if error != nil
        {
            return
        }
        
        let errorPointer = NSErrorPointer()
        let dict = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves, error: errorPointer) as! NSDictionary
        
        let dictData = dict.objectForKey("data") as! NSDictionary
        discussArray = (dictData.objectForKey("topicReplyList") as? NSArray)!
        dispatch_sync(dispatch_get_main_queue(), { () -> Void in
            self.tableView.reloadData()
        })
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goRepliedDiscussDetail" || segue.identifier == "goPostedDiscussDetail"
        {
            let discussDetail = segue.destinationViewController as! DiscussDetailViewController
            let selectedIndex = tableView.indexPathForSelectedRow()?.item
            let dataDict = discussArray!.objectAtIndex(selectedIndex!) as? NSDictionary

            discussDetail.dataDict = dataDict
            discussDetail.topicId = dataDict?.objectForKey("topic_id") as? Int
            discussDetail.isFromMyTopic = true
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        
        return discussArray?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let dataDict = discussArray!.objectAtIndex(indexPath.row) as! NSDictionary
        var cell : DiscussTableViewCell?
        if typeSwitcher.selectedSegmentIndex == 0
        {
            cell = tableView.dequeueReusableCellWithIdentifier("DiscussPostedCell", forIndexPath: indexPath) as? DiscussTableViewCell
            cell?.displayMyPost(dataDict)
        }
        else if typeSwitcher.selectedSegmentIndex == 1
        {
            cell = tableView.dequeueReusableCellWithIdentifier("DiscussPostedCell", forIndexPath: indexPath) as? DiscussTableViewCell
            cell?.displayMyMarked(dataDict)
            
        }
        else if typeSwitcher.selectedSegmentIndex == 2
        {
            cell = tableView.dequeueReusableCellWithIdentifier("DiscussRepliedCell", forIndexPath: indexPath) as? DiscussTableViewCell
            cell?.displayMyReplied(dataDict)
            
        }

        return cell!
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let dataDict = discussArray!.objectAtIndex(indexPath.row) as! NSDictionary

        if typeSwitcher.selectedSegmentIndex == 0 || typeSwitcher.selectedSegmentIndex == 1
        {
            let baseHeight :CGFloat = 115.0
            let topicContentText = dataDict.objectForKey("topic_content") as! String
            let textHeight = calTextSizeWithDefualtFont(topicContentText, self.view.frame.width - 32).height
            
            return textHeight+baseHeight
            
        }
        else
        {
            let baseHeight :CGFloat = 115.0+90.0
            let topicContentText = dataDict.objectForKey("topic_content") as! String
            let operatorContentText = dataDict.objectForKey("reply_content") as! String
            var textHeight = calTextSizeWithDefualtFont(topicContentText, self.view.frame.width - 32).height
            textHeight = textHeight + calTextSizeWithDefualtFont(operatorContentText, self.view.frame.width - 32).height
            return textHeight+baseHeight
        }

        
    }
    
    
    
    
    
    
    
}
