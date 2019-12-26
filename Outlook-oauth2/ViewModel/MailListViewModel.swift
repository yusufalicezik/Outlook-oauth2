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
    
    private let disposeBag = DisposeBag()
    
    public let mails: BehaviorSubject<[Mail]> = BehaviorSubject(value: [])
    
    init(){
        self.getUserMails()
    }
    
    public func getUserMails(){
        OutlookService.shared().loadUserData { (mails) in
            do{
                try self.mails.onNext(self.mails.value() + mails)

            }catch{
                
            }
        }
    }
}

extension String{
     func formatDate()->String{
        let toDateFormatter = DateFormatter()
        toDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        toDateFormatter.locale = Locale(identifier: "tr")

        let date: Date? = toDateFormatter.date(from: self)
        
        let toStringFormatter = DateFormatter()
        toStringFormatter.dateStyle = DateFormatter.Style.medium
        toStringFormatter.timeStyle = DateFormatter.Style.short
        toStringFormatter.timeZone = TimeZone.current
        toStringFormatter.locale = Locale(identifier: "tr")

        return toStringFormatter.string(from: date!)
    }
}
