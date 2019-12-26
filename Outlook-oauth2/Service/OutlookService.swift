//
//  OutlookService.swift
//  RxSwift-MVVM
//
//  Created by Yusuf ali cezik on 25.12.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import Foundation
import p2_OAuth2
import SwiftyJSON

class OutlookService {
    
    private var userEmail: String
    private var skipCount = 0
    
    // Configure the OAuth2 framework for Azure
    private static let oauth2Settings = [
        "client_id" : "6a90dfe4-2294-49a7-8628-2d5383d0e7ca",
        "authorize_uri": "https://login.microsoftonline.com/common/oauth2/v2.0/authorize",
        "token_uri": "https://login.microsoftonline.com/common/oauth2/v2.0/token",
        "scope": "openid profile offline_access User.Read Mail.Read",
        "redirect_uris": ["swift-tutorial://oauth2/callback"],
        "verbose": true,
        ] as OAuth2JSON

    private static var sharedService: OutlookService = {
        let service = OutlookService()
        return service
    }()

    private let oauth2: OAuth2CodeGrant

    private init() {
        oauth2 = OAuth2CodeGrant(settings: OutlookService.oauth2Settings)
        oauth2.authConfig.authorizeEmbedded = true
        userEmail = ""
    }

    class func shared() -> OutlookService {
        return sharedService
    }

    var isLoggedIn: Bool {
        get {
            return oauth2.hasUnexpiredAccessToken() || oauth2.refreshToken != nil
        }
    }

    func handleOAuthCallback(url: URL) -> Void {
        oauth2.handleRedirectURL(url)
    }

    func login(from: AnyObject, callback: @escaping (String? ) -> Void) -> Void {
        oauth2.authorizeEmbedded(from: from) {
            result, error in
            if let unwrappedError = error {
                callback(unwrappedError.description)
            } else {
                if let unwrappedResult = result, let token = unwrappedResult["access_token"] as? String {
                    // Print the access token to debug log
                    NSLog("Access token: \(token)")
                    callback(nil)
                }
            }
        }
    }

    func logout() -> Void {
        oauth2.forgetTokens()
    }
    
    
    
    //MARK: - User
    func makeApiCall(api: String, params: [String: String]? = nil, callback: @escaping (JSON?) -> Void) -> Void {
        // Build the request URL
        var urlBuilder = URLComponents(string: "https://graph.microsoft.com")!
        urlBuilder.path = api

        if let unwrappedParams = params {
            // Add query parameters to URL
            urlBuilder.queryItems = [URLQueryItem]()
            for (paramName, paramValue) in unwrappedParams {
                urlBuilder.queryItems?.append(
                    URLQueryItem(name: paramName, value: paramValue))
            }
        }

        let apiUrl = urlBuilder.url!
        NSLog("Making request to \(apiUrl)")

        var req = oauth2.request(forURL: apiUrl)
        req.addValue("application/json", forHTTPHeaderField: "Accept")

        let loader = OAuth2DataLoader(oauth2: oauth2)

        // Uncomment this line to get verbose request/response info in
        // Xcode output window
        //loader.logger = OAuth2DebugLogger(.trace)

        loader.perform(request: req) {
            response in
            do {
                let dict = try response.responseJSON()
                DispatchQueue.main.async {
                    let result = JSON(dict)
                    callback(result)
                }
            }
            catch let error {
                DispatchQueue.main.async {
                    let result = JSON(error)
                    callback(result)
                }
            }
        }
    }
    
    func getUserEmail(callback: @escaping (String?) -> Void) -> Void {
        // If we don't have the user's email, get it from
        // the API
        if (userEmail.isEmpty) {
            makeApiCall(api: "/v1.0/me") {
                result in
                if let unwrappedResult = result {
                    var email = unwrappedResult["mail"].stringValue
                    if (email.isEmpty) {
                        // Fallback to userPrincipalName ONLY if mail is empty
                        email = unwrappedResult["userPrincipalName"].stringValue
                    }
                    self.userEmail = email
                    callback(email)
                } else {
                    callback(nil)
                }
            }
        } else {
            callback(userEmail)
        }
    }
    
    func getInboxMessages(callback: @escaping (JSON?) -> Void) -> Void {
        let apiParams = [
            "$select": "subject,receivedDateTime,from",
            "$orderby": "receivedDateTime DESC",
            "$top": "10",
            "$skip": String(self.skipCount)
        ]
        
        self.skipCount+=10 // for paging

        makeApiCall(api: "/v1.0/me/mailfolders/inbox/messages", params: apiParams) {
            result in
            callback(result)
        }
    }
    
    func loadUserData(completion: @escaping (_ dataList:[Mail]) -> Void) {
        self.getUserEmail() {
            email in
            if let unwrappedEmail = email {
                NSLog("Mail: \(unwrappedEmail)")
                var mails = [Mail]()
                self.getInboxMessages() {
                    messages in
                    print(messages)
                    if let unwrappedMessages = messages {
                        for (message) in unwrappedMessages["value"].arrayValue {
                            let mail = Mail(fromUser: FromUser(emailAddress: EmailAddress(name: message["from"]["emailAddress"]["name"].stringValue, address: message["from"]["emailAddress"]["address"].stringValue)), received: message["receivedDateTime"].stringValue, subject: message["subject"].stringValue, id: message["id"].stringValue)
                            print(mail.subject!)
                            mails.append(mail)
                        }
                        completion(mails)
                    }
                }
            }
        }
    }
}
