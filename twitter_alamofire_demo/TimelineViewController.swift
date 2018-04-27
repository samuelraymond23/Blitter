//
//  TimelineViewController.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ComposeViewControllerDelegate {
    func did(post: Tweet) {
        tableView.reloadData()
        // cant go back to timeline after tweet success
        navigationController?.popToViewController(self, animated: false)
    }
    
    var composeView: ComposeViewController = ComposeViewController()
    var tweets: [Tweet] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        composeView.delegate = self
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableViewAutomaticDimension
        
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(self.pullToRefresh(_:)),
                          for: .valueChanged)
        tableView.insertSubview(refresh, at: 0)
        
        fetchTweets()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toDetail") {
            let destination = segue.destination as! DetailViewController
            let cell =  sender as! UITableViewCell
            if let indexPath = tableView.indexPath(for: cell) {
                destination.tweet = tweets[indexPath.row]
            }
        }
        if (segue.identifier == "toCompose") {
            let destination = segue.destination as! ComposeViewController
            
            if User.current!.aviUrl != nil {
                destination.aviString = User.current!.aviUrl!
            }
            destination.delegate = self
        }
        
        /*if (segue.identifier == "toProfile") {
         let destination = segue.destination as! ProfileViewController
         if User.current!.aviUrl != nil {
         destination.aviString = User.current!.aviUrl!
         }
         }*/
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        
        cell.tweet = tweets[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func didTapLogout(_ sender: Any) {
        APIManager.shared.logout()
    }
    
    @objc func  pullToRefresh(_ refresh: UIRefreshControl) {
        fetchTweets()
        
        // Reload the tableView now that there is new data
        tableView.reloadData()
        
        // Tell the refreshControl to stop spinning
        refresh.endRefreshing()
    }
    
    func fetchTweets() {
        APIManager.shared.getHomeTimeLine { (tweets, error) in
            if let tweets = tweets {
                self.tweets = tweets
                self.tableView.reloadData()
            } else if let error = error {
                print("Error getting home timeline: " + error.localizedDescription)
            }
        }
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
