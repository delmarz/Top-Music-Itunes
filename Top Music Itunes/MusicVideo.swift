//
//  MusicVideo.swift
//  Top Music Itunes
//
//  Created by Israel Mayor on 15/10/2016.
//  Copyright © 2016 Team Delmarz. All rights reserved.
//

import Foundation

class MusicVideo {
    
    var rank = 0
    
    // Data Encapsulation
    
    private var _videoName: String
    private var _videoImageURL: String
    private var _videoURL: String
    
    private var _videoRights: String
    private var _videoPrice: String
    private var _videoArtist: String
    private var _videoimID: String
    private var _videoGenre: String
    private var _videoLinkToItunes: String
    private var _videoReleaseDate: String
   
    var videoImageData: Data?
    
    // Getter
    
    var videoName: String {
        return _videoName
    }
    
    var videoImageURL: String {
        return _videoImageURL
    }
    
    var videoURL: String {
        return _videoURL
    }
    
    var videoRights: String {
        return _videoRights
    }
    
    var videoPrice: String {
        return _videoPrice
    }
    
    var videoArtist: String {
        return _videoArtist
    }
    
    var videoGenre: String {
        return _videoGenre
    }
    
    var videoLinkToItunes: String {
        return _videoLinkToItunes
    }
    
    var videoReleaseDate: String {
        return _videoReleaseDate
    }
    
    
    init(data: JSONDictionary) {
        
        // _videoName
        
        if let videoName = data["im:name"] as? JSONDictionary,
            let videoNamee = videoName["label"] as? String {
            self._videoName = videoNamee
        } else {
            _videoName = ""
        }
        
        // _videoImageURL
        
        if let videoImageURL = data["im:image"] as? JSONArray,
            let videoImageURLL = videoImageURL[2] as? JSONDictionary,
            let videoImageURLLL = videoImageURLL["label"] as? String {
            self._videoImageURL = videoImageURLLL.replacingOccurrences(of: "100x100", with: "600x600")
        } else {
            self._videoImageURL = ""
        }
        
        // _videoURL
        
        if let videoURL = data["link"] as? JSONArray,
            let videoURLL = videoURL[1] as? JSONDictionary,
            let videoURLLL = videoURLL["attributes"] as? JSONDictionary,
            let videoURLLLL = videoURLLL["href"] as? String {
            self._videoURL = videoURLLLL
        } else {
            self._videoURL = ""
        }
        
        // _videoRights
        
        if let videoRights = data["rights"] as? JSONDictionary,
            let videoRightss = videoRights["label"] as? String {
            self._videoRights = videoRightss
        } else {
            self._videoRights = ""
        }
        
        // _videoPrice
        
        if let videoPrice = data["im:price"] as? JSONDictionary,
            let videoPricee = videoPrice["label"] as? String {
            self._videoPrice = videoPricee
        } else {
            self._videoPrice = ""
        }
        
        // _videoArtist
        
        if let videoArtist = data["im:artist"] as? JSONDictionary,
            let videoArtists = videoArtist["label"] as? String {
            self._videoArtist = videoArtists
        } else {
            self._videoArtist = ""
        }
        
        // _videoimID
        
        if let videoimID = data["id"] as? JSONDictionary,
            let videoimIDD = videoimID["attributes"] as? JSONDictionary,
            let videoimIDDD = videoimIDD["im:id"] as? String {
            self._videoimID = videoimIDDD
        } else {
            self._videoimID = ""
        }
        
        
        // _videoGenre
        
        if let videoGenre = data["category"] as? JSONDictionary,
            let videoGenree = videoGenre["attributes"] as? JSONDictionary,
            let videoGenreee = videoGenree["term"] as? String {
            self._videoGenre = videoGenreee
        } else {
            self._videoGenre = ""
        }
        
        // _videoLinkToItunes
        
        if let videoLinkToItunes = data["link"] as? JSONArray,
            let videoLinkToItuness = videoLinkToItunes[0] as? JSONDictionary,
            let videoLinkToItunesss = videoLinkToItuness["attributes"] as? JSONDictionary,
            let videoLinkToItunessss = videoLinkToItunesss["href"] as? String {
            self._videoLinkToItunes = videoLinkToItunessss
        } else {
            self._videoLinkToItunes = ""
        }
        
        // _videoReleaseDate
        
        if let videoReleaseDate = data["im:releaseDate"] as? JSONDictionary,
            let videoReleaseDatee = videoReleaseDate["attributes"] as? JSONDictionary,
            let videoReleaseDateee = videoReleaseDatee["label"] as? String {
            self._videoReleaseDate = videoReleaseDateee
        } else {
            self._videoReleaseDate = ""
        }
        
    }
    
    
}
