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
        
        tableView.estimatedRowHeight = 130
        tableView.rowHeight = UITableViewAutomaticDimension
        
        NotificationCenter.default.addObserver(self, selector: #selector(MusicVideoTableViewController.reachabilityStatusChanged), name: Notification.Name(rawValue: "ReachStatusChanged"), object: nil)
        reachabilityStatusChanged()
        
    }
    
    func reachabilityStatusChanged() {
        switch reachabilityStatus {
        case NOACCESS:
            alertView(title: "\(NOACCESS)")
        default:
            if videos.count > 0 {
                print("dont need to refresh")
            } else {
                
                callAPI()
            }
            
        }
    }
    
    func callAPI() {
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=50/json", completion: didLoadData)
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
    
    
    // MARK: - Helper
    
    func alertView(title: String) {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let addOK = UIAlertAction(title: "OK", style: .default) { (action) in
            // do something
        }
        alertController.addAction(addOK)
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    // MARK: - UITableView DataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "MusicVideoDetails", sender: self)
    }
    
    private struct MusicVideoIdentifier {
        static let cellIdentifier = "MusicVideoCell"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MusicVideoIdentifier.cellIdentifier, for: indexPath) as! MusicVideoTableViewCell
        
        cell.musicVideo = videos[indexPath.row]
        
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MusicVideoDetails" {
            let controller = segue.destination as! MusicVideDetailViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                let musicVideo = videos[indexPath.row]
                controller.videos = musicVideo
            }
        }
    }
    
    
}
