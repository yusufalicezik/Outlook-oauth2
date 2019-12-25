//
//  CurrentUser.swift
//  Outlook-oauth2
//
//  Created by Yusuf ali cezik on 25.12.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import Foundation

class CurrentUser{
    static let shared = CurrentUser()
    
    var mail:String?
    var token:String?
    var refreshToken:String?
}
