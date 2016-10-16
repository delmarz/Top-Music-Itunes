//
//  ViewController.swift
//  Top Music Itunes
//
//  Created by Israel Mayor on 15/10/2016.
//  Copyright © 2016 Team Delmarz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var displayLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.reachabilityStatusChanged), name: Notification.Name(rawValue: "ReachStatusChanged"), object: nil)
        reachabilityStatusChanged()
        
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json", completion: didLoadData)
    }
    
    func reachabilityStatusChanged() {
        switch reachabilityStatus {
        case NOACCESS:
            view.backgroundColor = UIColor.red
            displayLabel.text = "No Internet Access"
        case WIFI:
            view.backgroundColor = UIColor.green
            displayLabel.text = "You are on Wifi Acess!"
        case WWAN:
            view.backgroundColor = UIColor.yellow
            displayLabel.text = "You are on Cellular Access!"
        default:
            return
        }
    }
    
    func didLoadData(musicVideo: [MusicVideo]) {
        
        
        //print(reachabilityStatus)
        
        for (index, item) in musicVideo.enumerated() {
            print("\(index) name = \(item.videoName)")
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: "ReachStatusChanged"), object: nil)
    }

}

