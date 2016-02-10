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
    
   
    @IBOutlet weak var displayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
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
        //displayLabel.text = "No Internet"
        case WIFi : view.backgroundColor = UIColor.greenColor()
      //  displayLabel.text = "Reachable with WIFI"
        case WWAN : view.backgroundColor = UIColor.yellowColor()
       // displayLabel.text = "Reachable with Celular"
        default:return
        }
        
    }
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "reachabilityStatusChanged", object: nil)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return videos.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

        let video = videos[indexPath.row]
        cell.textLabel?.text = ("\(indexPath.row + 1 )")
        cell.detailTextLabel?.text = video.vName
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
