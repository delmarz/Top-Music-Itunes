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
            
                DispatchQueue.main.async {
                    if error != nil {
                        completion((error!.localizedDescription))
                    } else {
                        completion("URLSession Successfully")
                        print(data)
                    }
                }
        }
        task.resume()
    }
    
}
