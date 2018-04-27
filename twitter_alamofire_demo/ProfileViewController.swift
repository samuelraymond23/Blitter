//
//  ProfileViewController.swift
//  twitter_alamofire_demo
//
//  Created by student on 4/27/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var headerPic: UIImageView!
    @IBOutlet weak var tagline: UILabel!
    @IBOutlet weak var tweetCount: UILabel!
    @IBOutlet weak var followersCnt: UILabel!
    @IBOutlet weak var followingCnt: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if User.current!.aviUrl != nil {
            let profileURL = URL(string: User.current!.aviUrl!)
            profilePic.af_setImage(withURL: profileURL!)
        }
        
        if User.current!.headerUrl != nil {
            let profileURL = URL(string: User.current!.headerUrl!)
            headerPic.af_setImage(withURL: profileURL!)
        }
        
        
        
        tagline.text = User.current!.tagline
        tweetCount.text = "\(User.current!.tweetCount!)"
        followersCnt.text = "\(User.current!.followers!)"
        followingCnt.text = "\(User.current!.following!)"
        
        // Do any additional setup after loading the view.
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
