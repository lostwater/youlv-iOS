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
    
    func send()
    {
        var parameters : NSDictionary = ["topicId":topicId,"content":textView.text,"sessionId":sessionId]
        DataClient().postDiscussReply(parameters) { (data, error) -> () in
            dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                self.sendCompleted(data,error: error)
                
            })
        }
    }
    
    func sendCompleted(data:NSDictionary?,error:NSError?)
    {
        UIAlertView(title: data?.objectForKey("errmessage") as? String, message: nil, delegate: nil, cancelButtonTitle: "ok").show()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        textView.becomeFirstResponder()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SendAndUnwindFromReply"
        {
            send()
        }
    }
}