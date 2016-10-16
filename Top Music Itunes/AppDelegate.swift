//
//  AppDelegate.swift
//  Top Music Itunes
//
//  Created by Israel Mayor on 15/10/2016.
//  Copyright © 2016 Team Delmarz. All rights reserved.
//

import UIKit

var reachability: Reachability?
var reachabilityStatus = WIFI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var internetCheck: Reachability?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.reachabilityChanged(notification:)), name: Notification.Name.reachabilityChanged, object: nil)
        internetCheck = Reachability.forInternetConnection()
        internetCheck?.startNotifier()
        return true
    }
    
    func reachabilityChanged(notification: Notification) {
        reachability = notification.object as? Reachability
        statusChanged(with: reachability!)
    }
    
    func statusChanged(with currentReachabilityStatus: Reachability) {
        let networkStatus: NetworkStatus = currentReachabilityStatus.currentReachabilityStatus()
        switch networkStatus.rawValue {
        case NotReachable.rawValue: reachabilityStatus = NOACCESS
        case ReachableViaWiFi.rawValue: reachabilityStatus = WIFI
        case ReachableViaWWAN.rawValue: reachabilityStatus = WWAN
        default: return
        }
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "ReachStatusChanged"), object: nil)
    }


    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        NotificationCenter.default.removeObserver(self, name: Notification.Name.reachabilityChanged, object: nil)
    }


}

