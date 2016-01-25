//
//  KNSemiCustom.swift
//  Youlv
//
//  Created by Lost on 17/09/2015.
//  Copyright (c) 2015 com.RamyTech. All rights reserved.
//

import Foundation

extension UIViewController
{
    func presentSemiViewWithMyOptions(view:UIView)
    {
        self.presentSemiView(view, withOptions:["KNSemiModalOptionPushParentBack":false,
            "KNSemiModalOptionAnimationDuration" : 1.0,
            "KNSemiModalOptionKeysShadowOpacity"     : 0.3
        ])
        
    }
    
    func presentSemiViewControllerWithMyOptions(vc:UIViewController)
    {
        self.presentSemiViewController(vc,withOptions:["KNSemiModalOptionPushParentBack":false,
            "KNSemiModalOptionAnimationDuration" : 1.0,
            "KNSemiModalOptionKeysShadowOpacity"     : 0.3
            ])
        
    }
    

}