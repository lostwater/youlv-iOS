//
//  Helper.swift
//  Youlv
//
//  Created by Lost on 28/04/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import Foundation

func setButtonIconToRight(button : UIButton)
{
    button.titleEdgeInsets = UIEdgeInsetsMake(0, -button.imageView!.frame.size.width,0,button.imageView!.frame.size.width)
    button.imageEdgeInsets = UIEdgeInsetsMake(0,button.titleLabel!.frame.size.width,0,-button.titleLabel!.frame.size.width)
}


func setMenuLoc(_naviMenuView : UIView, view : UIView, menuWidth : CGFloat, menuHeight : CGFloat)
{
    _naviMenuView.frame = CGRectMake((view.frame.size.width - menuWidth)/2, 0, menuWidth, menuHeight)
    _naviMenuView.hidden = true
    _naviMenuView.layer.zPosition = CGFloat(FLT_MAX)}


func showMenu(_naviMenuView : UIView)
{
    _naviMenuView.hidden = false
}



func AddNaviMenuToHome(naviMenuView : UIView, titleButton : UIButton, tabBarChildViewController : UIViewController)
{
    if(appNaviMenuView != nil)
    {
        appNaviMenuView?.removeFromSuperview()
    }
    appNaviMenuView = naviMenuView
    
    tabBarChildViewController.tabBarController?.navigationItem.titleView = titleButton
    tabBarChildViewController.tabBarController?.view.addSubview(appNaviMenuView!)
}

func calTextSizeWithDefualtFont(text : String, width : CGFloat) ->CGSize
{
        let textsize = text.boundingRectWithSize(CGSizeMake(width, CGFloat.max),
            options:NSStringDrawingOptions.UsesLineFragmentOrigin,
            attributes:[NSFontAttributeName:UIFont.systemFontOfSize(14)],
            context:nil)
    return CGSizeMake(width,textsize.height)
}

func calTextSizeWithDefualtFont(text : String, fontSize : CGFloat, width : CGFloat) ->CGSize
{
    let textsize = text.boundingRectWithSize(CGSizeMake(width, CGFloat.max),
        options:NSStringDrawingOptions.UsesLineFragmentOrigin,
        attributes:[NSFontAttributeName:UIFont.systemFontOfSize(fontSize)],
        context:nil)
    return CGSizeMake(width,textsize.height)
}

func calTextSizeWithDefaultSettings(text : String) ->CGSize
{
    let textsize = text.boundingRectWithSize(CGSizeMake(UIScreen().bounds.width -  32, CGFloat.max),
        options:NSStringDrawingOptions.UsesLineFragmentOrigin,
        attributes:[NSFontAttributeName:UIFont.systemFontOfSize(14)],
        context:nil)
    return CGSizeMake(textsize.width,textsize.height)
}

func resizeTextView(textView : UITextView) -> CGSize
{
    let textsize = textView.sizeThatFits(textView.frame.size)
    //textView.size
    
    textView.frame.size.height = textsize.height
    let cs = textView.constraints()
    cs.filter{
        let c = $0 as! NSLayoutConstraint
        if c.firstAttribute == NSLayoutAttribute.Height
        {
            return true
        }
        return false
    }
    if(cs.first != nil)
    {
        let constrainth = cs.first as! NSLayoutConstraint
        constrainth.constant = textsize.height + 16
    }
    return textsize
}

func collapseView(view: UIView)
{
    let cs = view.constraints()
    cs.filter{
        let c = $0 as! NSLayoutConstraint
        if c.firstAttribute == NSLayoutAttribute.Height
        {
            return true
        }
        return false
    }
    if(cs.first != nil)
    {
        let constraint = cs.first as! NSLayoutConstraint
        constraint.constant = 0
    }
}

func getHeightConstaint(view: UIView) ->CGFloat
{
    let cs = view.constraints()
    cs.filter{
        let c = $0 as! NSLayoutConstraint
        if c.firstAttribute == NSLayoutAttribute.Height
        {
            return true
        }
        return false
    }
    if(cs.first != nil)
    {
        let constraint = cs.first as! NSLayoutConstraint
        return constraint.constant
    }
    return 0
}


func dateToText(date : NSDate) -> String
{

    let now = NSDate()
    let difYears = now.year() - date.year()
    let difMonths = now.month() - date.month()
    let difDays = now.day() - date.day()
    let difHours = now.hour() - date.hour()
    let difMinutes = now.minute() - date.minute()
   
    
    let totalDifMins = (difDays * 24 * 60) + (difHours * 60) + difMinutes
    let totalDifHours : Int = totalDifMins / 60
    let totalDifDays : Int = totalDifHours / 24
    
    
    if totalDifDays > 0 || difMonths > 0 || difYears > 0
    {
        return defaultDateFormatter.stringFromDate(date)
    }
    if totalDifHours > 0

    {
        return String(totalDifHours) + "小时以前"
    }
    
    return "1小时内";
}


