//
//  NewArticleTableViewController.swift
//  Youlv
//
//  Created by Lost on 28/04/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class NewArticleTableViewController: UITableViewController {

    @IBAction func buttonCancelClicked(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
