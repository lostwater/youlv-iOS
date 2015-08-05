//
//  InterviewAskViewController.swift
//  Youlv
//
//  Created by Lost on 29/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//



class InterviewAskViewController: UIViewController {

 
    @IBOutlet weak var text: CPTextViewPlaceholder!
    
    var interviewId = 0
    var isDidSend = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //text.becomeFirstResponder()
    }
    
    func send()
    {
        DataClient().postInterviewAsk(interviewId, content: text.text) { (dict, error) -> () in
            dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                self.sendCompleted(dict, error: error)
            })

           
        }
    }
    
    func sendCompleted(dict:NSDictionary?, error:NSError?)
    {

        if dict == nil
        {
            let av = UIAlertView(title: "发送失败", message: "未知错误", delegate: nil, cancelButtonTitle:"确定")
            av.show()
            return
        }
        if dict!.objectForKey("errcode") as! Int == 0
        {
            isDidSend = true
            self.performSegueWithIdentifier("unwindToInterviewDetail", sender: self)
        }
        if dict!.objectForKey("errcode") as! Int == 1
        {
            let av = UIAlertView(title: "发送失败", message: dict!.objectForKey("errmessage") as? String, delegate: nil, cancelButtonTitle:"确定")
            av.show()
        }
        
    }
    
    

    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if identifier == "unwindToInterviewDetail" && !isDidSend
        {
            send()
            return false
        }
        return true
    }
}
