//
//  PrivateChatViewController.swift
//  Youlv
//
//  Created by Lost on 22/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//



class PrivateChatViewController: ChatViewController {
    
    override func headImageDidClick(cell: UUMessageCell!, userId: String!)
    {
            let vc = UIStoryboard(name: "Messages", bundle: nil).instantiateViewControllerWithIdentifier("userVC") as! UserViewController
            vc.userId = 1
            self.navigationController?.pushViewController(vc, animated:true)
    }
    
    

}
