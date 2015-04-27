//
//  HomeNavigationController.swift
//  Youlv
//
//  Created by Lost on 12/04/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class HomeNavigationController: TranslucentNavController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        var homeStoryBoard = UIStoryboard(name:"Home",bundle:nil)
        var vc = homeStoryBoard.instantiateInitialViewController() as! UIViewController
        
    }
    

    
    func addDropDown()
    {
        var dropDown = DropDownListView();

        var dropDownButton = UIButton();
        dropDownButton.frame = CGRectMake(0,0,50,50);
        dropDownButton.backgroundColor = UIColor.blackColor();
        dropDownButton.setTitle("Add", forState: UIControlState.Normal);

        dropDown.center = navigationBar.center;
        dropDownButton.center = navigationBar.center;
        //self.navigationBar.addSubview(dropDown);
        //self.navigationBar.addSubview(dropDownButton);
        //self.view.addSubview(dropDown);
        //self.view.addSubview(dropDownButton);
        
        self.navigationItem.titleView = dropDown;

        //self.navigationItem.titleView = dropDownButton;

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
