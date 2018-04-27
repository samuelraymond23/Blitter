//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import TTTAttributedLabel
import AlamofireImage

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var retweetBtn: UIButton!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var atUser: UILabel!
    @IBOutlet weak var dateAdded: UILabel!
    @IBOutlet weak var retweets: TTTAttributedLabel!
    @IBOutlet weak var favorites: TTTAttributedLabel!
    
    var tweet: Tweet! {
        didSet {
            if tweet.user.aviUrl != nil {
                let profileURL = URL(string: tweet.user.aviUrl!)
                profilePic.af_setImage(withURL: profileURL!)
            }
            tweetTextLabel.text = tweet.text
            userName.text = tweet.user.name
            atUser.text = String(format: "@%@", tweet.user.screenName!)
            dateAdded.text = tweet.createdAtString
            favorites.text = String(format: "%d", tweet.favoriteCount!)
            retweets.text = String(tweet.retweetCount)
            
        }
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
