//
//  MusicVideo.swift
//  Top Music Itunes
//
//  Created by Israel Mayor on 15/10/2016.
//  Copyright © 2016 Team Delmarz. All rights reserved.
//

import Foundation

class MusicVideo {
    
    // Data Encapsulation
    
    private var _videoName: String
    private var _videoImageURL: String
    private var _videoURL: String
    
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
    
    
    init(data: JSONDictionary) {
        if let videoName = data["im:name"] as? JSONDictionary,
            let videoNamee = videoName["label"] as? String {
            self._videoName = videoNamee
        } else {
            _videoName = ""
        }
        
        if let videoImageURL = data["im:image"] as? JSONArray,
            let videoImageURLL = videoImageURL[2] as? JSONDictionary,
            let videoImageURLLL = videoImageURLL["label"] as? String {
            self._videoImageURL = videoImageURLLL.replacingOccurrences(of: "100x100", with: "600x600")
        } else {
            self._videoImageURL = ""
        }
        
        if let videoURL = data["link"] as? JSONArray,
            let videoURLL = videoURL[1] as? JSONDictionary,
            let videoURLLL = videoURLL["attributes"] as? JSONDictionary,
            let videoURLLLL = videoURLLL["href"] as? String {
            self._videoURL = videoURLLLL
        } else {
            self._videoURL = ""
        }
        
    }
    
    
}
