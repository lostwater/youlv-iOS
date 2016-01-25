//
//  ReadingsTableViewController.swift
//  Youlv
//
//  Created by Lost on 27/04/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//
import UIKit

class ArticlesTableViewController: BaseTableViewController,NaviBarMenu {

    
    override func httpGet() {
        super.httpGet()
        httpClient.getArticleList { (dict, error) -> () in
            self.httpGetCompleted(dict, error: error)
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setNaviMenu()
        //AddNaviMenuToHome(naviMenuView!, titleButton!, self)
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
         tabBarController?.navigationItem.title = "文章"
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goArticleDetail"
        {
            let vc = segue.destinationViewController as! ArticleDetailViewController
            let selectedIndex = tableView.indexPathForSelectedRow?.item
            //var selectedData = dataArray.objectAtIndex(selectedIndex!) as! NSDictionary
            vc.dataDict = dataArray.objectAtIndex(selectedIndex!) as? NSDictionary
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ArticleCell", forIndexPath: indexPath) as! ArticleTableViewCell
        cell.configure(dataArray.objectAtIndex(indexPath.item) as! NSDictionary)
        return cell
        
    }
    
  

    
    let menuWidth : CGFloat = 180
    let menuHeight : CGFloat = 134
    
    var naviMenuView : UIView?
    var selectedTitle : String?
    var titleButton : UIButton?
    
    @IBOutlet var _naviMenuView: UIView!
    @IBOutlet var _titleButton: UIButton!
    
    @IBOutlet weak var menuButton0: UIButton!
    @IBOutlet weak var menuButton1: UIButton!
    @IBOutlet weak var menuButton2: UIButton!
    
    
    @IBAction func menuButtonClicked(sender: AnyObject) {
        setMenuTextAndHide(sender as! UIButton)
    }
    
    
    @IBAction func titleButtonClicked(sender: AnyObject) {
        showMenu(_naviMenuView)
    }
    
    
    
    func setMenuTextAndHide(selectedButton : UIButton)
    {
        menuButton0.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        menuButton1.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        menuButton2.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        selectedButton.setTitleColor(appBlueColor, forState: UIControlState.Normal)
        selectedTitle = selectedButton.titleForState(UIControlState.Normal)
        _titleButton.setTitle(selectedTitle, forState: UIControlState.Normal)
        setButtonIconToRight(_titleButton)
        _naviMenuView.hidden = true
    }
    
    
    func setNaviMenu()
    {
        setMenuLoc(_naviMenuView, view: view, menuWidth: menuWidth, menuHeight: menuHeight)
        
        naviMenuView = _naviMenuView
        selectedTitle = menuButton0.titleForState(UIControlState.Normal)
        setMenuTextAndHide(menuButton0)
        
        titleButton = _titleButton
        setButtonIconToRight(titleButton!)
        titleButton?.setTitle(selectedTitle , forState: UIControlState.Normal)
        
    }

}
