//
//  ComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by student on 4/27/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

protocol ComposeViewControllerDelegate : class {
    func did(post: Tweet)
}

class ComposeViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var countLabel: UILabel!
    weak var delegate : ComposeViewControllerDelegate?
    var aviString: String?
    @IBOutlet weak var avi: UIImageView!
    @IBOutlet weak var tweetField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetField.delegate = self
        
        if aviString != nil {
            let profileURL = URL(string: aviString!)
            avi.af_setImage(withURL: profileURL!)
        }
        
        countLabel.text = "140"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelTweet(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // TODO: Check the proposed new text character count
        // Allow or disallow the new text
        // Set the max character limit
        let characterLimit = 140
        
        // Construct what the new text would be if we allowed the user's latest edit
        let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)
        
        // TODO: Update Character Count Label
        countLabel.text =  String(140 - newText.characters.count)
        
        // The new text should be allowed? True/False
        return newText.characters.count < characterLimit
    }
    
    
    @IBAction func postTweet(_ sender: Any) {
        APIManager.shared.composeTweet(with: tweetField.text) { (tweet, error) in
            if let error = error {
                print("Error composing Tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                self.delegate?.did(post: tweet)
                print("Compose Tweet Success!")
                self.dismiss(animated: true, completion: nil)
            }
        }
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
