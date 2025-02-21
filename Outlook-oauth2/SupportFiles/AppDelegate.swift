//
//  AppDelegate.swift
//  RxSwift-MVVM
//
//  Created by Yusuf ali cezik on 25.12.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if OutlookService.shared().isLoggedIn{
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MailListVC") as? MailListViewController
            window?.rootViewController = vc!
            window?.makeKeyAndVisible()
        }
        // Override point for customization after application launch.
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        if url.scheme == "swift-tutorial" {
            let service = OutlookService.shared()
            service.handleOAuthCallback(url: url)
            return true
        }
        else {
            return false
        }
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

