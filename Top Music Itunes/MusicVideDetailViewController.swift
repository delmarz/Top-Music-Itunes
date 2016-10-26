//
//  MusicVideDetailViewController.swift
//  Top Music Itunes
//
//  Created by Israel Mayor on 21/10/2016.
//  Copyright © 2016 Team Delmarz. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class MusicVideDetailViewController: UIViewController {
    
    var videos: MusicVideo!
    
    @IBOutlet weak var videoNameLabel: UILabel!
    @IBOutlet weak var videoImageView: UIImageView!
    @IBOutlet weak var videoGenreLabel: UILabel!
    @IBOutlet weak var videoPrice: UILabel!
    @IBOutlet weak var videoRights: UILabel!
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = videos.videoArtist
        videoNameLabel.text = videos.videoName
        videoGenreLabel.text = "Genre: " + videos.videoGenre
        videoPrice.text = videos.videoPrice
        videoRights.text = videos.videoRights
        
        if videos.videoImageData != nil {
            videoImageView.image = UIImage(data: videos.videoImageData!)
        } else {
            videoImageView.image = UIImage(named: "placeholder")
        }
    }
    
    
    // MARK: - IBAction
    
    @IBAction func playBarButtonItemPressed(_ sender: AnyObject) {
        let url = URL(string: videos.videoURL)!
        let player = AVPlayer(url: url)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        present(playerViewController, animated: true) {
            playerViewController.player?.play()
        }
    }
    
    @IBAction func shareBarButtonItemPressed(_ sender: AnyObject) {
        let activity1 = "test 1"
        let activity2 = "test 3"
        let activity3 = "\(videos.videoName) \(videos.videoPrice)"
        let activityViewController = UIActivityViewController(activityItems: [activity1, activity2, activity3], applicationActivities: nil)
        
        activityViewController.completionWithItemsHandler = {
            (activity, success, item, error) in
            if activity == .mail {
                print("mail selected")
            }
        }
        
        present(activityViewController, animated: true, completion: nil)
        
        
    }
    
    
}
