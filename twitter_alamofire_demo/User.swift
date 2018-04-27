//
//  User.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/17/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//


import Foundation
import UIKit

class User {
    var name: String
    var screenName: String?
    var aviUrl: String?
    var headerUrl: String?
    var following: Int?
    var followers: Int?
    var tweetCount: Int?
    var tagline: String?
    
    var dictionary: [String: Any]?
    
    init(dictionary: [String: Any]) {
        self.dictionary = dictionary
        
        name = dictionary["name"] as! String
        screenName = dictionary["screen_name"] as? String
        aviUrl = dictionary["profile_image_url_https"] as? String
        headerUrl = dictionary["profile_banner_url"] as? String
        tagline = dictionary["description"] as? String
        following = dictionary["friends_count"] as? Int
        followers = dictionary["followers_count"] as? Int
        tweetCount = dictionary["statuses_count"] as? Int
    }
    
    private static var _current: User?
    
    static var current: User? {
        get {
            if _current == nil {
                let defaults = UserDefaults.standard
                if let userData = defaults.data(forKey: "currentUserData") {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! [String: Any]
                    _current = User(dictionary: dictionary)
                }
            }
            return _current
        }
        set (user) {
            _current = user
            let defaults = UserDefaults.standard
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                defaults.set(data, forKey: "currentUserData")
            } else {
                defaults.removeObject(forKey: "currentUserData")
            }
        }
    }
}
