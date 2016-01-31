//
//  RecommendedUsersViewController.swift
//  Youlv
//
//  Created by Lost on 03/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//



class RecommendedUsersViewController: ViewControllerWithPagedTableView {
    
    
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
    
    @IBAction func skipButtonClicked(sender: AnyObject) {
        
        goMainVC()
    }
    @IBAction func nextButtonClicked(sender: AnyObject) {
        followUsers()
        goMainVC()
    }

    
    var selectedImage = UIImage(named:"checkoff")
    
    override func viewDidLoad() {
        self.mainTableView = tableView
        selectAllIcon.image = UIImage(named:"checkoff")
        
        super.viewDidLoad()

    }
    
    override func httpGet() {
        httpClient.getRecommendedUsers { (dict, error) -> () in
            self.httpGetCompleted(dict, error: error)
        }
        
    }
    

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UserCell", forIndexPath: indexPath) as! ContactTableViewCell
        let content = dataArray.objectAtIndex(indexPath.row) as! NSDictionary
        cell.userHead.sd_setImageWithURL(NSURL(string: content.objectForKey("avatar") as! String))
        cell.userName.text = content.objectForKey("name") as? String
        cell.intro?.text = content.objectForKey("about") as? String
        cell.tag = content.objectForKey("uid") as! Int
        //cell.imageView?.hidden = true
        
        //cell.imageView!.frame.origin = CGPointMake(300,  cell.imageView!.frame.origin.y)
        return cell
    }
    
    func followUsers()
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
        
        httpClient.followUser(ids) { (dict, error) -> () in
            KVNProgress.showSuccessWithStatus("关注成功")
        }
    }
    
    
    
}
