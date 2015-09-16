//
//  NewViewController.swift
//  Youlv
//
//  Created by Lost on 12/04/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class NewViewController: UIViewController {


    @IBAction func buttonNewOpClicked(sender: AnyObject) {
        //dismissViewControllerAnimated(false, completion: { () -> Void in
            self.gotoVC("NewOpNC")
        //})
        
    }
    @IBAction func buttonNewTopicClicked(sender: AnyObject) {
        gotoVC("NewTopicNC")
    }
    @IBAction func buttonNewArticleClicked(sender: AnyObject) {
        gotoVC("NewArticleNC")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var BtnClose: UIButton!
    
    @IBAction func BtnCloseClicked(sender: AnyObject) {
        //self.dismissViewControllerAnimated(false,completion:nil);
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true;
    }
    
    func gotoVC(name: String)
    {
        let storyboard = UIStoryboard(name: "NewPublish", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier(name) as! UIViewController
        MainTabBarController.redirectViewController = vc

        let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! MainTabBarController
        //let this =
        //self.pres
        self.dismissViewControllerAnimated(false, completion: { () -> Void in
                        //self.presentViewController(vc, animated: true, completion: nil)
        })

        //self.presentViewController(vc, animated: true, completion:nil)
        //self.view.hidden = true
        
    }
    
    func selfDismiss()
    {
        self.dismissViewControllerAnimated(false,completion:nil)
        
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
