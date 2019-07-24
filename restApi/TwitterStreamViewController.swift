//
//  TwitterStreamViewController.swift
//  restApi
//
//  Created by HGPMAC87 on 7/21/19.
//  Copyright © 2019 iBlinkco. All rights reserved.
//

import UIKit

class TwitterStreamViewController: UIViewController {
    var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
    
            // Getting Instagram data
            let tweetsText = UserDefaults.standard.stringArray(forKey: "tweetsText") ?? [String]()
            let tweetsTime = UserDefaults.standard.stringArray(forKey: "tweetsTime") ?? [String]()
            let tweetsTipsRaw = UserDefaults.standard.value(forKey: "tweetsTips")
            
            // Adding screen size
            let screenSize: CGRect = UIScreen.main.bounds
            
            // Creating scroll view
            self.scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
            
            // Do any additional setup after loading the view.
            let twitterStreamSwipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.twitterStreamToHomeSegueFunction))
            twitterStreamSwipeRightGesture.direction = UISwipeGestureRecognizer.Direction.right
            self.view.addGestureRecognizer(twitterStreamSwipeRightGesture)
            
            var tweetsTips = tweetsTipsRaw as! [[String]]
            var tweetCount = tweetsText.count
            print(tweetCount)
            tweetCount = tweetCount - 1
            var viewY = 100
            let viewHeight = 128
            
            for post in 0...tweetCount {
                print(post)
                // Creating view for post
                let twitterTweetView = UIView(frame: CGRect(x: 0, y: viewY, width: Int(screenSize.width), height: viewHeight*6))
                twitterTweetView.backgroundColor = UIColor.white
                twitterTweetView.center.x = self.view.center.x
                self.scrollView.addSubview(twitterTweetView)
    
                
                let twitterTweetLabel = UILabel(frame: CGRect(x: 0, y: 100, width: Int(screenSize.width), height: 236))
                twitterTweetLabel.center = CGPoint(x: 160, y: viewY)
                twitterTweetLabel.textColor = .black
                twitterTweetLabel.lineBreakMode = .byWordWrapping
                twitterTweetLabel.numberOfLines = 0
                twitterTweetLabel.textAlignment = .center
                twitterTweetLabel.text = tweetsText[post]
                twitterTweetLabel.center.x = self.view.center.x
                twitterTweetLabel.font = twitterTweetLabel.font.withSize(24)
                self.scrollView.addSubview(twitterTweetLabel)
                
                viewY = viewY + 125
                let tweetTimeStats = UILabel(frame: CGRect(x: Int(screenSize.width)/2, y: 50, width: Int(screenSize.width - 10), height: 160))
                tweetTimeStats.lineBreakMode = .byWordWrapping
                tweetTimeStats.numberOfLines = 0
                tweetTimeStats.center = CGPoint(x: 160, y: viewY)
                tweetTimeStats.center.x = self.view.center.x
                tweetTimeStats.textAlignment = .center
                tweetTimeStats.textColor = .black
                tweetTimeStats.text = "Time:  " + tweetsTime[post]
                self.scrollView.addSubview(tweetTimeStats)
                
                if tweetsTips[post] != ["null"]{
                    for tip in tweetsTips[post] {
                        viewY = viewY + 64
                        let tweetTipsSmallText = UILabel(frame: CGRect(x: 0, y: 75, width: Int(screenSize.width), height: 160))
                        tweetTipsSmallText.center = CGPoint(x: 160, y: viewY)
                        tweetTipsSmallText.textColor = .black
                        
                        // Checking how long a string
                        var tipLength = tip.count
                        tipLength = tipLength/10
                        
                        
                        tweetTipsSmallText.lineBreakMode = .byWordWrapping
                        tweetTipsSmallText.numberOfLines = 0
                        tweetTipsSmallText.textAlignment = .center
                        
                        tweetTipsSmallText.text = String(tip)
                        tweetTipsSmallText.center.x = self.view.center.x
                        tweetTipsSmallText.font = tweetTipsSmallText.font.withSize(16)
                        self.scrollView.addSubview(tweetTipsSmallText)
                    }
                }
                viewY = viewY + 200
            }
            // Appending all
            let scrollViewHeightCGFloat = CGFloat(viewY + 100)
            self.scrollView.contentSize = CGSize(width: screenSize.width, height: scrollViewHeightCGFloat)
            self.view.addSubview(self.scrollView)
        }
    }
    @objc func twitterStreamToHomeSegueFunction(fromGesture gesture: UISwipeGestureRecognizer) {
        self.performSegue(withIdentifier: "twitterStreamToHomeSegue", sender: self)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
