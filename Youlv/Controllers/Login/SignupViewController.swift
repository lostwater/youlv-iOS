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
    var validToken = ""
    var validPhone = ""
    
    
    func signup()
    {
        userName.text = "youlv"
        if mobile.text == ""
        {
            showErrorMessage("请输入手机号")
            return
        }
        if validCode.text == ""
        {
            showErrorMessage("请输入验证码")
            return
        }
        //if validCode.text != validToken || mobile.text != validPhone
        //{
           // showErrorMessage("验证码错误")
            //return
        //}
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
        storedUsername = mobile.text!
        storedPassword = password.text!
        if storedUsername == "" ||   storedPassword == ""
        {
            showEmptyAlert()
            return
        }
        
        httpClient.register(storedUsername, password: storedPassword, token: validCode.text!) { (dict, error) -> () in
            self.registerCompleted(dict,error: error)
        }
    }
    
    func registerCompleted(dict:NSDictionary?,error:NSError?)
    {
            saveAccountAndPassword()
            login()
    }
    
    
    func login()
    {
        httpClient.login(storedUsername, password: storedPassword, completion: { (dict, error) -> () in
            self.loginCompleted(dict,error: error)
        })
    }
    

    func loginCompleted(dict:NSDictionary?,error:NSError?)
    {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
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
        httpClient.sendSMS(mobile.text!) { (dict, error) -> () in
            self.askValdCodeCompleted(dict,error: error)
        }
        
    }
    
    func askValdCodeCompleted(dict:NSDictionary?,error:NSError?)
    {
        //validToken = dict!.objectForKey("token") as! String
        //validPhone = dict!.objectForKey("phone") as! String
        let av = UIAlertView(title: "", message: "验证码已发送", delegate: nil, cancelButtonTitle: "确认")
        av.show()
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
