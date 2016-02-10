//
//  ViewController.swift
//  MusicVideo
//
//  Created by Indrit Vogli on 2/8/16.
//  Copyright © 2016 Indrit Vogli. All rights reserved.
//
//
import UIKit

class ViewController: UIViewController ,UITableViewDataSource, UITableViewDelegate {
    var videos = [Videos]()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var displayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityStatusChanged", name: "ReachStatusChanged", object: nil)
        reachabilityStatusChanged()
        
        //Call API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=50/json", complition:didLoadData)
        
        
        
        
        
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
        tableView.reloadData()
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
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return videos.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        let video = videos[indexPath.row]
        cell.textLabel?.text = ("\(indexPath.row + 1 )")
        cell.detailTextLabel?.text = video.vName
        return cell
    }
    
  
    
}
