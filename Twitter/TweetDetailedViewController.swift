//
//  TweetDetailedViewController.swift
//  Twitter
//
//  Created by Golak Sarangi on 9/15/15.
//  Copyright (c) 2015 Golak Sarangi. All rights reserved.
//

import UIKit

class TweetDetailedViewController: UIViewController {

    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    var name : String?
    var screenName : String?
    var profileImageUrl : String?
    var createdDate : String?
    var tweet : String?
    var tweetId : String?
    
    override func viewDidLoad() {
        tweetLabel.text = tweet
        screenNameLabel.text = screenName
        nameLabel.text = name
        profileImageView.setImageWithURL(NSURL(string: profileImageUrl!))
        dateLabel.text = createdDate
    }
    
    @IBAction func reply(sender: UIButton) {
        
    }
    
    @IBAction func retweet(sender: UIButton) {
        let params = ["id": tweetId!];
        
        TwitterClient.sharedInstance.reTweet(params){(response, error) -> () in
            if (error == nil) {
                self.performSegueWithIdentifier("afterRetweet", sender: self)
            } else {
                print(error)
                print("Could not save the tweets")
            }
        }
    }
    
    @IBAction func favorite(sender: UIButton) {
        let params = ["id": tweetId!];
        TwitterClient.sharedInstance.favorite(params){(response, error) -> () in
            if (error == nil) {
                print("successfully favorited")
                sender.setBackgroundImage(UIImage(named: "donefav"), forState: UIControlState.Normal)
            } else {
                print(error)
                print("could not favorite it")
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "inReplyTo" {
            let vc = segue.destinationViewController as! NewTweetViewController
            vc.inReplyToStatus = tweetId
        }
    }
    
}
