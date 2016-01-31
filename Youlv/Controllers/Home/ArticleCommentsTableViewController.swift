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
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var commentsCountButton: UIButton!
    
    @IBOutlet weak var newCommentTextField: UITextField!
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var sendButton: UIButton!
    
    
    @IBAction func sendButtonClicked(sender: AnyObject) {
        httpClient.commentArticle(articleId!, text: newCommentTextField.text!) { (dict, error) -> () in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                KVNProgress.showSuccess()
                super.viewDidLoad()
            })

        }
    }
    
    
    @IBOutlet weak var inputViewToBottom: NSLayoutConstraint!
    
    @IBAction func editingBegin(sender: AnyObject) {
        
    }
    @IBAction func editingEnd(sender: AnyObject) {
        resignFirstResponder()
        //inputViewToBottom.constant = 0
    }
    
    
    override func httpGet() {
        super.httpGet()
        httpClient.getArticleCommentList(articleId!) { (dict, error) -> () in
            super.httpGetCompleted(dict, error: error)
        }
    }
    
    override func viewDidLoad() {
        super.mainTableView = tableView
        
        newCommentTextField.setValue(UIColor.blackColor(), forKeyPath: "_placeholderLabel.textColor")
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow", name: UIKeyboardWillShowNotification, object: nil)
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        super.viewDidLoad()
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
        cell.configure(dataArray.objectAtIndex(indexPath.item) as! NSDictionary)
        return cell
        
    }

    

  
}
