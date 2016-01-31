//
//  DiscussReplyViewController.swift
//  Youlv
//
//  Created by Lost on 21/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

class DiscussReplyViewController: UIViewController {
    
    @IBOutlet weak var sendButton: UIBarButtonItem!
    @IBOutlet var textView: CPTextViewPlaceholder!
    
    var topicId = 0
    var isSend = false
    
    func send()
    {
        httpClient.commentTopic(topicId, text: textView.text!) { (dict, error) -> () in
            self.sendCompleted(dict,error: error)
        }
    }
    
    func sendCompleted(data:NSDictionary?,error:NSError?)
    {
        isSend = true
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            KVNProgress.showSuccess()
            self.performSegueWithIdentifier("SendAndUnwindFromReply", sender: self)
            
            })
        
    }
    
    override func viewDidAppear(animated: Bool) {
        textView.becomeFirstResponder()
    }
    

    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if identifier == "SendAndUnwindFromReply"
        {
            if isSend
            {
                return true
            }
            else
            {
                send()
                return false
            }
        }
        return true
    }
}