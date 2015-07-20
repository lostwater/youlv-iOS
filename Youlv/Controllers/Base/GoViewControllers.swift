//
//  GoViewControllers.swift
//  Youlv
//
//  Created by Lost on 24/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import Foundation

extension UIViewController
{

func goMainVC()
{
    
    var sb = UIStoryboard(name:"Main",bundle:nil)
    var vc = sb.instantiateInitialViewController() as! UIViewController
    self.presentViewController(vc,animated:true,completion:nil)
    
}

func goRecommendTopics()
{
    var sb = UIStoryboard(name:"Login",bundle:nil)
    var vc = sb.instantiateViewControllerWithIdentifier("RecommendedTopicsVC") as! UIViewController
    self.navigationController?.pushViewController(vc,animated:true)
}
    
    
    
    
}