//
//  RecommendedUsersViewController.swift
//  Youlv
//
//  Created by Lost on 03/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//



class RecommendedUsersViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    
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
    
    @IBAction func skipButtonClicked(sender: AnyObject) {
        goMainVC()
    }
    @IBAction func nextButtonClicked(sender: AnyObject) {
        goMainVC()
    }
    var currentPage = 1
    var usersArray : NSArray?
    let client = DataClient()
    
    override func viewDidLoad() {
        getRecommendedUsers(currentPage,pageSize: 10)
    }
    
    func getRecommendedUsers(currentPage: Int, pageSize:Int)
    {
        client.getRecommendedUsers(currentPage, pageSize: pageSize, completion: { (data, error) -> () in
            self.getRecommendedUsersCompleted(data, error: error)
        })
    }
    
    func getRecommendedUsersCompleted(data:NSData?,error:NSError?)
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
        usersArray = (dictData.objectForKey("lawyerList") as? NSArray)!
        dispatch_sync(dispatch_get_main_queue(), {() -> Void in
            self.tableView.reloadData()
        })
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersArray?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UserCell", forIndexPath: indexPath) as! UITableViewCell
        let content = usersArray!.objectAtIndex(indexPath.row) as! NSDictionary
        //cell.imageView?.sd_setImageWithURL(NSURL(string: content.objectForKey("") as! String))
        cell.textLabel?.text = content.objectForKey("name") as? String
        cell.detailTextLabel?.text = content.objectForKey("introduction") as? String
        return cell
    }
    

    
    
    
}
