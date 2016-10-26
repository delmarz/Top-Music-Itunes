//
//  MusicVideoTableViewCell.swift
//  Top Music Itunes
//
//  Created by Israel Mayor on 20/10/2016.
//  Copyright © 2016 Team Delmarz. All rights reserved.
//

import UIKit

class MusicVideoTableViewCell: UITableViewCell {

    var musicVideo: MusicVideo? {
        didSet {
            updateCell()
        }
    }
    
    @IBOutlet weak var videoImageView: UIImageView!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var videoName: UILabel!
    
    
    func updateCell() {
        rankLabel.text = "\(musicVideo!.rank)"
        videoName.text = musicVideo?.videoName

        if musicVideo!.videoImageData != nil {
            print("get image data in array")
            videoImageView.image = UIImage(data: musicVideo!.videoImageData!)
        } else {
            print("get images in background thread")
            getMusicVideoImage(musicVideo: musicVideo!, imageView: videoImageView)
        }
    }
 
    func getMusicVideoImage(musicVideo: MusicVideo, imageView: UIImageView) {
        DispatchQueue.global(qos: .default).async {
            do {
                let data: Data? = try Data(contentsOf: URL(string: musicVideo.videoImageURL)!)
                var image: UIImage?
                if data != nil {
                    musicVideo.videoImageData = data!
                    image = UIImage(data: data!)
                }
                DispatchQueue.main.async {
                    imageView.image = image
                }
            } catch {
                print("Error fetch images")
            }
        }
    }

}
