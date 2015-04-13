//
//  RecommenedViewController.swift
//  Youlv
//
//  Created by Lost on 14/04/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class RecommenedViewController: UIViewController {

    @IBOutlet weak var BtnNext: UIButton!
    @IBOutlet weak var BtnSkip: UIButton!
    @IBOutlet weak var BottomBarImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        doLayout();
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func doLayout()
        
    {
        var bv = UIView()
        self.navigationController?.navigationBar.backItem?.backBarButtonItem?.target = nil;
                var starty = BottomBarImageView.frame.origin.y;
        var endy = starty + BottomBarImageView.frame.height;
        var cnetery = (starty+endy)/2;
        var centerx = BottomBarImageView.frame.width/2;
        var centerx1 = centerx/2;
        var centerx2 = centerx/2+centerx;
        var b1frame = CGRectMake(0,starty,centerx,BottomBarImageView.frame.height);
        var b2frame = CGRectMake(centerx,starty,centerx,BottomBarImageView.frame.height);
        //BtnNext.setTitle("test", forState: UIControlState.Normal)
        
        var NewBtnSkip = UIButton(frame: b1frame);
        var NewBtnNext = UIButton();
        NewBtnNext.setTitle("下12一步", forState: UIControlState.Normal);

        BottomBarImageView.addSubview(NewBtnNext)    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
