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
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.userInteractionEnabled = true
        let singleTap = UITapGestureRecognizer(target: self, action:Selector("tapped"))
        self.addGestureRecognizer(singleTap)
    }
    
    func tapped()
    {
        if isPushEnabled
        {
        let sourceVC = sourceViewController()
        if sourceVC != nil
        {
            let vc = UIStoryboard(name: "Messages", bundle: nil).instantiateViewControllerWithIdentifier("userVC") as! UserViewController
            vc.userId = userId
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
