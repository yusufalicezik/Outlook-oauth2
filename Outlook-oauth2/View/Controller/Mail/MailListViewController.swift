//
//  MailListViewController.swift
//  Outlook-oauth2
//
//  Created by Yusuf ali cezik on 25.12.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit
import Letters

class MailListViewController: UIViewController {

    var mailList = [Mail]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getMails()
        // Do any additional setup after loading the view.
    }
    
    private func getMails(){
        OutlookService.shared().loadUserData { (mails) in
            self.mailList = mails
            self.tableView.reloadData()
        }
    }
}
extension MailListViewController:UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mailList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MailCell
        cell?.senderNameLabel.text = mailList[indexPath.row].fromUser!.emailAddress!.name!
        cell?.senderEmailLabel.text = mailList[indexPath.row].fromUser!.emailAddress!.address!
        cell?.subjectLabel.text = mailList[indexPath.row].subject!
        cell?.mailImageView.setImage(string: cell?.senderNameLabel.text!, color: #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 0.7215325342), circular: true, textAttributes: [NSAttributedString.Key.font: UIFont(name: "Arial", size: 30.0)!, NSAttributedString.Key.foregroundColor:#colorLiteral(red: 0.1900072992, green: 0.3403339386, blue: 0.4397745132, alpha: 1)])

        return cell!
    }
    
    
}
