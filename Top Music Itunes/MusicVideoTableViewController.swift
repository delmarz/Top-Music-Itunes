//
//  MusicVideoTableViewController.swift
//  Top Music Itunes
//
//  Created by Israel Mayor on 19/10/2016.
//  Copyright © 2016 Team Delmarz. All rights reserved.
//

import UIKit

class MusicVideoTableViewController: UITableViewController, UISearchResultsUpdating {
    
    
    var videos = [MusicVideo]()
    var filteredVideos = [MusicVideo]()
    var limit = 10
    var resultSearchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 130
        tableView.rowHeight = UITableViewAutomaticDimension
        
        NotificationCenter.default.addObserver(self, selector: #selector(MusicVideoTableViewController.reachabilityStatusChanged), name: Notification.Name(rawValue: "ReachStatusChanged"), object: nil)
        reachabilityStatusChanged()
        
        
        refreshControl?.addTarget(self, action: #selector(MusicVideoTableViewController.refreshAPICount), for: .valueChanged)
        
        
    }
    
    func refreshAPICount() {
        refreshControl?.endRefreshing()
        callAPI()
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
    
    func getAPICount() {
        if UserDefaults.standard.object(forKey: "APICountSlider") != nil {
            let count = UserDefaults.standard.object(forKey: "APICountSlider") as! Int
            limit = count
            
            let formatter = DateFormatter()
            formatter.dateFormat = "E, dd MMM yyy HH:mm:ss"
            let refreshTitle = formatter.string(from: Date())
            
            refreshControl?.attributedTitle = NSAttributedString(string: refreshTitle)
            
        }
    }
    
    func callAPI() {
        getAPICount()
        
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=\(limit)/json", completion: didLoadData)
    }
    
    func didLoadData(musicVideo: [MusicVideo]) {
        videos = musicVideo
        for (index, item) in musicVideo.enumerated() {
            print("\(index) name = \(item.videoName)")
            
        }
        tableView.reloadData()
        navigationItem.title = "Top \(limit) Music Videos in iTunes"
        
        definesPresentationContext = true
        resultSearchController.dimsBackgroundDuringPresentation = false
        resultSearchController.searchBar.placeholder = "Search for Artist"
        resultSearchController.searchBar.searchBarStyle = .prominent
        resultSearchController.searchResultsUpdater = self
        tableView.tableHeaderView = resultSearchController.searchBar
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
        if resultSearchController.isActive {
            return filteredVideos.count
        }
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
        
        if resultSearchController.isActive {
            cell.musicVideo = filteredVideos[indexPath.row]
        } else {
            cell.musicVideo = videos[indexPath.row]
        }
        return cell
    }
    
    
    
    // MARK: - UISearchResultsUpdating
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text!.lowercased()
        filterSearch(searchText: searchText)
    }
    
    func filterSearch(searchText: String) {
        filteredVideos = videos.filter({videos in
            return videos.videoName.lowercased().contains(searchText.lowercased()) ||
                   "\(videos.rank)".lowercased().contains(searchText.lowercased()) ||
                   videos.videoArtist.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MusicVideoDetails" {
            let controller = segue.destination as! MusicVideDetailViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                
                let musicVideo: MusicVideo
                
                if resultSearchController.isActive {
                    musicVideo = filteredVideos[indexPath.row]
                } else {
                    musicVideo = videos[indexPath.row]
                }
                controller.videos = musicVideo
            }
        }
    }
    
    
}
