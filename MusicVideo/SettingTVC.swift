//
//  SettingTVC.swift
//  MusicVideo
//
//  Created by Indrit Vogli on 2/11/16.
//  Copyright © 2016 Indrit Vogli. All rights reserved.
//

import UIKit

class SettingTVC: UITableViewController {
    
    
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