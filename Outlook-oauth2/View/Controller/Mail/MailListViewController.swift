//
//  MailListViewController.swift
//  Outlook-oauth2
//
//  Created by Yusuf ali cezik on 25.12.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit
import Letters
import RxSwift
import RxCocoa

class MailListViewController: UIViewController {

    var mailListViewModel = MailListViewModel()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupBindings()
        // Do any additional setup after loading the view.
    }
    
    private func setupBindings(){
        //tableView.register(UINib(nibName: "MailCell", bundle: nil), forCellReuseIdentifier: "cell") //storyboard üzerinden verildi.
       _ = mailListViewModel.mails.bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: MailCell.self)){
            (row, mail, cell) in
            cell.mail = mail
        }
    }
}
