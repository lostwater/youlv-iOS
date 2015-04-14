    //
//  HomeViewController.swift
//  Youlv
//
//  Created by Lost on 12/04/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit
    protocol dDropDownChooseDelegate
    {
        
        var DropDownChooseDelegate:NSObject{get set}
        func chooseAtSection(section:NSInteger,	index i:NSInteger)
    }
    
   protocol  dDropDownChooseDataSource
   {
    var DropDownChooseDataSource:NSObject{get set}
    func numberOfSections() -> NSInteger
    func numberOfRowsInSection (section:NSInteger) -> NSInteger
    func titleInSection(section:NSInteger,index i:NSInteger)->String
    func defaultShowSection(section:NSInteger)->NSInteger


    }
   
    
class HomeTabBarController: TopTabBarController,DropDownChooseDataSource,DropDownChooseDelegate
{

    var dropDown : DropDownListView?
     var chooseArray = [["1","2"]]
    



    

    override func viewDidLoad() {
        super.viewDidLoad()
        addDropdown();
        setTabItems();
        //addCenterButton();

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setTabItems()
    {
        let normalimages = [
            UIImage(named: "buttonopportunityblack") as UIImage?,
            UIImage(named: "buttondiscussblack") as UIImage?,
            UIImage(named: "buttoneventblack") as UIImage?,
            UIImage(named: "buttonreadblack") as UIImage?,
        
        ]
        let selectedimages = [
            UIImage(named: "buttonopportunityblue") as UIImage?,
            UIImage(named: "buttondiscussblue") as UIImage?,
            UIImage(named: "buttoneventblue") as UIImage?,
            UIImage(named: "buttonreadblue") as UIImage?
        ]
        for var i = 0; i < viewControllers!.count; ++i
        {
            var vc = viewControllers![i] as! UIViewController
            vc.tabBarItem?.image = normalimages[i]! as UIImage
            vc.tabBarItem?.selectedImage = selectedimages[i]! as UIImage
            vc.tabBarItem.title = ""
        }
        tabBar.frame = CGRectMake(tabBar.frame.origin.x,tabBar.frame.origin.y,
        tabBar.frame.width,86)

    }
    
    func addDropdown()
    {
        self.title = "Home";
        let w : CGFloat = 200.0;
        if(navigationController != nil)
        {
        var x = navigationController!.navigationBar.frame.size.width - w;
        x = x/2;
        dropDown = DropDownListView(frame: CGRectMake(x,0, w, navigationController!.navigationBar.frame.height), dataSource:self, delegate:self);
        //dropDown?.center = navigationController!.navigationBar.center;
        dropDown!.mSuperView = self.view;
        //self.navigationController?.navigationBar.addSubview(dropDown!);
        //self.tabBarController?.navigationItem.titleView = dropDown;
        //self.tabBarController?.navigationController?.pushViewController(self, animated: false)
        self.tabBarController?.navigationController?.navigationBar.backgroundColor = UIColor.blueColor();
        }
        
        //self.navigationController?.navigationItem.titleView = dropDown;
    }
    
    func addCenterButton()
    {
        var centerButton = UIButton();
        centerButton.frame = CGRectMake(0,0,50,50);
        centerButton.backgroundColor = UIColor.blackColor();
        centerButton.setTitle("Add", forState: UIControlState.Normal);
        navigationItem.titleView=centerButton;
        self.tabBarController?.navigationItem.titleView = centerButton;
    }

    
    //pragma mark -- dropDownListDelegate
    func chooseAtSection(section:NSInteger,	index i:NSInteger)
    {
   
    }
    
    //pragma mark -- dropdownList DataSource
    func numberOfSections() -> NSInteger
    {
        return chooseArray.count;
    }
    func numberOfRowsInSection (section:NSInteger) -> NSInteger
    {
        var arry = chooseArray[section];
        return arry.count
    }
    func titleInSection(section:NSInteger,index i:NSInteger)->String
    {
        return chooseArray[section][i];
    }
    func defaultShowSection(section:NSInteger)->NSInteger
    {
    return 0;
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
