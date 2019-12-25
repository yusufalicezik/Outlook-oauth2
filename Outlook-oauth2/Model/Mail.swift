//
//  Mail.swift
//  Outlook-oauth2
//
//  Created by Yusuf ali cezik on 25.12.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import Foundation

struct ResponseData:Codable {
    var mailList:[Mail]?
    
    enum CodingKeys:String, CodingKey{
        case mailList = "value"
    }
}

struct Mail:Codable{
    var fromUser:FromUser?
    var received:String?
    var subject:String?
    var id:String?
    
    enum CodingKeys:String,CodingKey{
        case received = "receivedDateTime"
        case fromUser = "from"
        case subject
    }
}

struct FromUser:Codable{
    var emailAddress:EmailAddress?
}

struct EmailAddress:Codable{
    var name:String?
    var address:String?
}
