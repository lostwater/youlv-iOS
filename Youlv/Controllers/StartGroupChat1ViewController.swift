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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
