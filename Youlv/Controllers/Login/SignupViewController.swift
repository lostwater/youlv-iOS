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
    @IBOutlet weak var confirmpassword: UITextField!
    @IBOutlet var userName: UITextField!
    @IBOutlet var signupButton: UIButton!
    
    @IBAction func signupButtonClicked(sender: AnyObject) {
         //signup()
    }
    
    @IBOutlet var sendButton: UIButton!
    
    @IBAction func sendButtonClicked(sender: AnyObject) {
        askValidCode()
    }
    
    @IBAction func mobileEnd(sender: AnyObject) {
        mobile.resignFirstResponder()
    }
    @IBAction func codeEnd(sender: AnyObject) {
        validCode.resignFirstResponder()
    }
    @IBAction func passwordEnd(sender: AnyObject) {
        password.resignFirstResponder()
    }
    @IBAction func confirmpasswordEnd(sender: AnyObject) {
        confirmpassword.resignFirstResponder()
    }
    @IBAction func usernameEnd(sender: AnyObject) {
        userName.resignFirstResponder()
    }
    
    var accountKeyWrapper = KeychainItemWrapper(identifier: "account", accessGroup: serviceName)
    var passwordKeyWrapper = KeychainItemWrapper(identifier: "password", accessGroup: serviceName)
    
    
    var storedUsername = ""
    var storedPassword = ""
    
    var signUpSucceeded = false
    var error = EMError()
    var validCodeAnswer = ""
    
    func easeMobSignup()
    {
        EaseMob.sharedInstance().chatManager.asyncRegisterNewAccount(storedUsername, password: storedPassword, withCompletion: { (username, password, error) -> Void in
            self.emSignupCompleted(username, password: password, error: error)
        }, onQueue: nil)
    }
    
    func emSignupCompleted(username:String,password:String,error:EMError?)
    {
        if(error == nil)
        {
            NSLog("EM注册成功")
            //dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                //self.goMainVC()
           // })
        }
        else
        {
            
            NSLog("EM注册失败")
        }
    }
    
    
    func signup()
    {
        userName.text = "d"
        if validCode.text == ""
        {
            //showErrorMessage("验证码不能为空")
            //return
        }
        if validCode.text != validCodeAnswer
        {
            showErrorMessage("验证码错误")
            return
        }
        if password.text != confirmpassword.text
        {
            showErrorMessage("两次密码输入不同")
            return
        }
//        if userName.text == ""
//        {
//             showErrorMessage("用户名不能为空")
//            return
//        }
        storedUsername = mobile.text
        storedPassword = password.text
        if storedUsername == "" ||   storedPassword == ""
        {
            showEmptyAlert()
            return
        }
        //let parameters = NSDictionary(objects:[storedUsername,storedPassword], forKeys: ["phone","password"])
        DataClient().postSignup(storedUsername,password: storedPassword,code: validCode.text,name: userName.text){ (data, error) -> () in
            self.signupCompleted(data,error: error)
        }
    }
    
    func signupCompleted(data:NSDictionary?,error:NSError?)
    {
        
        if data!.objectForKey("errcode") as! Int == 0
        {
            NSLog("YL注册成功")
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
        let parameters = NSDictionary(objects:[storedUsername,storedPassword], forKeys: ["phone","password"])
        DataClient().postLogin(parameters) { (dict, error) -> () in
            self.loginCompleted(dict,error: error)
        }
    }
    
    func loginCompleted(dict:NSDictionary?,error:NSError?)
    {
        easeMobLogin()
            sessionId = dict!.objectForKey("sessionId") as! String
            myLawyerId = dict!.objectForKey("lawyerId") as! Int
        dispatch_sync(dispatch_get_main_queue(), { () -> Void in
            self.signUpSucceeded = true
            self.performSegueWithIdentifier("goRecommendedTopics", sender: self)
        })

    }
    
    
    func easeMobLogin()
    {
        EaseMob.sharedInstance().chatManager.asyncLoginWithUsername(storedUsername, password: storedPassword, completion: { (loginInfo, error) -> Void in
            if error == nil && loginInfo != nil
            {
                NSLog("登陆成功")
            }
            }, onQueue: nil)
    }
    
    
    
    
    func askValidCode()
    {
        
        DataClient().postSendMobile(mobile.text, type: 0) { (dict, error) -> () in
            self.askValdCodeCompleted(dict,error: error)
        }
        let av = UIAlertView(title: "", message: "验证码已发送", delegate: nil, cancelButtonTitle: "确认")
        av.show()
    }
    
    func askValdCodeCompleted(dict:NSDictionary?,error:NSError?)
    {
        
        validCodeAnswer = dict!.objectForKey("code") as! String
    }
    
    func saveAccountAndPassword()
    {
        accountKeyWrapper.setObject(storedUsername, forKey: kSecAttrService)
        passwordKeyWrapper.setObject(storedPassword, forKey: kSecAttrService)
        
        myAccount = storedUsername
    }
    
    func showEmptyAlert()
    {
        let av = UIAlertView(title: "", message: "手机或密码不能为空", delegate: nil, cancelButtonTitle: "取消")
        av.show()
    }
    
    func showErrorMessage(message :String)
    {
        let av = UIAlertView(title: "", message: message, delegate: nil, cancelButtonTitle: "取消")
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
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
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
