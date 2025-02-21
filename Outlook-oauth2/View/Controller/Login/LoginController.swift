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
        service.login(from: self) {
                 error in
                 if let unwrappedError = error {
                     NSLog("Error logging in: \(unwrappedError)")
                 } else {
                     NSLog("Successfully logged in.")
                     DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
                          let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MailListVC") as? MailListViewController
                         self.present(vc!, animated: true, completion: nil)
                     })
                 }
        }
    }
}

