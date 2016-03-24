//
//  OpportunityCommentViewController.swift
//  Youlv
//
//  Created by Lost on 21/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//


class OpportunityCommentViewController: UIViewController {

    @IBOutlet weak var sendButton: UIBarButtonItem!
    @IBOutlet var textView: CPTextViewPlaceholder!

    var opportunityId = 0
    var isSend = false
    
    func send()
    {
        //let parameters : NSDictionary = ["orderId":opportunityId,"content":textView.text,"sessionId":sessionId]
    }
    
    func sendCompleted(data:NSDictionary?,error:NSError?)
    {
        isSend = true
        dispatch_sync(dispatch_get_main_queue(), { () -> Void in
           
            self.performSegueWithIdentifier("SendAndUnwindFromComment", sender: self)
            //UIAlertView(title: data?.objectForKey("errmessage") as? String, message: nil, delegate: nil, cancelButtonTitle: "ok").show()
        })
        
    }
    
    override func viewDidAppear(animated: Bool) {
        textView.becomeFirstResponder()
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if identifier == "SendAndUnwindFromComment"
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

