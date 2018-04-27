//
//  DetailViewController.swift
//  twitter_alamofire_demo
//
//  Created by student on 4/27/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import TTTAttributedLabel

class DetailViewController: UIViewController {
    
    var tweet: Tweet!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var displayName: UILabel!
    @IBOutlet weak var atName: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var retweets: TTTAttributedLabel!
    @IBOutlet weak var favorites: TTTAttributedLabel!
    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var retweetBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if tweet.user.aviUrl != nil {
            let profileURL = URL(string: tweet.user.aviUrl!)
            profilePic.af_setImage(withURL: profileURL!)
        }
        tweetContent.text = tweet.text
        displayName.text = tweet.user.name
        atName.text = String(format: "@%@", tweet.user.screenName!)
        favorites.text = String(format: "%d", tweet.favoriteCount!)
        retweets.text = String(tweet.retweetCount)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapLike(_ sender: Any) {
        if (tweet.favorited == false) {
            APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                    self.favBtn.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: .normal)
                    self.tweet.favorited = true
                    self.tweet.favoriteCount = tweet.favoriteCount! + 1
                }
            }
            refreshData()
        } else {
            APIManager.shared.unfavorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unfavoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unfavorited the following Tweet: \n\(tweet.text)")
                    self.favBtn.setImage(#imageLiteral(resourceName: "favor-icon"), for: .normal)
                    self.tweet.favorited = false
                    self.tweet.favoriteCount = tweet.favoriteCount! - 1
                }
            }
            refreshData()
        }
    }
    
    @IBAction func didTapRetweet(_ sender: Any) {
        if (tweet.retweeted == false) {
            APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error retweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully retweeted the following Tweet: \n\(tweet.text)")
                    self.retweetBtn.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: .normal)
                    self.tweet.retweeted = true
                    self.tweet.retweetCount = tweet.retweetCount + 1
                }
            }
            refreshData()
            
        } else {
            APIManager.shared.unretweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unretweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unretweeted the following Tweet: \n\(tweet.text)")
                    self.retweetBtn.setImage(#imageLiteral(resourceName: "retweet-icon"), for: .normal)
                    self.tweet.retweeted = false
                    self.tweet.retweetCount = tweet.retweetCount - 1
                }
            }
            refreshData()
        }
        
    }
    
    func refreshData() {
        favorites.text = String(format: "%d", tweet.favoriteCount!)
        retweets.text = String(tweet.retweetCount)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
