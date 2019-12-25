//
//  ViewController.swift
//  RxSwift-MVVM
//
//  Created by Yusuf ali cezik on 25.12.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let service = OutlookService.shared()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        if (service.isLoggedIn) {
            // Logout
            service.logout()
        } else {
            // Login
            service.login(from: self) {
                error in
                if let unwrappedError = error {
                    NSLog("Error logging in: \(unwrappedError)")
                } else {
                    NSLog("Successfully logged in.")
                    self.loadUserData()
                }
            }
        }
    }
    
    func loadUserData() {
        service.getUserEmail() {
            email in
            if let unwrappedEmail = email {
                NSLog("Mail: \(unwrappedEmail)")
                self.service.getInboxMessages() {
                    messages in
                    if let unwrappedMessages = messages {
                        for (message) in unwrappedMessages["value"].arrayValue {
                            NSLog(message["subject"].stringValue)
                        }
                    }
                }
            }
        }
    }
}

