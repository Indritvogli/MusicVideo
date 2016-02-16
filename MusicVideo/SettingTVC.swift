//
//  SettingTVC.swift
//  MusicVideo
//
//  Created by Indrit Vogli on 2/11/16.
//  Copyright © 2016 Indrit Vogli. All rights reserved.
//

import UIKit
import MessageUI

class SettingTVC: UITableViewController, MFMailComposeViewControllerDelegate{
    
    
    @IBOutlet weak var aboutDisplay: UILabel!
    
    @IBOutlet weak var feedBackDisplay: UILabel!
    

    @IBOutlet weak var securityDisplay: UILabel!
    
    
    @IBOutlet weak var touchID: UISwitch!
   
    
    @IBOutlet weak var bestImageDisplay: UILabel!
    
    @IBOutlet weak var APICnt: UILabel!
    
    @IBOutlet weak var sliderCnt: UISlider!
    
    @IBOutlet weak var numberOfMusicLabel: UILabel!
    
    @IBOutlet weak var dragSliderBelowLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         NSNotificationCenter.defaultCenter().addObserver(self, selector: "preferredFontChange", name: UIContentSizeCategoryDidChangeNotification, object: nil)
        
         tableView.alwaysBounceVertical = false
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.redColor()]
        title = "Settings"
       
        touchID.on = NSUserDefaults.standardUserDefaults().boolForKey("SecSetting")
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("APICNT") != nil)
        {
            let theValue = NSUserDefaults.standardUserDefaults().objectForKey("APICNT") as! Int
            APICnt.text = "\(theValue)"
            sliderCnt.value = Float(theValue)
        } else {
            sliderCnt.value = 10.0
            APICnt.text = ("\(Int(sliderCnt.value))")
        }
        
        
    }
    
    
   
    @IBAction func valueChangedSlider(sender: AnyObject) {
    
       let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(Int(sliderCnt.value), forKey: "APICNT")
        APICnt.text = ("\(Int(sliderCnt.value))")
    
    }
    
    @IBAction func touchIDSec(sender: UISwitch) {
        let defaults = NSUserDefaults.standardUserDefaults()
        if touchID.on {
            defaults.setBool(touchID.on , forKey: "SecSetting")
            
            
        } else {
            defaults.setBool(false, forKey: "SecSetting")
        }
        
    }
   override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    if indexPath.section == 0 && indexPath.row == 1 {
        let mailComposerViewController = configureMail()
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposerViewController, animated: true, completion: nil)
            
        } else {
            //No Mail
            mailAlert()
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
       }
    }
    
    func configureMail() -> MFMailComposeViewController {
        
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self
        mailComposeVC.setToRecipients(["Ivogli00@gmail.com"])
        mailComposeVC.setSubject("Music Video App FeedBack")
        mailComposeVC.setMessageBody("Hi IndRit,\n\nI Would Like to Share the following feddback....\n", isHTML: false)
        return mailComposeVC
    
    }
    
    func mailAlert() {
        let alertController: UIAlertController = UIAlertController(title: "Alert", message: "No e-Mail Account setup for Phone", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default) { (action) -> Void in
          
        }
            
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        switch result.rawValue{
        case MFMailComposeResultCancelled.rawValue:
            print("Mail Canceled")
        case MFMailComposeResultSaved.rawValue:
            print("Mail Saved")
        case MFMailComposeResultSent.rawValue:
            print("Mail Sent")
        case MFMailComposeResultFailed.rawValue:
            print("Mail Failed")
        default:
            print("Unknown Issue")
        }
        self.dismissViewControllerAnimated(true, completion: nil )
    }
    
    
    
    
    func preferredFontChange() {
        aboutDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        feedBackDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        securityDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        bestImageDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        APICnt.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        numberOfMusicLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        dragSliderBelowLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleFootnote)
    }
    
    
    
    
    
    
    
    
    
    
    deinit
    {
      NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
        
    }


}