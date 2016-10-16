//
//  ViewController.swift
//  Top Music Itunes
//
//  Created by Israel Mayor on 15/10/2016.
//  Copyright © 2016 Team Delmarz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json", completion: didLoadData)
    }
    
    func didLoadData(musicVideo: [MusicVideo]) {
        
        
        //print(reachabilityStatus)
        
        for (index, item) in musicVideo.enumerated() {
            print("\(index) name = \(item.videoName)")
        }
    }

}

