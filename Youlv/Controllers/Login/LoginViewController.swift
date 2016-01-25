				//
//  LoginViewController.swift
//  Youlv
//
//  Created by Lost on 12/04/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,MYIntroductionDelegate {

    @IBOutlet weak var buttonOtherLogin: UIButton!
    @IBOutlet weak var buttonWeixin: UIButton!
    @IBOutlet weak var buttonWeibo: UIButton!
    
    //@IBOutlet var finalIntroPanel: MYIntroductionPanel!
    @IBOutlet var introPanel1: MYIntroductionPanel!
    @IBOutlet var introPanel2: MYIntroductionPanel!
    @IBOutlet var introPanel3: MYIntroductionPanel!
    @IBOutlet var introPanel4: MYIntroductionPanel!
    @IBOutlet var introPanel5: MYIntroductionPanel!
    
    
    @IBOutlet weak var introButtonLogin: UIButton!
    @IBOutlet weak var introButtonSignup: UIButton!
    @IBOutlet weak var introButton: UIButton!
    
    @IBAction func introButtonClicked(sender: AnyObject) {
        introView.hidden = true
        navigationItem.rightBarButtonItem?.title = "注册"
        navigationController?.navigationBar.translucent = false
        
        tryAutoLogin()
    }
    
    @IBAction func introButtonSignupClicked(sender: AnyObject) {
        performSegueWithIdentifier("goSignUp", sender: sender)
        navigationController?.navigationBar.translucent = false
    }
    
    
    @IBAction func introButtonLoginClicked(sender: AnyObject) {
        introView.hidden = true
        navigationItem.rightBarButtonItem?.title = "注册"
        navigationController?.navigationBar.translucent = false
    }
    
    @IBAction func passwordTextFieldEnd(sender: AnyObject) {
        passowrd.resignFirstResponder()
        //login()
    }
    
    func passwordTextFieldEnd()
    {
        passowrd.resignFirstResponder()
    }
    
    @IBAction func accountTextFieldEnd(sender: AnyObject) {
        userAccount.resignFirstResponder()
        passowrd.becomeFirstResponder()
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var BtnLogin: UIButton!

    @IBAction func BtnLoginClicked(sender: AnyObject) {
        login()
    }
    
    @IBAction func buttonOtherLoginClicked(sender: AnyObject) {
        showWeixinWeibo()
    }
    
    @IBOutlet var passowrd: UITextField!
    @IBOutlet var userAccount: UITextField!
    
    //var returnKeyHandler : IQKeyboardReturnKeyHandler?

    var storedPassword : String?
    var storedAccount : String?
    
    var accountKeyWrapper = KeychainItemWrapper(identifier: "account", accessGroup: serviceName)
    var passwordKeyWrapper = KeychainItemWrapper(identifier: "password", accessGroup: serviceName)
    
    
    var introView = MYBlurIntroductionView()

    override func viewDidLoad() {
         //self.goMainVC()
        
        //HTTPClient().login("18917566917", password: "qwer1234") { (dict, error) -> () in }
        
        super.viewDidLoad()
        self.navigationController?.navigationBar.backItem?.title = "";
        passowrd.setValue(UIColor.whiteColor(), forKeyPath: "_placeholderLabel.textColor")
        userAccount.setValue(UIColor.whiteColor(), forKeyPath: "_placeholderLabel.textColor")
        //hideWeixinWeibo()
        hideAll()
        
        passowrd.addDoneOnKeyboardWithTarget(self, action:"passwordTextFieldEnd")
        //returnKeyHandler = IQKeyboardReturnKeyHandler(viewController: self)
        userDefaults = NSUserDefaults()
        //let key = userDefaults.boolForKey("firstUse")

        if userDefaults.stringForKey("lastRunVersion") != majorVersion
        {
            navigationItem.rightBarButtonItem?.title = ""
            setIntro()
            userDefaults.setObject(majorVersion, forKey: "lastRunVersion")
            userDefaults.synchronize()
        }
        else
        {
            tryAutoLogin()
        }
        
    }
    
    func tryAutoLogin()
    {
        storedPassword = passwordKeyWrapper.objectForKey(kSecAttrService) as? String
        storedAccount = accountKeyWrapper.objectForKey(kSecAttrService) as? String
        
        userAccount.text = storedAccount
        passowrd.text = storedPassword
        if userAccount.text == nil || passowrd.text == nil ||  userAccount.text=="" ||   passowrd.text == ""{
            return
        }
        else
        {
            login()
        }

    }
    
    
    
    func login()
    {
        if userAccount.text == nil || passowrd.text == nil ||  userAccount.text=="" ||   passowrd.text == ""
        {
            showEmptyAlert()
            return
        }
        httpClient.login(userAccount.text!, password: passowrd.text!, completion: { (dict, error) -> () in
            self.loginCompleted(dict,error: error)
        })
    }
    
    func loginCompleted(dict:NSDictionary?,error:NSError?)
    {
        
        //easeMobLogin()
        saveAccountAndPassword()
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.goMainVC()
        })
        
    }
    
    func easeMobLogin()
    {
        EaseMob.sharedInstance().chatManager.asyncLoginWithUsername(userAccount.text, password: passowrd.text, completion: { (loginInfo, error) -> Void in
            if error == nil && loginInfo != nil
            {
                NSLog("登陆成功")
            }
        }, onQueue: nil)
    }
    
    
    func loadAccountAndPassword() throws
    {
        if (try SFHFKeychainUtils.getPasswordForUsername("", andServiceName: serviceName) != "")
        {
            NSLog("密码读取成功")
        }
    }
    
    func saveAccountAndPassword()
    {
        let error = NSErrorPointer()
        do {
            try SFHFKeychainUtils.storeUsername(userAccount.text, andPassword: passowrd.text, forServiceName: serviceName, updateExisting: true)
            NSLog("密码保存成功")
        } catch let error1 as NSError {
            error.memory = error1
        }
        
        accountKeyWrapper.setObject(userAccount.text, forKey: kSecAttrService)
        passwordKeyWrapper.setObject(passowrd.text, forKey: kSecAttrService)
        
        myAccount = userAccount.text!

    }

    
    func showEmptyAlert()
    {
        let av = UIAlertView(title: "", message: "账号或密码为空", delegate: nil, cancelButtonTitle: "取消")
        av.show()
    }
    
    func hideAll()
    {
        buttonOtherLogin.hidden = true
        buttonWeixin.hidden = true
        buttonWeibo.hidden = true
    }
    
    func hideWeixinWeibo()
    {
        buttonOtherLogin.hidden = false
        buttonWeixin.hidden = true
        buttonWeibo.hidden = true
    }
    
    func showWeixinWeibo()
    {
        buttonOtherLogin.hidden = true
        buttonWeixin.hidden = false
        buttonWeibo.hidden = false
    }
    
    func setIntro()
    {
        navigationController?.navigationBar.translucent = true
        let fullFrame = UIScreen.mainScreen().bounds
        introView = MYBlurIntroductionView(frame: fullFrame)
        let introPanels = [introPanel1,introPanel2,introPanel3,introPanel4,introPanel5]
        introView.buildIntroductionWithPanels(introPanels)
        introView.backgroundColor = UIColor.whiteColor()
        introView.PageControl.hidden = true
        introView.LeftSkipButton.hidden = true
        introView.RightSkipButton.hidden = true
        introView.delegate = self
        self.view.addSubview(introView)
    }
    
    func introduction(introductionView: MYBlurIntroductionView!, didChangeToPanel panel: MYIntroductionPanel!, withIndex panelIndex: Int) {
        
    }
    
    func introduction(introductionView: MYBlurIntroductionView!, didFinishWithType finishType: MYFinishType) {
        navigationController?.navigationBar.translucent = false
        tryAutoLogin()
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
