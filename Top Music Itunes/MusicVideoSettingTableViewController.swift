//
//  MusicVideoSettingTableViewController.swift
//  Top Music Itunes
//
//  Created by Israel Mayor on 22/10/2016.
//  Copyright © 2016 Team Delmarz. All rights reserved.
//

import UIKit

class MusicVideoSettingTableViewController: UITableViewController {
    
    var userDefaults = UserDefaults.standard
    
    
    // IBOulet
    
    @IBOutlet weak var securitySwitch: UISwitch!
    @IBOutlet weak var imageQualitySwitch: UISwitch!
    @IBOutlet weak var apiCountLabel: UILabel!
    @IBOutlet weak var apiCountSlider: UISlider!
    
    
    // MARK: - View life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        
        securitySwitch.isOn = userDefaults.bool(forKey: "SecurityKey")
        
        if userDefaults.object(forKey: "APICountSlider") != nil {
            let apiCount = userDefaults.object(forKey: "APICountSlider") as! Int
            apiCountSlider.value = Float(apiCount)
            apiCountLabel.text = "\(apiCount)"
        } else {
            apiCountSlider.value = 10.0
            apiCountLabel.text = "\(Int(apiCountSlider.value))"
        }
        
        
        
    }
    
    // MARK: - IBActions
    
    @IBAction func securitySwitchValueChanged(_ sender: UISwitch) {
        if securitySwitch.isOn {
            userDefaults.set(true, forKey: "SecurityKey")
        } else {
            userDefaults.set(false, forKey: "SecurityKey")
            
        }
    }
    
    
    @IBAction func sliderApiCountValueChanged(_ sender: UISlider) {
        userDefaults.set(Int(apiCountSlider.value), forKey: "APICountSlider")
        apiCountLabel.text = "\(Int(apiCountSlider.value))"
    }
    
    
    
}
