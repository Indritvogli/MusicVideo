//
//  ViewController.swift
//  MusicVideo
//
//  Created by Indrit Vogli on 2/8/16.
//  Copyright © 2016 Indrit Vogli. All rights reserved.
//
//
import UIKit

class ViewController: UIViewController {
    var videos = [Videos]()

    @IBOutlet weak var displayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityStatusChanged", name: "ReachStatusChanged", object: nil)
        //Call API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json", complition:didLoadData)
        
        reachabilityStatusChanged()
        
        
        
    }

    func didLoadData(videos:[Videos]){
        print(reachabilityStatus)
        self.videos = videos
        for item in videos{
            print(" name = \(item.vName)")
        }
        for (index, item) in videos.enumerate() {
            print("\(index) name = \(item.vName)")
        }
     }
    
    func reachabilityStatusChanged() {
        switch reachabilityStatus {
        case NOACCES : view.backgroundColor = UIColor.redColor()
            displayLabel.text = "No Internet"
        case WIFi : view.backgroundColor = UIColor.greenColor()
            displayLabel.text = "Reachable with WIFI"
        case WWAN : view.backgroundColor = UIColor.yellowColor()
            displayLabel.text = "Reachable with Celular"
        default:return
        }
        
    }
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "reachabilityStatusChanged", object: nil)
    }

}
