//
//  MusicVideoTableViewController.swift
//  Top Music Itunes
//
//  Created by Israel Mayor on 19/10/2016.
//  Copyright © 2016 Team Delmarz. All rights reserved.
//

import UIKit

class MusicVideoTableViewController: UITableViewController {


    var videos = [MusicVideo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(MusicVideoTableViewController.reachabilityStatusChanged), name: Notification.Name(rawValue: "ReachStatusChanged"), object: nil)
        reachabilityStatusChanged()
        
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json", completion: didLoadData)
    }
    
    func reachabilityStatusChanged() {
        switch reachabilityStatus {
        case NOACCESS:
            view.backgroundColor = UIColor.red
           // displayLabel.text = "No Internet Access"
        case WIFI:
            view.backgroundColor = UIColor.green
            //displayLabel.text = "You are on Wifi Acess!"
        case WWAN:
            view.backgroundColor = UIColor.yellow
            //displayLabel.text = "You are on Cellular Access!"
        default:
            return
        }
    }
    
    func didLoadData(musicVideo: [MusicVideo]) {
        videos = musicVideo
        for (index, item) in musicVideo.enumerated() {
            print("\(index) name = \(item.videoName)")
            
        }
        tableView.reloadData()
        print("video count \(videos.count)")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: "ReachStatusChanged"), object: nil)
    }
    
    
    // MARK: - UITableView DataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MusicVideoCell", for: indexPath)
        
        let video = videos[indexPath.row]
        
        cell.textLabel?.text = video.videoName
        cell.detailTextLabel?.text = video.videoPrice
        
        return cell
    }
    
    

}
