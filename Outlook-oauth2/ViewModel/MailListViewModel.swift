//
//  MailListViewModel.swift
//  Outlook-oauth2
//
//  Created by Yusuf ali cezik on 26.12.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MailListViewModel{
    
    private let dispaseBag = DisposeBag()
    
    public let mails: BehaviorSubject<[Mail]> = BehaviorSubject(value: [])
    
    init(){
        self.getUserMails()
    }
    
    public func getUserMails(){
        OutlookService.shared().loadUserData { (mails) in
            self.mails.onNext(mails)
        }
    }
    
}
