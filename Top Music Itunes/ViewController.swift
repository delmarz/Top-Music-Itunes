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
    
    func didLoadData(result: String) {
        let alertController = UIAlertController(title: result, message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                // do something
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        
    }

}

