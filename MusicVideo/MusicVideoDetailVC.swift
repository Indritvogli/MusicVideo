//
//  MusicVideoDetailVC.swift
//  MusicVideo
//
//  Created by Indrit Vogli on 2/11/16.
//  Copyright © 2016 Indrit Vogli. All rights reserved.
//

import UIKit

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
    deinit
    {
       
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
        
    }


}
