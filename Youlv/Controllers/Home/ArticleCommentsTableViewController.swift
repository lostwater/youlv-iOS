//
//  ArticleCommentsTableViewController.swift
//  Youlv
//
//  Created by Lost on 17/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class ArticleCommentsTableViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var articleId : Int?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var commentsCountButton: UIButton!
    
    @IBOutlet weak var newCommentTextField: UITextField!
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var sendButton: UIButton!
    @IBAction func sendButtonClicked(sender: AnyObject) {
    }
    
    
    
    var commentsArray : NSArray?
    let client = DataClient()
    var currentPage = 1
    
    override func viewDidLoad() {
        getArticleCommentsList(currentPage, pageSize:10)
    }
    
    func getArticleCommentsList(currentPage: Int, pageSize:Int)
    {
        client.getArticleCommentsList(articleId!, currentPage: currentPage, pageSize: pageSize, completion: { (data, error) -> () in
            self.getArticleCommentsListCompleted(data, error: error)
        })
    }
    
    func getArticleCommentsListCompleted(data:NSData?,error:NSError?)
    {
        if error != nil
        {
            return
        }
        let errorPointer = NSErrorPointer()
        let ds = NSString(data: data!, encoding: NSUTF8StringEncoding) as! String
        print(ds)
        NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves, error: errorPointer)
        print(errorPointer.debugDescription)
        let dict = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves, error: errorPointer) as? NSDictionary
        if dict == nil
        {
            return
        }
        let dictData = dict!.objectForKey("data") as! NSDictionary
        commentsArray = (dictData.objectForKey("commentList") as? NSArray)!
        dispatch_sync(dispatch_get_main_queue(), { () -> Void in
            self.tableView.reloadData()
            self.commentsCountButton.setTitle(String(self.commentsArray?.count ?? 0), forState: UIControlState.Normal)
        })
    }
    
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return commentsArray?.count ?? 0
    }
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ArticleCommentCell", forIndexPath: indexPath) as! ArticleTableViewCell
        cell.displayData(commentsArray!.objectAtIndex(indexPath.item) as! NSDictionary)
        return cell
        
    }

  
}
