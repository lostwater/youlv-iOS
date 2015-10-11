//
//  ArticleCommentsTableViewController.swift
//  Youlv
//
//  Created by Lost on 17/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class ArticleCommentsTableViewController: ViewControllerWithPagedTableView {
    
    var articleId : Int?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var commentsCountButton: UIButton!
    
    @IBOutlet weak var newCommentTextField: UITextField!
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var sendButton: UIButton!
    
    
    @IBAction func sendButtonClicked(sender: AnyObject) {
        DataClient().postArticleComment(articleId!, comment: newCommentTextField.text!) { (dict, error) -> () in
            if dict != nil
            {
                let message = dict!.objectForKey("errmessage") as! String
                let errorcode = dict!.objectForKey("errcode") as! Int
                if errorcode == 0
                {
                    dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                        KVNProgress.showSuccessWithStatus(message)
                    })
                }
                if errorcode == 1
                {
                    dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                        KVNProgress.showErrorWithStatus(message)
                    })
                }
            }
            
        }
    }
    
    
    @IBOutlet weak var inputViewToBottom: NSLayoutConstraint!
    
    @IBAction func editingBegin(sender: AnyObject) {
        
    }
    @IBAction func editingEnd(sender: AnyObject) {
        resignFirstResponder()
        //inputViewToBottom.constant = 0
    }
    
    override func getDataArray(currentPage: Int, pageSize:Int)
    {
        getArticleCommentsList(currentPage, pageSize:pageSize)
    }

    
    func getArticleCommentsList(currentPage: Int, pageSize:Int)
    {
        DataClient().getArticleCommentsList(articleId!, currentPage: currentPage, pageSize: pageSize, completion: { (dict, error) -> () in
            self.getArticleCommentsListCompleted(dict, error: error)
        })
    }
    
    func getArticleCommentsListCompleted(dict:NSDictionary?,error:NSError?)
    {
        
        let dictData = dict!.objectForKey("data") as! NSDictionary
        let array = dictData.objectForKey("commentList") as? NSArray
        if (array?.count ?? 0) > 0
        {
            dataArray.addObjectsFromArray(array! as Array)
            currentPage++
            dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
                self.commentsCountButton.setTitle("评论"+String(self.dataArray.count), forState: UIControlState.Normal)
            })
            
        }
        
    }

    
    override func viewDidLoad() {
        
        newCommentTextField.setValue(UIColor.blackColor(), forKeyPath: "_placeholderLabel.textColor")
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow", name: UIKeyboardWillShowNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification)
    {
        let info = notification.userInfo!
        let value: AnyObject  = info[UIKeyboardFrameEndUserInfoKey]!
        
        let rawFrame = value.CGRectValue
        let keyboardFrame = view.convertRect(rawFrame, fromView: nil)
        
        inputViewToBottom.constant = keyboardFrame.height

    }
    
   
    
    
     override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ArticleCommentCell", forIndexPath: indexPath) as! ArticleCommentTableViewCell
        cell.displayData(dataArray.objectAtIndex(indexPath.item) as! NSDictionary)
        return cell
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let content = dataArray.objectAtIndex(indexPath.item) as! NSDictionary
        let commentString = content.objectForKey("comment") as! String
        
        let attCommentStr = NSAttributedString(string: commentString)
        var range = NSMakeRange(0,attCommentStr.length)
        var strDict = attCommentStr.attributesAtIndex(0, effectiveRange: &range)
        var commentTextSize = calTextSizeWithDefualtFont(commentString, width: tableView.frame.width - 74)
        return commentTextSize.height + 38
    }
    

  
}
