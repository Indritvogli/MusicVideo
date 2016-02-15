//
//  MusicVideos.swift
//  MusicVideo
//
//  Created by Indrit Vogli on 2/8/16.
//  Copyright © 2016 Indrit Vogli. All rights reserved.
//

import Foundation

class Videos
{
    
    var vRank = 0
    //Data Encapsulations
    
    private var _vName:String
    private var _vRights:String
    private var _vPrice:String
    private var _vImageUrl:String
    private var _vArtist:String
    private var _vVideoUrl:String
    private var _vImid:String
    private var _vGenre:String
    private var _vLinkToiTunes:String
    private var _vReleseDate :String
    
    //This variable gets created from the UI
    var vImageData:NSData?
    
    //Make a getter
    
    var vName:String {
        return _vName
    }
    var vRights:String {
        return _vRights
    }
    var vPrice:String {
        return _vPrice
    }
    var vImageUrl:String {
        return _vImageUrl
    }
    var vArtist:String {
        return _vArtist
    }
    var vVideoUrl:String {
        return _vVideoUrl
    }
    var vImid:String {
        return _vImid
    }
    var vGenre:String {
        return _vGenre
    }
    var vLinkToiTunes:String {
        return _vLinkToiTunes
    }
    var vReleseDate:String {
        return _vReleseDate
    }
    init(data :JSONDictionary){
    //Video name
        if let name = data["im:name"] as? JSONDictionary,
            vName = name["label"] as? String{
                self._vName = vName
        }
        else
        {
            _vName = ""
        }
    // The Video Image
        if let img = data["im:image"] as? JSONArray,
        image = img[2] as? JSONDictionary,
            immage = image["label"] as? String{
                self._vImageUrl = immage.stringByReplacingOccurrencesOfString("100x100", withString: "600x600")
        }
        else
        {
            _vImageUrl = ""
        }
    
    //Video Url
        if let video = data["link"] as? JSONArray,
        vUrl = video[1] as? JSONDictionary,
        vHref = vUrl["attributes"] as? JSONDictionary,
            vVideoUrl = vHref["href"] as? String {
                self._vVideoUrl = vVideoUrl
        }
        else
        {
            _vVideoUrl = ""
        }
     
    //Rights
        if let rights = data["rights"] as? JSONDictionary,
            vRights = rights["label"] as? String {
                self._vRights = vRights
        }
        else
        {
            _vRights = ""
        }
        
    //Price
        if let price = data["im:price"] as? JSONDictionary,
            vPrice = price["label"] as? String {
                self._vPrice = vPrice
        }
        else
        {
            _vPrice = ""
        }
    //Artist
        if let artist = data["im:artist"] as? JSONDictionary,
            vArtist = artist["label"] as? String {
                self._vArtist = vArtist
        }
        else
        {
            _vArtist = ""
        }
    //Imid
        if let idItunes = data["id"] as? JSONDictionary,
        vidItunes = idItunes["attributes"] as? JSONDictionary,
        vImid = vidItunes["im:id"] as? String {
            self._vImid = vImid
        }
        else
        {
            _vImid = ""
        }
    //Genre
        if let genre = data["category"] as? JSONDictionary,
        genres = genre["attributes"] as? JSONDictionary,
            vGenre = genres["term"] as? String {
                self._vGenre = vGenre
        }
        else
        {
            _vGenre = ""
        }
    //LinkToiTunes
        if let linkToiTunes = data["id"] as? JSONDictionary,
            vLinkToiTunes = linkToiTunes["label"] as? String {
                self._vLinkToiTunes = vLinkToiTunes
        }
        else
        {
            _vLinkToiTunes = ""
        }
    //ReleseDate
        if let releseDate = data["im:releaseDate"] as? JSONDictionary,
        releseDates = releseDate["attributes"] as? JSONDictionary,
            vReleseDate = releseDates["label"] as? String{
                self._vReleseDate = vReleseDate
        }
        else
        {
            _vReleseDate = ""
        }
}
}



