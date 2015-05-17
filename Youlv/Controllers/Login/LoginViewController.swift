	//
//  LoginViewController.swift
//  Youlv
//
//  Created by Lost on 12/04/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var buttonOtherLogin: UIButton!
    @IBOutlet weak var buttonWeixin: UIButton!
    @IBOutlet weak var buttonWeibo: UIButton!
    
    var accountKeyWrapper = KeychainItemWrapper(identifier: "account", accessGroup: ".com.Ramy.Youlv")
     var passwordKeyWrapper = KeychainItemWrapper(identifier: "password", accessGroup: ".com.Ramy.Youlv")
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.navigationController?.navigationBar.backItem?.title = "";
        hideWeixinWeibo()
        var storedPassword = passwordKeyWrapper.objectForKey(kSecAttrService) as? String
        var storedAccount = accountKeyWrapper.objectForKey(kSecAttrService) as? String
        userAccount.text = storedAccount
        passowrd.text = storedPassword
        if userAccount.text == nil || passowrd.text == nil ||  userAccount.text=="" ||   passowrd.text == ""{
            return
        }
        login()
        //self.view.backgroundColor = UIColorFromRGB(0x00b1f1);

        //self.navigationController?.setNavigationBarHidden(true, animated: false)
        // Do any additional setup after loading the view.
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
    func login()
    {
        if userAccount.text == nil || passowrd.text == nil ||  userAccount.text=="" ||   passowrd.text == ""
        {
            showEmptyAlert()
            return
        }
        let parameters = NSDictionary(objects:[userAccount.text,passowrd.text], forKeys: ["phone","password"])
        DataClient().postLogin(parameters) { (data, error) -> () in
            self.loginCompleted(data,error: error)
                    }
    }
    
    func loginCompleted(data:NSDictionary?,error:NSError?)
    {
        accountKeyWrapper.setObject(userAccount.text, forKey: kSecAttrService)
        passwordKeyWrapper.setObject(passowrd.text, forKey: kSecAttrService)
        if data!.objectForKey("errcode") as! Int == 0
        {
            sessionId = data!.objectForKey("sessionId") as! String
        }
        dispatch_sync(dispatch_get_main_queue(), { () -> Void in
            self.goMainVC()
        })
        
    }
    
    func goMainVC()
    {
        var mainStoryBoard = UIStoryboard(name:"Main",bundle:nil)
        var mainViewController = mainStoryBoard.instantiateInitialViewController() as! UIViewController
        self.presentViewController(mainViewController,animated:true,completion:nil)

    }
    
    func showEmptyAlert()
    {
        let av = UIAlertView(title: "", message: "账号或密码为空", delegate: nil, cancelButtonTitle: "取消")
        av.show()
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
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
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
