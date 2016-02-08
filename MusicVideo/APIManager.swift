//
//  APIManager.swift
//  MusicVideo
//
//  Created by Indrit Vogli on 2/8/16.
//  Copyright © 2016 Indrit Vogli. All rights reserved.
//

import Foundation

class APIManager {
    
    func loadData(urlString:String , complition: (result:String) -> Void){
        
       let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
       
        let session  = NSURLSession(configuration: config)
        
       // let session = NSURLSession.sharedSession()
        let url = NSURL(string: urlString)!
        
        let task = session.dataTaskWithURL(url) {
             (data, response, error) -> Void in
           
                if error != nil {
                     dispatch_async(dispatch_get_main_queue()) {
                    complition(result: (error!.localizedDescription))
                    }
                } else {
                 
                    //Added for JSONSerialization
                    //print(data)
                    do {
                        
                        
                        if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as?[String: AnyObject] {
                            
                            print(json)
                            let priority = DISPATCH_QUEUE_PRIORITY_HIGH
                            dispatch_async(dispatch_get_global_queue(priority , 0)){
                                dispatch_async(dispatch_get_main_queue()){
                                complition(result: "JSONSerialization Succesfull")
                            }
                        }
                    }
            } catch {
                dispatch_async(dispatch_get_main_queue()){
                 complition(result: "error in NSJSerializations")
                }
            }
            
            //end of jsonSerialization
        }
    }
    task.resume()
}

                
                
}