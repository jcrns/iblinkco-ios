//
//  InstagramStreamViewController.swift
//  restApi
//
//  Created by HGPMAC87 on 7/21/19.
//  Copyright © 2019 iBlinkco. All rights reserved.
//

import UIKit

class InstagramStreamViewController: UIViewController {
    var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            // Putting all data in function to run at the same time
        DispatchQueue.main.async {
            // Getting Instagram data
            let instagramPostsCaption = UserDefaults.standard.stringArray(forKey: "instagramPostsCaption") ?? [String]()
            let instagramPostsNumberOfComments = UserDefaults.standard.object(forKey: "instagramPostsNumberOfComments") as! [Int]
            let instagramPostsNumberOfLikes = UserDefaults.standard.object(forKey: "instagramPostsNumberOfLikes") as! [Int]
            let instagramPostsPicUrl = UserDefaults.standard.stringArray(forKey: "instagramPostsPicUrl") ?? [String]()
            let instagramPostsPictureText = UserDefaults.standard.stringArray(forKey: "instagramPostsPictureText") ?? [String]()
            var instagramPostsTipsRaw = UserDefaults.standard.value(forKey: "instagramPostsTips")
            
            let screenSize: CGRect = UIScreen.main.bounds
            self.scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
            
            // Do any additional setup after loading the view.
            // Recognizing swipe right gesture
            let instagramStreamSwipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.instagramStreamToStreamSelectAndTipsSegueFunction))
            instagramStreamSwipeRightGesture.direction = UISwipeGestureRecognizer.Direction.right
            self.view.addGestureRecognizer(instagramStreamSwipeRightGesture)
            print(instagramPostsCaption)
            print(instagramPostsNumberOfComments)
            print(instagramPostsNumberOfLikes)
            print(instagramPostsPicUrl)
            print(instagramPostsPictureText)
            
            print("drgwertgwrthwg\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n")
//            print(instagramPostsTips?["1"])
            var instagramPostsTips = instagramPostsTipsRaw as! [[String]]
            print(instagramPostsTips)
            var postCount = instagramPostsCaption.count
            print(postCount)
            postCount = postCount - 1
            var viewY = 100
            let viewHeight = 128
            for post in 0...postCount {
                // Creating view for post
                let instagramPostView = UIView(frame: CGRect(x: 0, y: viewY, width: Int(screenSize.width), height: viewHeight*6))
                instagramPostView.backgroundColor = UIColor.white
                instagramPostView.center.x = self.view.center.x
                self.scrollView.addSubview(instagramPostView)
                
                let imageView : UIImageView
                imageView  = UIImageView(frame:CGRect(x: 0, y: viewY, width: Int(screenSize.width), height: viewHeight*3));
                if let url = URL(string: instagramPostsPicUrl[post]) {
                    let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
                        if let data = data {
                            imageView.image = UIImage(data: data)
                            self.scrollView.addSubview(imageView)
                        }
                    })
                    task.resume()
                }
//                if let url = URL(string: instagramPostsPicUrl[post]) {
//                    do {
//                        let data: Data = try Data(contentsOf: url)
//                        imageView.image = UIImage(data: data)
//                        self.scrollView.addSubview(imageView)
//                    } catch {
//                        // error handling
//                    }
//                }

                viewY = viewY + 500
                let instagramPostCaptionLabel = UILabel(frame: CGRect(x: 0, y: 100, width: Int(screenSize.width), height: 200))
                instagramPostCaptionLabel.center = CGPoint(x: 160, y: viewY)
                instagramPostCaptionLabel.textColor = .black
                instagramPostCaptionLabel.lineBreakMode = .byWordWrapping
                instagramPostCaptionLabel.numberOfLines = 0
                instagramPostCaptionLabel.textAlignment = .center
                instagramPostCaptionLabel.text = instagramPostsCaption[post]
                instagramPostCaptionLabel.center.x = self.view.center.x
                instagramPostCaptionLabel.font = instagramPostCaptionLabel.font.withSize(20)
                self.scrollView.addSubview(instagramPostCaptionLabel)
                
                viewY = viewY + 125
                let instagramPostStats = UILabel(frame: CGRect(x: Int(screenSize.width)/2, y: 50, width: Int(screenSize.width - 10), height: 160))
                instagramPostStats.lineBreakMode = .byWordWrapping
                instagramPostStats.numberOfLines = 0
                instagramPostStats.center = CGPoint(x: 160, y: viewY)
                instagramPostStats.center.x = self.view.center.x
                instagramPostStats.textAlignment = .center
                instagramPostStats.textColor = .black
                instagramPostStats.text = "Comments " + String(instagramPostsNumberOfComments[post]) + "     " + "Likes " + String(instagramPostsNumberOfLikes[post])
                self.scrollView.addSubview(instagramPostStats)
                
                if instagramPostsTips[post] != ["null"]{
                    for tip in instagramPostsTips[post] {
                        viewY = viewY + 64
                        let instagramPostTipsSmallText = UILabel(frame: CGRect(x: 0, y: 75, width: Int(screenSize.width), height: 160))
                        instagramPostTipsSmallText.center = CGPoint(x: 160, y: viewY)
                        instagramPostTipsSmallText.textColor = .black
                        
                        // Checking how long a string
                        var tipLength = tip.count
                        tipLength = tipLength/10
                        
                        
                        instagramPostTipsSmallText.lineBreakMode = .byWordWrapping
                        instagramPostTipsSmallText.numberOfLines = 0
                        instagramPostTipsSmallText.textAlignment = .center
                        
                        instagramPostTipsSmallText.text = String(tip)
                        instagramPostTipsSmallText.center.x = self.view.center.x
                        instagramPostTipsSmallText.font = instagramPostTipsSmallText.font.withSize(16)
                        self.scrollView.addSubview(instagramPostTipsSmallText)
                    }
                }
                viewY = viewY + 200
            }
            let scrollViewHeightCGFloat = CGFloat(viewY + 100)
            self.scrollView.contentSize = CGSize(width: screenSize.width, height: scrollViewHeightCGFloat)
            self.view.addSubview(self.scrollView)
        }
    }
    @objc func instagramStreamToStreamSelectAndTipsSegueFunction(fromGesture gesture: UISwipeGestureRecognizer) {
        self.performSegue(withIdentifier: "instagramStreamToStreamSelectAndTipsSegue", sender: self)
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
