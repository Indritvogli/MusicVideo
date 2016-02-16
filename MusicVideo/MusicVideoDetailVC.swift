//
//  MusicVideoDetailVC.swift
//  MusicVideo
//
//  Created by Indrit Vogli on 2/11/16.
//  Copyright © 2016 Indrit Vogli. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
class MusicVideoDetailVC: UIViewController {
    
    var videos:Videos!
    
    

    @IBOutlet weak var vName: UILabel!
    
    @IBOutlet weak var videoImage: UIImageView!
    
    @IBOutlet weak var vGenre: UILabel!
    
    @IBOutlet weak var vPrice: UILabel!
    
    @IBOutlet weak var vRights: UILabel!
    
    
    func preferredFontChange () {
        vName.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        vPrice.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        vRights.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        vGenre.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "preferredFontChange", name: UIContentSizeCategoryDidChangeNotification, object: nil)
        title = videos.vArtist
        vName.text   = videos.vName
        vPrice.text  = videos.vPrice
        vRights.text = videos.vRights
        vGenre.text  = videos.vGenre
        
        if videos.vImageData != nil {
            videoImage.image = UIImage(data: videos.vImageData!)
        }
        else {
            videoImage.image  = UIImage(named: "imageNotAvailable")
        }
     
    }
    
    @IBAction func socialMedia(sender: UIBarButtonItem) {
        
        shareMedia()
    }
    
    func shareMedia() {
        let activity1 = "Have you had an opportunity to see this Music Video?"
        let activity2 = ("\(videos.vName) by \(videos.vArtist)")
        let activity3 = "Watch it and tell me what you think?"
        let activity4 = videos.vLinkToiTunes
        let activity5 = "(Shered with the Music Video App !)"
        
        let activityViewController : UIActivityViewController = UIActivityViewController(activityItems: [activity1,activity2,activity3,activity4,activity5], applicationActivities: nil)
        activityViewController.completionWithItemsHandler = {
            (activity, success, items, error ) in
            if activity == UIActivityTypeMail{
                print("email selected")
            }
        }
        self.presentViewController(activityViewController, animated: true, completion: nil)

    }
    
    @IBAction func playVideo(sender: UIBarButtonItem) {
        let url = NSURL(string: videos.vVideoUrl)!
        let player = AVPlayer(URL: url)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        
        self.presentViewController(playerViewController, animated: true) {
        playerViewController.player?.play()
        }
        
    }
    
    
    
    deinit
    {
       
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
        
    }


}
