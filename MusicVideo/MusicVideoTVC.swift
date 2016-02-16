//
//  MusicVideoTVC.swift
//  MusicVideo
//
//  Created by Indrit Vogli on 2/10/16.
//  Copyright © 2016 Indrit Vogli. All rights reserved.
//

import UIKit

class MusicVideoTVC: UITableViewController {
    
    var videos = [Videos]()
    var limit  = 10
    
   
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityStatusChanged", name: "ReachStatusChanged", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "preferredFontChange", name: UIContentSizeCategoryDidChangeNotification, object: nil)
        reachabilityStatusChanged()
        
        }
    func preferredFontChange() {
        print("Prefered font Changed")
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
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.redColor()]
        title = ("The iTunes Top \(limit) Music Video")
        tableView.reloadData()
    }
    
    func reachabilityStatusChanged() {
      
        switch reachabilityStatus {
        case NOACCES :
           // view.backgroundColor = UIColor.redColor()
            dispatch_async(dispatch_get_main_queue()){
            let alert = UIAlertController(title: "No Internet Acces", message: "Please make sure you are connected to the Internet", preferredStyle: .Alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .Default) { action -> () in
                print("Cancel")
            }
            let deletwAction = UIAlertAction(title: "Delete", style: .Destructive) { action -> () in
                print("Delete")
            }
            
            let okAction = UIAlertAction(title: "OK", style: .Default){ action  -> Void in
            print("Ok")
            }
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            alert.addAction(deletwAction)
        self.presentViewController(alert, animated: true , completion: nil)
            }
        default:
           // view.backgroundColor = UIColor.greenColor()
            if videos.count > 0 {
                print(" do no refresh API")
            }
            else {
                runAPI()            }
        }
        
    }
    
    @IBAction func refresh(sender: UIRefreshControl) {
        
        refreshControl?.endRefreshing()
        runAPI()
        
        
    }
    
    
    
    
    
    
    func getAPICount() {
        if(NSUserDefaults.standardUserDefaults().objectForKey("APICNT") != nil )
        {
            let theValue = NSUserDefaults.standardUserDefaults().objectForKey("APICNT") as! Int
            limit = theValue
            
        }
        let formatter = NSDateFormatter()
        formatter.dateFormat = "E, dd MMM yyyy HH:mm:ss"
        let refreshDate = formatter.stringFromDate(NSDate())
        refreshControl?.attributedTitle = NSAttributedString(string: "\(refreshDate)")
    }
    
    
    
    
    func runAPI(){
        getAPICount()
        
        //Call API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=\(limit)/json", complition:didLoadData)
    }
    
    
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged", object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)

    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
                return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return videos.count
    }

    private struct stoyboard {
        static let cellReuseIndentifier = "cell"
        static let segueIndentifier = "musicDetail"
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(stoyboard.cellReuseIndentifier, forIndexPath: indexPath) as! MusicVideoTableViewCell

        cell.video = videos[indexPath.row]
        
        return cell
    }


    // Mark: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == stoyboard.segueIndentifier
        {
            if let indexpath = tableView.indexPathForSelectedRow {
                let video = videos[indexpath.row]
                let dvc = segue.destinationViewController as! MusicVideoDetailVC
                dvc.videos = video 
                
            }
        }
    }

}

