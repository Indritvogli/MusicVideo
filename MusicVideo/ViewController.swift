//
//  ViewController.swift
//  MusicVideo
//
//  Created by Indrit Vogli on 2/8/16.
//  Copyright © 2016 Indrit Vogli. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Call API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json", complition:didLoadData)
        
        
        
        
        
        
    }

    func didLoadData(result:String){
     
        let alert = UIAlertController(title: (result), message: nil , preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "ok", style: .Default) { (action) -> Void in
            // do Something
        }
        alert.addAction(okAction)
        self.presentViewController(alert, animated: true, completion: nil )
     }



}
