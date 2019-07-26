//
//  competitionAndWebsiteViewController.swift
//  restApi
//
//  Created by HGPMAC87 on 7/25/19.
//  Copyright © 2019 iBlinkco. All rights reserved.
//

import UIKit

class CompetitionAndWebsiteViewController: UIViewController {
    var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            
            // Setting Background image
            UIGraphicsBeginImageContext(self.view.frame.size)
            UIImage(named: "thesky.jpg")!.draw(in: self.view.bounds)
            
            if let image = UIGraphicsGetImageFromCurrentImageContext(){
                UIGraphicsEndImageContext()
                self.view.backgroundColor = UIColor(patternImage: image)
            }else{
                UIGraphicsEndImageContext()
                debugPrint("Image not available")
            }
            
            // Getting data
            let competitionTitle = UserDefaults.standard.stringArray(forKey: "competitionTitle") ?? [String]()
            let competitionLink = UserDefaults.standard.stringArray(forKey: "competitionLink") ?? [String]()
            
            let websiteLinks = UserDefaults.standard.stringArray(forKey: "websiteLinks") ?? [String]()
            let websiteName = UserDefaults.standard.object(forKey: "websiteName") as! String
            let websiteUrl = UserDefaults.standard.object(forKey: "websiteUrl") as! String
            
            
            // Recognizing swipe right gesture
            let aboutSwipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.competitionAndWebsiteToHomeGestureFunction))
            aboutSwipeRightGesture.direction = UISwipeGestureRecognizer.Direction.right
            self.view.addGestureRecognizer(aboutSwipeRightGesture)
            
            let aboutSwipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.competitionAndWebsiteToStreamSelectAndTipsGestureFunction))
            aboutSwipeLeftGesture.direction = UISwipeGestureRecognizer.Direction.left
            self.view.addGestureRecognizer(aboutSwipeLeftGesture)
            
            // Creating scroll view
            let screenSize: CGRect = UIScreen.main.bounds
            
            let blackColor : UIColor = UIColor.black
            
            self.scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height - 75))
            var viewY = 100
            let viewHeight = 128
            // Competition
            let competitionCount = competitionTitle.count - 1
            for i in 0...competitionCount {
                // Creating view for post
                let competitionView = UIView(frame: CGRect(x: 0, y: viewY, width: Int(screenSize.width - 10), height: viewHeight))
                competitionView.layer.cornerRadius = 8.0
                competitionView.backgroundColor = UIColor.white
                competitionView.center.x = self.view.center.x
                self.scrollView.addSubview(competitionView)
                
                viewY = viewY + 30
                let competitionNameLabel = UILabel(frame: CGRect(x: 0, y: 100, width: Int(screenSize.width), height: 240))
                competitionNameLabel.center = CGPoint(x: 160, y: viewY)
                competitionNameLabel.textColor = .black
                competitionNameLabel.lineBreakMode = .byWordWrapping
                competitionNameLabel.numberOfLines = 0
                competitionNameLabel.textAlignment = .center
                competitionNameLabel.text = competitionTitle[i]
                competitionNameLabel.center.x = self.view.center.x
                competitionNameLabel.font = competitionNameLabel.font.withSize(18)
                self.scrollView.addSubview(competitionNameLabel)
                
                viewY = viewY + 56
                let competitionLinkLabel = UILabel(frame: CGRect(x: 0, y: 75, width: Int(screenSize.width), height: 160))
                competitionLinkLabel.center = CGPoint(x: 160, y: viewY)
                competitionLinkLabel.textColor = .black
                
                
                competitionLinkLabel.lineBreakMode = .byWordWrapping
                competitionLinkLabel.numberOfLines = 0
                competitionLinkLabel.textAlignment = .center
                
                competitionLinkLabel.text = competitionLink[i]
                competitionLinkLabel.center.x = self.view.center.x
                competitionLinkLabel.font = competitionLinkLabel.font.withSize(16)
                self.scrollView.addSubview(competitionLinkLabel)
                
                viewY = viewY + 96
            }
            
            // Website Data
            let websiteLinkCount = websiteLinks.count*24
            let websiteView = UIView(frame: CGRect(x: 0, y: viewY, width: Int(screenSize.width), height: viewHeight+websiteLinkCount+64))
            websiteView.backgroundColor = UIColor.white
            websiteView.center.x = self.view.center.x
            self.scrollView.addSubview(websiteView)
            print(viewY)
            
            viewY = viewY + 25
            let websiteTitle = UILabel(frame: CGRect(x: 0, y: 50, width: Int(screenSize.width), height: 160))
            websiteTitle.center = CGPoint(x: 160, y: viewY)
            websiteTitle.textColor = .black
            websiteTitle.textAlignment = .center
            websiteTitle.text = "Connected Website"
            websiteTitle.center.x = self.view.center.x
            websiteTitle.font = websiteTitle.font.withSize(20)
            self.scrollView.addSubview(websiteTitle)
            
            viewY = viewY + 36
            let websiteSmallText = UILabel(frame: CGRect(x: 0, y: 50, width: Int(screenSize.width), height: 160))
            websiteSmallText.center = CGPoint(x: 160, y: viewY)
            websiteSmallText.textColor = .black
            websiteSmallText.textAlignment = .center
            websiteSmallText.text = "Find out data about your followers"
            websiteSmallText.center.x = self.view.center.x
            websiteSmallText.font = websiteSmallText.font.withSize(12)
            self.scrollView.addSubview(websiteSmallText)
            
            viewY = viewY + 24
            if websiteLinks[0] != "null" {
                for websiteLink in websiteLinks {
                    print(websiteLink)
                    
                    // Creating label
                    let label = UILabel(frame: CGRect(x: 0, y: 40, width: screenSize.width - 10, height: 40))
                    label.lineBreakMode = .byWordWrapping
                    label.numberOfLines = 0
                    viewY = viewY + 25
                    label.center = CGPoint(x: 160, y: viewY)
                    label.textAlignment = .center
                    label.center.x = self.view.center.x
                    label.textColor = .black
                    label.text = websiteLink
                    self.scrollView.addSubview(label)
                    
                }
            } else {
                let websiteConnectTextBox = UITextField(frame: CGRect(x: 0, y: 50, width: Int(screenSize.width)/2, height: 40))
                websiteConnectTextBox.layer.borderColor = blackColor.cgColor
                websiteConnectTextBox.center = CGPoint(x: 225, y: viewY)
                websiteConnectTextBox.center.x = self.view.center.x
                websiteConnectTextBox.placeholder = "Connect your Website"
                self.scrollView.addSubview(websiteConnectTextBox)
            }
            
            // Appending all
            let scrollViewHeightCGFloat = CGFloat(viewY + 100)
            self.scrollView.contentSize = CGSize(width: screenSize.width, height: scrollViewHeightCGFloat)
            self.view.addSubview(self.scrollView)
            
            // Creating bottom docked nav
            let homeBottomDockedNav = UIView(frame: CGRect(x: 0, y: Int(screenSize.height - 75), width: Int(screenSize.width), height: 75))
            homeBottomDockedNav.backgroundColor = .white
            self.view.addSubview(homeBottomDockedNav)
            
            let navItemX = screenSize.width/4
            
            // Dock Images
            let homeImageBottomNavImageButton = UIButton(frame: CGRect(x: Int(navItemX - 75), y: Int(screenSize.height - 75), width:50, height: 50))
            homeImageBottomNavImageButton.setImage(UIImage(named: "icons8-home-50.png"), for: .normal)
            self.view.addSubview(homeImageBottomNavImageButton)
            
            let tipsImageBottomNavImageButton = UIButton(frame: CGRect(x: Int(navItemX*2 - 75), y: Int(screenSize.height - 75), width:50, height: 50))
            tipsImageBottomNavImageButton.setImage(UIImage(named: "icons8-sheet-filled-50.png"), for: .normal)
            self.view.addSubview(tipsImageBottomNavImageButton)
            
            let socialMediaImageBottomNavImageButton = UIButton(frame: CGRect(x: Int(navItemX*3 - 75), y: Int(screenSize.height - 75), width:50, height: 50))
            socialMediaImageBottomNavImageButton.setImage(UIImage(named: "icons8-news-feed-50.png"), for: .normal)
            self.view.addSubview(socialMediaImageBottomNavImageButton)
            
            let infoImageBottomNavImageButton = UIButton(frame: CGRect(x: Int(navItemX*4 - 75), y: Int(screenSize.height - 75), width:50, height: 50))
            infoImageBottomNavImageButton.setImage(UIImage(named: "icons8-info-50.png"), for: .normal)
            //            infoImageBottomNavImageButton.addTarget(self, action: #selector(self.aboutButtonAction), for: .touchUpInside)
            self.view.addSubview(infoImageBottomNavImageButton)
        }
    }
    
    @objc func competitionAndWebsiteToHomeGestureFunction(fromGesture gesture: UISwipeGestureRecognizer) {
        self.performSegue(withIdentifier: "competitionAndWebsiteToHomeSegue", sender: self)
    }
    @objc func competitionAndWebsiteToStreamSelectAndTipsGestureFunction(fromGesture gesture: UISwipeGestureRecognizer) {
        self.performSegue(withIdentifier: "competitionAndWebsiteToStreamSelectAndTipsSegue", sender: self)
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
