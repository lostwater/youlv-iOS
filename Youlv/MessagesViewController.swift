//
//  MessagesViewController.swift
//  Youlv
//
//  Created by Lost on 13/04/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class MessagesViewController: UIViewController {


    @IBOutlet weak var newChatMenuView: UIView!
    @IBOutlet var UITapGR: UITapGestureRecognizer!
    @IBOutlet weak var newChatMenuButton: UIBarButtonItem!
    @IBAction func newChatMenuButtonClicked(sender: AnyObject) {
        newChatMenuView.hidden = false;
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func viewTapped(sender: AnyObject) {
        newChatMenuView.hidden = true;
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
