//
//  GroupTopicsTableViewController.swift
//  Youlv
//
//  Created by Lost on 14/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class GroupTopicsTableViewController: UITableViewController {

    @IBOutlet weak var topicImageView: UIImageView!
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var fansCount: UILabel!
    @IBOutlet weak var readCount: UILabel!
    @IBOutlet weak var repliedCount: UILabel!
    @IBOutlet weak var markButton: NSLayoutConstraint!
    
    @IBOutlet weak var groupTitle: UILabel!
    @IBOutlet weak var newReplyButton: UIButton!
    
    @IBAction func unwindToGroupTopics(segue: UIStoryboardSegue)
    {
        //performSegueWithIdentifier("UnwindToGroupTopics", sender: self)
    }
    
    var groupId : Int = 0
    var repliedArray : NSArray?
    var currentPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getTopicGroupDetail(currentPage,pageSize: 10)
        
    }
    
    func getTopicGroupDetail(currentPage: Int, pageSize:Int)
    {
        DataClient().getTopicGroupDetail(groupId, currentPage: currentPage, pageSize: pageSize, completion: { (dict, error) -> () in
            self.getTopicGroupDetailCompleted(dict, error: error)
        })
    }
    
    func getTopicGroupDetailCompleted(dict:NSDictionary?,error:NSError?)
    {
        let dictData = dict!.objectForKey("data") as! NSDictionary
        repliedArray = (dictData.objectForKey("topicList") as? NSArray)!
        dispatch_sync(dispatch_get_main_queue(), { () -> Void in
            self.displayData(dictData.objectForKey("group_topmsg") as! NSDictionary)
            self.tableView.reloadData()
        })
        
    }
    
    
    func displayData(dataDict : NSDictionary)
    {
        groupTitle.text = ""
        fansCount.text = String(dataDict.objectForKey("fansCount") as! Int)
        readCount.text = String(dataDict.objectForKey("readerCount") as! Int)
        repliedCount.text = String(dataDict.objectForKey("topicCount") as! Int)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goNewTopicReply"
        {
            let vc = segue.destinationViewController as! NewTopicReplyViewController
            vc.groupId = groupId
        }
    }
    
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return repliedArray?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let content = repliedArray!.objectAtIndex(indexPath.row) as! NSDictionary
        var cell : DiscussTableViewCell?
        cell = tableView.dequeueReusableCellWithIdentifier("TopicCell", forIndexPath: indexPath) as? DiscussTableViewCell
        cell?.displayData(content)
        return cell!
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let content = repliedArray!.objectAtIndex(indexPath.row) as! NSDictionary

            let baseHeight :CGFloat = 115.0+90.0
            let topicContentText = content.objectForKey("topic_content") as! String
            let operatorContentText = content.objectForKey("operate_content") as! String
            var textHeight = calTextSizeWithDefualtFont(topicContentText, self.view.frame.width - 32).height
            textHeight = textHeight + calTextSizeWithDefualtFont(operatorContentText, self.view.frame.width - 32).height
            return textHeight+baseHeight
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.barTintColor = UIColor.clearColor()
        self.navigationController?.navigationBar.translucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(named:"bgTransNavi"), forBarMetrics: UIBarMetrics.Default)        //let view = self.tableView.headerViewForSection(0)
        //view!.frame = CGRectMake(0,-44,view!.frame.size.width,view!.frame.size.height)
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.barTintColor = appBlueColor
        self.navigationController?.navigationBar.translucent = false
        
    }


}
