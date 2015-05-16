//
//  ResearchTableViewController.swift
//  Youlv
//
//  Created by Lost on 14/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class ResearchTableViewController: UITableViewController {

    var currentPage = 1
    var researchArry : NSArray?
    
    let client = DataClient()
    func getResearchList(currentPage: Int, pageSize:Int)
    {
        client.getResearchList(currentPage, pageSize: pageSize, completion: { (data, error) -> () in
            self.getResearchListCompleted(data, error: error)
        })
    }
    
    func getResearchListCompleted(data:NSData?,error:NSError?)
    {
        if error != nil
        {
            return
        }
        
        let errorPointer = NSErrorPointer()
        let dict = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves, error: errorPointer) as! NSDictionary
        
        let dictData = dict.objectForKey("data") as! NSDictionary
        researchArry = (dictData.objectForKey("voteList") as? NSArray)!
        dispatch_sync(dispatch_get_main_queue(), { () -> Void in
            self.tableView.reloadData()
        })
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getResearchList(1,pageSize: 10)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return researchArry?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ResearchCell", forIndexPath: indexPath) as! ResearchTableViewCell
        cell.displayData(researchArry?.objectAtIndex(indexPath.item) as! NSDictionary)
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let basicHeight : CGFloat = 156
        let dataDict = researchArry?.objectAtIndex(indexPath.item) as! NSDictionary
        var voteContent = dataDict.objectForKey("vote_content") as! String
        var voteOptions = dataDict.objectForKey("vote_options") as! NSArray
        for o in voteOptions
        {
            voteContent = voteContent + "\n\n" + ((o as! NSDictionary).objectForKey("option_content") as! String)
        }

        let textHeight = calTextSizeWithDefualtFont(voteContent, 17, self.view.frame.width - 32).height
        return textHeight + basicHeight
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goResearchDetail"
        {
            let vc = segue.destinationViewController as! ResearchDetailTableViewController
            let selectedIndex = tableView.indexPathForSelectedRow()?.item
            var selectedData = researchArry?.objectAtIndex(selectedIndex!) as! NSDictionary
            vc.researchId = selectedData.objectForKey("vote_id") as? Int
            vc.content = selectedData.objectForKey("vote_content") as? String
            vc.optionsContentArray  = selectedData.objectForKey("vote_options") as? NSArray

        }
    }
}
