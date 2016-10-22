//
//  MusicVideDetailViewController.swift
//  Top Music Itunes
//
//  Created by Israel Mayor on 21/10/2016.
//  Copyright © 2016 Team Delmarz. All rights reserved.
//

import UIKit

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
        videoGenreLabel.text = videos.videoGenre
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
    }
    
    @IBAction func shareBarButtonItemPressed(_ sender: AnyObject) {
    }
    

}