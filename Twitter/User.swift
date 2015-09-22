//
//  User.swift
//  Twitter
//
//  Created by Golak Sarangi on 9/14/15.
//  Copyright (c) 2015 Golak Sarangi. All rights reserved.
//

import UIKit

var _currentUser : User?

class User: NSObject {
    var name: String?
    var screenName: String?
    var profileImageUrl : String?
    var profileBackGroundImageUrl: String?
    var following: Int?
    var followers_count: Int?
    var statuses_count: Int?
    var tagline: String?
    var dictionary : NSDictionary?
    
    init (dictionary: NSDictionary) {
        self.dictionary = dictionary

        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        profileImageUrl = dictionary["profile_image_url"] as? String
        profileBackGroundImageUrl = dictionary["profile_background_image_url"] as? String
        tagline = dictionary["description"] as? String
        followers_count = dictionary["followers_count"] as? Int
        following = dictionary["following"] as? Int
        statuses_count = dictionary["statuses_count"] as? Int
    }
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                let data = NSUserDefaults.standardUserDefaults().objectForKey("currentUserKey") as? NSData
        
                if data != nil {
                    let dictionary = (try! NSJSONSerialization.JSONObjectWithData(data!, options: [])) as! NSDictionary
                    _currentUser = User(dictionary: dictionary)
                }
            }
            return _currentUser
        }
        set(user){
            _currentUser = user
            
            if (_currentUser != nil) {
                let data = try? NSJSONSerialization.dataWithJSONObject(user!.dictionary!, options: [])
                NSUserDefaults.standardUserDefaults().setObject(data, forKey: "currentUserKey")
            } else {
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: "currentUserKey")
            }
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    func logout() {
        User.currentUser = nil
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        Tweet.clearAllTweets()
        
        NSNotificationCenter.defaultCenter().postNotificationName("userDidLogoutNotification", object: nil)
    }
    
}
