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
