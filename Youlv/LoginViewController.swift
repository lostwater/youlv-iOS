	//
//  LoginViewController.swift
//  Youlv
//
//  Created by Lost on 12/04/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
         self.navigationController?.navigationBar.backItem?.title = "";
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
        var mainStoryBoard = UIStoryboard(name:"Main",bundle:nil)
        var mainViewController = mainStoryBoard.instantiateInitialViewController() as! UIViewController
        self.presentViewController(mainViewController,animated:true,completion:nil)
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
