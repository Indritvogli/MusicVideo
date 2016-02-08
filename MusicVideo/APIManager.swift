//
//  APIManager.swift
//  MusicVideo
//
//  Created by Indrit Vogli on 2/8/16.
//  Copyright © 2016 Indrit Vogli. All rights reserved.
//

import Foundation

class APIManager {
    
    func loadData(urlString:String , complition: [Videos] -> Void){
        
       let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
       
        let session  = NSURLSession(configuration: config)
        
       // let session = NSURLSession.sharedSession()
        let url = NSURL(string: urlString)!
        
        let task = session.dataTaskWithURL(url) {
             (data, response, error) -> Void in
           
                if error != nil {
                    
                    print(error!.localizedDescription)
                    
                } else {
                 
                    //Added for JSONSerialization
                    //print(data)
                    do {
                        
                        
                        if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? JSONDictionary,
                            feed = json["feed"] as? JSONDictionary,
                            entries = feed["entry"] as? JSONArray {
                                var videos = [Videos]()
                                for entry in entries {
                                    let entry = Videos(data: entry as! JSONDictionary)
                                    videos.append(entry)
                                }
                                let i = videos.count
                                print("iTunes ApiManager - total count --> \(i)")
                                print("   ")
                        
                        
                          
                            let priority = DISPATCH_QUEUE_PRIORITY_HIGH
                            dispatch_async(dispatch_get_global_queue(priority , 0)){
                                dispatch_async(dispatch_get_main_queue()){
                                complition(videos)
                            }
                        }
                    }
            } catch {
               
                 print("error in NSJSerializations")
                }
            }
            
            //end of jsonSerialization
        }
    
    task.resume()
}

                
                
}