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
            selectAllIcon.image = UIImage(named:"checkoff")
        }
        else
        {
            for cell  in tableView.visibleCells()
            {
                
                (cell as! UITableViewCell).selected = true
                
            }
            selectAllIcon.image = UIImage(named:"checkon")
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
        client.getRecommendedTopics(currentPage, pageSize: pageSize, completion: { (dict, error) -> () in
            self.getRecommendedTopicsCompleted(dict, error: error)
        })
    }
    
    func getRecommendedTopicsCompleted(dict:NSDictionary?,error:NSError?)
    {
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
        let cell = tableView.dequeueReusableCellWithIdentifier("UserCell", forIndexPath: indexPath) as! ContactTableViewCell
        let content = topicsArray!.objectAtIndex(indexPath.row) as! NSDictionary
        //cell.imageView?.sd_setImageWithURL(NSURL(string: content.objectForKey("") as! String))
        cell.userName.text = content.objectForKey("title") as? String
        cell.intro?.text = content.objectForKey("content") as? String
        cell.tag = content.objectForKey("articleId") as! Int
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "nextToUsers"
        {
            markTopics()
        }
        if segue.identifier == "skipToUsers"
        {
            
        }

    }
    
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        
        
        if identifier == "nextToUsers" && !postFinished
        {
            return true
            return false
        }
        return true
    }
    
    func markTopics()
    {
        var ids = NSMutableArray()
        for c in tableView.visibleCells()
        {
            let cell = c as! UITableViewCell
            if cell.selected
            {
                ids.addObject(cell.tag)
            }
        }
        
        DataClient().postMarkTopics(ids){ (dict, erorr) -> () in}
    }
  
    
}

