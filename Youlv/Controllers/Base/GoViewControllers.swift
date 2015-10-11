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
    
    let sb = UIStoryboard(name:"Main",bundle:nil)
    let vc = sb.instantiateInitialViewController()! as UIViewController
    self.presentViewController(vc,animated:true,completion:nil)
    
}

func goRecommendTopics()
{
    let sb = UIStoryboard(name:"Login",bundle:nil)
    let vc = sb.instantiateViewControllerWithIdentifier("RecommendedTopicsVC") 
    self.navigationController?.pushViewController(vc,animated:true)
}
    
    
    
    
}