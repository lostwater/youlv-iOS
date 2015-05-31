//
//  RecommendedTopicsViewController.swift
//  Youlv
//
//  Created by Lost on 03/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//



class RecommendedTopicsViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var selectAllText: UIBarButtonItem!
    @IBOutlet weak var selectAllIcon: UIBarButtonItem!
    @IBAction func selectAllClicked(sender: AnyObject) {
        if selectedAll
        {
            for cell  in tableView.visibleCells()
            {
            
                (cell as! UITableViewCell).selected = false
            
            }
            selectAllIcon.image = UIImage(named:"checkon")
        }
        else
        {
            for cell  in tableView.visibleCells()
            {
                
                (cell as! UITableViewCell).selected = true
                
            }
            selectAllIcon.image = UIImage(named:"checkoff")
        }
        selectedAll = !selectedAll

    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var selectedAll = false
    var currentPage = 1
    var topicsArray : NSArray?
    let client = DataClient()
    var postFinished = false

    override func viewDidLoad() {
        getRecommendedTopics(currentPage, pageSize: 10)
        selectAllIcon.image = UIImage(named:"checkoff")
    }
    
    func getRecommendedTopics(currentPage: Int, pageSize:Int)
    {
        client.getRecommendedTopics(currentPage, pageSize: pageSize, completion: { (data, error) -> () in
            self.getRecommendedTopicsCompleted(data, error: error)
        })
    }
    
    func getRecommendedTopicsCompleted(data:NSData?,error:NSError?)
    {
        if error != nil
        {
            return
        }
        
        let errorPointer = NSErrorPointer()
        let dict = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves, error: errorPointer) as? NSDictionary
        if dict == nil{
            return
        }
        let dictData = dict!.objectForKey("data") as! NSDictionary
        topicsArray = (dictData.objectForKey("topicList") as? NSArray)!
        dispatch_sync(dispatch_get_main_queue(), {() -> Void in
            self.tableView.reloadData()
        })
        
    }
    
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topicsArray?.count ?? 0
    }
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TopicCell", forIndexPath: indexPath) as! UITableViewCell
        let content = topicsArray!.objectAtIndex(indexPath.row) as! NSDictionary
        //cell.imageView?.sd_setImageWithURL(NSURL(string: content.objectForKey("") as! String))
        cell.textLabel?.text = content.objectForKey("title") as? String
        cell.detailTextLabel?.text = content.objectForKey("content") as? String
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "nextToUsers"
        {

        }
        if segue.identifier == "skipToUsers"
        {
            
        }

    }
    
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if identifier == "nextToUsers" && !postFinished
        {
            return false
        }
        return true
    }
    
    
    
    
}

