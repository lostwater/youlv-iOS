//
//  DiscussDetailTableViewController.swift
//  Youlv
//
//  Created by Lost on 12/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//



class DiscussDetailTableViewController: UITableViewController {
    
    var topicId : Int?
    var commentsArray = NSArray()

    func reloadTableView()
    {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.tableView.reloadData()
        })
    }
    
    func getDiscussDetail()
    {
        DataClient().getTopicDetail(topicId!, currentPage: 10, pageSize: 10) { (data, error) -> () in
            self.getDiscussDetailCompleted(data,error: error)
        }
    }
    
    func getDiscussDetailCompleted(data:NSData?,error:NSError?)
    {
        if error != nil
        {
            return
        }
        let errorPointer = NSErrorPointer()
        let dict = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves, error: errorPointer) as! NSDictionary
        
        let dictData = dict.objectForKey("data") as! NSDictionary
        
        commentsArray = (dictData.objectForKey("replyList") as? NSArray)!
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.tableView.reloadData()
        })
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DiscussCommentCell", forIndexPath: indexPath) as! DiscussCommentTableViewCell
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentsArray.count    }

}
