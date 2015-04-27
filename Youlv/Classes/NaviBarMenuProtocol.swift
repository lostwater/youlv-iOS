//
//  NaviBarMenuProtocol.swift
//  Youlv
//
//  Created by Lost on 27/04/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import Foundation
import UIKit


protocol NaviBarMenu
{
    var naviMenuView : UIView?{get set}
    var selectedTitle : String?{get set}
    var titleButton : UIButton?{get set}
}