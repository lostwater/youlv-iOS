//
//  TopicDetailTableViewController.swift
//  Youlv
//
//  Created by Lost on 26/01/2016.
//  Copyright © 2016 com.RamyTech. All rights reserved.
//


class TopicDetailTableViewController: UITableViewController {
    @IBOutlet var buttonView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        let h = 48 as CGFloat
        let ButtomHeight = scrollView.contentSize.height - self.tableView.frame.size.height;
        
        if (ButtomHeight-h <= scrollView.contentOffset.y && scrollView.contentSize.height > 0) {
            scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        } else  {
            scrollView.contentInset = UIEdgeInsetsMake(0, 0, -(h), 0);
        }
        
    }
    

}
