//
//  ViewController.swift
//  MusicVideo
//
//  Created by Indrit Vogli on 2/8/16.
//  Copyright © 2016 Indrit Vogli. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var videos = [Videos]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Call API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json", complition:didLoadData)
        
        
        
        
        
    }

    func didLoadData(videos:[Videos]){
        self.videos = videos
        for item in videos{
            print(" name = \(item.vName)")
        }
        for (index, item) in videos.enumerate() {
            print("\(index) name = \(item.vName)")
        }
     }

}
