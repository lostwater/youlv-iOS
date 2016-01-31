//
//  RecommendedTopicsViewController.swift
//  Youlv
//
//  Created by Lost on 03/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//



class RecommendedTopicsViewController: ViewControllerWithPagedTableView {
    
    @IBOutlet weak var selectAllText: UIBarButtonItem!
    @IBOutlet weak var selectAllIcon: UIBarButtonItem!
    @IBAction func selectAllClicked(sender: AnyObject) {
        if selectedAll
        {
            for cell  in tableView.visibleCells
            {
            
                (cell ).selected = false
            
            }
            selectAllIcon.image = UIImage(named:"checkoff")
        }
        else
        {
            for cell  in tableView.visibleCells
            {
                
                (cell ).selected = true
                
            }
            selectAllIcon.image = UIImage(named:"checkon")
        }
        selectedAll = !selectedAll

    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var selectedAll = false
    var postFinished = false

    override func viewDidLoad() {
        self.mainTableView = tableView
        selectAllIcon.image = UIImage(named:"checkoff")
        
        super.viewDidLoad()
    }
    
    override func httpGet() {
        httpClient.getTopicList { (dict, error) -> () in
            self.httpGetCompleted(dict, error: error)
        }
        
    }
    
     override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UserCell", forIndexPath: indexPath) as! ContactTableViewCell
        let content = dataArray.objectAtIndex(indexPath.row) as! NSDictionary
        cell.userHead.sd_setImageWithURL(NSURL(string: content.objectForKey("topictype_avatar_img") as! String))
        //cell.imageView?.sd_setImageWithURL(NSURL(string: content.objectForKey("topictype_avatar_img") as! String))
        cell.userName.text = content.objectForKey("title") as? String
        cell.intro?.text = content.objectForKey("desc") as? String
        cell.tag = content.objectForKey("topictype_id") as! Int
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
    
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        
        
        if identifier == "nextToUsers" && !postFinished
        {
            return true
            return false
        }
        return true
    }
    
    func markTopics()
    {
        let ids = NSMutableArray()
        for c in tableView.visibleCells
        {
            let cell = c 
            if cell.selected
            {
                ids.addObject(String(cell.tag))
            }
        }
        
        httpClient.followTopicTypes(ids) { (dict, error) -> () in
            KVNProgress.showSuccessWithStatus("关注成功")
        }
    }
  
    
}

