//
//  HomeBizVC.swift
//  Youlv
//
//  Created by Lost on 12/04/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class HomeBizVC: UIViewController  {

    override func viewDidLoad() {
        super.viewDidLoad()
        if self.navigationController? != nil
        {
        var frame = CGRectMake(0.0, 0.0, 200.0, self.navigationController!.navigationBar.bounds.size.height);
           // var menu = SINavigationMenuView(frame: frame,title: "Menu");
          //  menu.displayMenuInView(self.view);
          //  let items = ["News","Top"];
           // menu.items = items;
        //menu.delegate = self;
        //self.navigationItem.titleView = menu;
        }

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
