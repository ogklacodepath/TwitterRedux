//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Golak Sarangi on 9/22/15.
//  Copyright © 2015 Golak Sarangi. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var backGroundImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var TweetsCount: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    
    override func viewDidLoad() {
        if(User.currentUser != nil) {
            
            backGroundImageView.setImageWithURL(NSURL(string: (User.currentUser?.profileBackGroundImageUrl)!))
            profileImageView.setImageWithURL(NSURL(string: (User.currentUser?.profileImageUrl)!))
            authorLabel.text = User.currentUser?.name
            handleLabel.text = User.currentUser?.screenName
            TweetsCount.text = "\(User.currentUser?.statuses_count!)"
            followingCountLabel.text = "\(User.currentUser?.following!)"
            followersCountLabel.text = "\(User.currentUser?.followers_count!)"
            
        }
    }
}
