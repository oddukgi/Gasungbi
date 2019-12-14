//
//  AppDelegate.swift
//  Gasungbi
//
//  Created by 강선미 on 18/11/2019.
//  Copyright © 2019 Sunmi Kang. All rights reserved.
//

import UIKit
import CoreData
import WebViewWarmUper

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // set up the data controller
        DataController.shared.load()

        // You should run prepare before using web views.
        WKWebViewWarmUper.shared.prepare()
        
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        try? DataController.shared.save()
    }

    func applicationWillTerminate(_ application: UIApplication) {
       try? DataController.shared.save()
    }

}

