//
//  ImageListView.swift
//  Youlv
//
//  Created by Lost on 13/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import Foundation

class ImageListView: UIView
{

    func setImages(imageUrlList: NSArray)
    {
        let frameWidth = frame.size.width
        for sv in self.subviews
        {
            sv.removeFromSuperview()
            //let a = "1"=="22" || 1==1
        }
        for var i = 0 ; i < imageUrlList.count || CGFloat(i*60) > (frameWidth - 60); i++
        {
            let x = CGFloat(i)*60.0
            let f = CGRectMake(x, 0.0, 50.0, 50.0)
            var iv = UIImageView(frame: f)
            iv.sd_setImageWithURL(NSURL(string: imageUrlList.objectAtIndex(i) as! String  ))
            if (x + 120 > frameWidth && i < imageUrlList.count - 1)
            {
                iv.image = UIImage(named:"buttonmoremember")
            }
        }
    
    }
}