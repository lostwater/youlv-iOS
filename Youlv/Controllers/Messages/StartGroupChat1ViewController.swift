	//
//  StartGroupChat1ViewController.swift/Users/Lost/Documents/Xcode Projects/Youlv/Youlv/Controllers/StartGroupChat1ViewController.swift
//  Youlv
//
//  Created by Lost on 17/04/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class StartGroupChat1ViewController : UIViewController ,FSMediaPickerDelegate {

    @IBOutlet weak var groupPicButton: UIButton!
    @IBOutlet weak var groupName: UITextField!
    @IBOutlet weak var groupIntro: UITextField!
    @IBAction func nextClicked(sender: AnyObject) {
    }

    @IBAction func groupNameEnd(sender: AnyObject) {
        groupName.resignFirstResponder()
        groupIntro.becomeFirstResponder()
    }
    
    @IBAction func groupIntroEnd(sender: AnyObject) {
        groupIntro.resignFirstResponder()
    }
    
    
    var groupPic:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func uploadPicClicked(sender: AnyObject) {
        var mediaPicker = FSMediaPicker();
        mediaPicker.mediaType = FSMediaTypePhoto
        mediaPicker.editMode = FSEditModeCircular
        mediaPicker.delegate = self;
        mediaPicker.showFromView(sender as! UIView);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func mediaPicker(mediaPicker: FSMediaPicker!, didFinishWithMediaInfo mediaInfo: [NSObject : AnyObject]!) {
        var m = mediaInfo as NSDictionary;
        groupPic =  m.circularEditedImage;
        groupPicButton.setImage(groupPic, forState: UIControlState.Normal)
    }
    
    func mediaPicker(mediaPicker: FSMediaPicker!, willPresentImagePickerController imagePicker: UIImagePickerController!) {

    }
    
    func mediaPickerDidCancel(mediaPicker: FSMediaPicker!) {
        
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if identifier == "goGroupOptions"
        {
            let gn : String = groupName.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            if gn == ""
            {
                let av = UIAlertView(title: nil, message: "群名不能为空", delegate: nil, cancelButtonTitle: "确认")
                av.show()
                return false
            }
        }
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goGroupOptions"
        {
            let vc = segue.destinationViewController as! StartGroupChat2ViewController
            vc.groupName = groupName.text
            vc.groupDesc = groupIntro.text
            vc.groupPic = groupPic
        }
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
