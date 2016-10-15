//
//  APIManager.swift
//  Top Music Itunes
//
//  Created by Israel Mayor on 15/10/2016.
//  Copyright © 2016 Team Delmarz. All rights reserved.
//

import Foundation

class APIManager {
    
    
    func loadData(_ urlString: String, completion: @escaping (_ result: String) ->()) {
        
        let config = URLSessionConfiguration.ephemeral
        let session = URLSession.init(configuration: config)
        let url = URL(string: urlString)!
        
        let task = session.dataTask(with: url)
        { (data, urlResponse, error) in
            
            if error != nil {
                DispatchQueue.main.async {
                    completion((error!.localizedDescription))
                }
            } else {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? JSONDictionary {
                        print(json)
                        
                        DispatchQueue.global(qos: .userInitiated).async {
                            DispatchQueue.main.async {
                                completion("JSONSerialization Successful")
                            }
                        }
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion("Error in JSONSerialization Successful")
                    }
                }
            }
        }
        task.resume()
    }

}
