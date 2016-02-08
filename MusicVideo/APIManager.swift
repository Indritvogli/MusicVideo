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
            dispatch_async(dispatch_get_main_queue()){
                if error != nil {
                    complition(result: (error!.localizedDescription))
                } else {
                    complition(result: "NSURLSession Succesfull")
                    print(data)
                }
                
            }
        }
    
    task.resume()
    
          }
}