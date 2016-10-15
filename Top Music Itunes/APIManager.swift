//
//  APIManager.swift
//  Top Music Itunes
//
//  Created by Israel Mayor on 15/10/2016.
//  Copyright © 2016 Team Delmarz. All rights reserved.
//

import Foundation

class APIManager {
    
    
    func loadData(_ urlString: String, completion: @escaping ([MusicVideo]) ->()) {
        
        let config = URLSessionConfiguration.ephemeral
        let session = URLSession.init(configuration: config)
        let url = URL(string: urlString)!
        
        let task = session.dataTask(with: url)
        { (data, urlResponse, error) in
            
            if error != nil {
                print(error!.localizedDescription)
            } else {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? JSONDictionary,
                        let feed = json["feed"] as? JSONDictionary,
                        let entry = feed["entry"] as? JSONArray {
                        
                        var musicVideo = [MusicVideo]()
                        for item in entry {
                            let entry = MusicVideo(data: item as! JSONDictionary)
                            musicVideo.append(entry)
                        }
                        
                        let i = musicVideo.count
                        print("API Manager total count ----> \(i)")
                        
                    
                        DispatchQueue.global(qos: .userInitiated).async {
                            DispatchQueue.main.async {
                                completion(musicVideo)
                            }
                        }
                    }
                } catch {
                    print("Error in JSONSerialization")
                }
            }
        }
        task.resume()
    }

}
