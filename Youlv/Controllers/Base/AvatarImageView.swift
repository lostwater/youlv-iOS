//
//  AvatarImageView.swift
//  Youlv
//
//  Created by Lost on 21/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//


class AvatarImageView: UIImageView {
    
    var userId = 0
    var isPushEnabled = true
    var userDict : NSDictionary?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.userInteractionEnabled = true
        let singleTap = UITapGestureRecognizer(target: self, action:Selector("tapped"))
        self.addGestureRecognizer(singleTap)
        layer.cornerRadius = self.frame.height/2
        
    }
    
    func tapped()
    {
        if isPushEnabled
        {
        let sourceVC = sourceViewController()
        if sourceVC != nil
        {
            let vc = UIStoryboard(name: "User", bundle: nil).instantiateViewControllerWithIdentifier("userVC") as! UserHomeTableViewController
            vc.userId = userId
            vc.userDict = userDict
            sourceVC!.navigationController?.pushViewController(vc, animated:true)
        }
        }
    }
    
    func sourceViewController() -> UIViewController?
    {
        for var next = self.superview; next != nil ; next = next?.superview
        {
            let nextResponder = next?.nextResponder()
            if nextResponder!.isKindOfClass(UIViewController.classForCoder())
            {
                return nextResponder as? UIViewController
            }
        }
        return nil
    }
    
    

}
