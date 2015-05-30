//
//  SignupViewController.swift
//  Youlv
//
//  Created by Lost on 14/04/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {

    @IBOutlet var mobile: UITextField!
    @IBOutlet var validCode: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var userName: UITextField!
    @IBOutlet var signupButton: UIButton!
    
    @IBAction func signupButtonClicked(sender: AnyObject) {
         signup()
    }
    
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var sendButtonClicked: UIButton!
    
    @IBAction func mobileEnd(sender: AnyObject) {
        mobile.resignFirstResponder()
    }
    @IBAction func codeEnd(sender: AnyObject) {
        validCode.resignFirstResponder()
    }
    @IBAction func passwordEnd(sender: AnyObject) {
        password.resignFirstResponder()
    }
    @IBAction func usernameEnd(sender: AnyObject) {
        userName.resignFirstResponder()
    }
    
    var accountKeyWrapper = KeychainItemWrapper(identifier: "account", accessGroup: ".com.Ramy.Youlv")
    var passwordKeyWrapper = KeychainItemWrapper(identifier: "password", accessGroup: ".com.Ramy.Youlv")
    
    var signUpSucceeded = false
    
    
    var error = EMError()
    func easeMobSignup()
    {
        EaseMob.sharedInstance().chatManager.asyncRegisterNewAccount(mobile.text, password: password.text, withCompletion: { (username, password, error) -> Void in
            self.emSignupCompleted(username, password: password, error: error)
        }, onQueue: nil)
    }
    
    func emSignupCompleted(username:String,password:String,error:EMError?)
    {
        if(error != nil)
        {
            NSLog("注册成功")
            dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                self.goMainVC()
            })
        }
        else
        {
            NSLog("注册失败")
        }
    }
    
    
    func signup()
    {
        if mobile.text == nil || password.text == nil ||  mobile.text=="" ||   password.text == ""
        {
            showEmptyAlert()
            return
        }
        let parameters = NSDictionary(objects:[mobile.text,password.text], forKeys: ["phone","password"])
        DataClient().postSignup(mobile.text,password: password.text){ (data, error) -> () in
            self.signupCompleted(data,error: error)
        }
    }
    
    func signupCompleted(data:NSDictionary?,error:NSError?)
    {
        
        if data!.objectForKey("errcode") as! Int == 0
        {
            easeMobSignup()
            saveAccountAndPassword()
            login()
        }
        else
        {
            dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                let av = UIAlertView(title:"注册失败", message: data!.objectForKey("errmessage") as? String, delegate: nil, cancelButtonTitle: "确定")
                av.show()
            })
        }
    }
    
    func login()
    {
        let parameters = NSDictionary(objects:[mobile.text,password.text], forKeys: ["phone","password"])
        DataClient().postLogin(parameters) { (data, error) -> () in
            self.loginCompleted(data,error: error)
        }
    }
    
    func loginCompleted(data:NSDictionary?,error:NSError?)
    {
        getMyId()
        easeMobLogin()
        if data?.objectForKey("errcode") as? Int == 0
        {
            sessionId = data!.objectForKey("sessionId") as! String
        }
        dispatch_sync(dispatch_get_main_queue(), { () -> Void in
            self.signUpSecussed = true
            self.performSegueWithIdentifier("goRecommendedTopics", sender: self)
        })

    }
    
    
    func easeMobLogin()
    {
        EaseMob.sharedInstance().chatManager.asyncLoginWithUsername(mobile.text, password: password.text, completion: { (loginInfo, error) -> Void in
            if error == nil && loginInfo != nil
            {
                NSLog("登陆成功")
            }
            }, onQueue: nil)
    }
    
    
    func getMyId()
    {
        DataClient().getMyProfile { (data, error) -> () in
            self.getMyIdCompleted(data,error: error)
        }
    }
    
    func getMyIdCompleted(data:NSData?,error:NSError?)
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
        myLawyerId = dictData.objectForKey("lawyer_id") as! Int
    }
    
    func saveAccountAndPassword()
    {
        accountKeyWrapper.setObject(mobile.text, forKey: kSecAttrService)
        passwordKeyWrapper.setObject(password.text, forKey: kSecAttrService)
        
    }
    
    func showEmptyAlert()
    {
        let av = UIAlertView(title: "", message: "手机或密码不能为空", delegate: nil, cancelButtonTitle: "取消")
        av.show()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        mobile.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if !signUpSucceeded && identifier == "goRecommendedTopics"
        {
            signup()
            return false
        }
        return true
    }
 

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
