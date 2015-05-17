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
    }
    @IBOutlet var sendButton: UIButton!
    
    @IBOutlet var sendButtonClicked: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
