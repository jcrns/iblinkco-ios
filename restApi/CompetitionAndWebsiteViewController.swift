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
    
    lazy var refreshControlCompetitionAndWebsite: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .gray
        refreshControl.addTarget(self, action: #selector(HomeViewController.refreshPage), for: .valueChanged)
        return refreshControl
    }()
    
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
            var competitionLink = UserDefaults.standard.stringArray(forKey: "competitionLink") ?? [String]()
            
            let websiteLinks = UserDefaults.standard.stringArray(forKey: "websiteLinks") ?? [String]()
            let websiteName = UserDefaults.standard.object(forKey: "websiteName") as! String
            let websiteUrl = UserDefaults.standard.object(forKey: "websiteUrl") as! String
            
            // Creating scroll view
            let screenSize: CGRect = UIScreen.main.bounds
            
            self.scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height - 75))
            
            // Refresh
            self.scrollView.refreshControl = self.refreshControlCompetitionAndWebsite
            
            // Recognizing swipe right gesture
            let aboutSwipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.competitionAndWebsiteToHomeGestureFunction))
            aboutSwipeRightGesture.direction = UISwipeGestureRecognizer.Direction.right
            self.view.addGestureRecognizer(aboutSwipeRightGesture)
            
            let aboutSwipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.competitionAndWebsiteToStreamSelectAndTipsGestureFunction))
            aboutSwipeLeftGesture.direction = UISwipeGestureRecognizer.Direction.left
            self.view.addGestureRecognizer(aboutSwipeLeftGesture)
            
            let blackColor : UIColor = UIColor.black
            
            var viewY = 100
            let viewHeight = 128
            // Competition
            if competitionLink[0] == "null" {
                print("aaalmnoioh iuno")
                
                let competitionView = UIView(frame: CGRect(x: 0, y: viewY, width: Int(screenSize.width), height: viewHeight+64))
                competitionView.backgroundColor = UIColor.white
                competitionView.center.x = self.view.center.x
                self.scrollView.addSubview(competitionView)
                
                viewY = viewY + 25
                let competitionTitle = UILabel(frame: CGRect(x: 0, y: 50, width: Int(screenSize.width), height: 160))
                competitionTitle.center = CGPoint(x: 160, y: viewY)
                competitionTitle.textColor = .black
                competitionTitle.textAlignment = .center
                competitionTitle.text = "Connect Competion"
                competitionTitle.center.x = self.view.center.x
                competitionTitle.font = competitionTitle.font.withSize(20)
                self.scrollView.addSubview(competitionTitle)
                
                viewY = viewY + 30
                
                let competitionConnectTextBox = UITextField(frame: CGRect(x: 0, y: 50, width: Int(screenSize.width), height: 40))
                competitionConnectTextBox.layer.borderColor = blackColor.cgColor
                competitionConnectTextBox.center = CGPoint(x: 225, y: viewY)
                competitionConnectTextBox.center.x = self.view.center.x
                competitionConnectTextBox.placeholder = "Enter your niche or business type"
                self.scrollView.addSubview(competitionConnectTextBox)
                
                viewY = viewY + 200
            } else {
                let competitionCount = competitionTitle.count - 1
                for i in 0...competitionCount {
                    // Creating view for post
                    let competitionView = UIView(frame: CGRect(x: 0, y: viewY, width: Int(screenSize.width - 10), height: viewHeight + 20))
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
                    let competitionLinkButton = UIButton(frame: CGRect(x: 0, y: 75, width: Int(screenSize.width), height: 70))
                    competitionLinkButton.center = CGPoint(x: 160, y: viewY)
                    competitionLinkButton.setTitleColor(UIColor.black, for: .normal)
                    competitionLinkButton.titleLabel?.lineBreakMode = .byWordWrapping
                    competitionLinkButton.titleLabel?.numberOfLines = 0
                    competitionLinkButton.backgroundColor = .white
                    competitionLinkButton.titleLabel?.textAlignment = .center
                    competitionLinkButton.backgroundColor = .clear
                    competitionLinkButton.setTitleColor(.black, for: .normal)
                    competitionLinkButton.setTitle(competitionLink[i], for: .normal)
                    competitionLinkButton.center.x = self.view.center.x
                    competitionLinkButton.tag = i
                    competitionLinkButton.addTarget(self, action: #selector(self.openCompetitionLink), for: .touchUpInside)
                    self.scrollView.addSubview(competitionLinkButton)
                    
                    viewY = viewY + 108
                }
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
            homeImageBottomNavImageButton.addTarget(self, action: #selector(self.homeButtonAction), for: .touchUpInside)
            self.view.addSubview(homeImageBottomNavImageButton)
            
            let tipsImageBottomNavImageButton = UIButton(frame: CGRect(x: Int(navItemX*2 - 75), y: Int(screenSize.height - 75), width:50, height: 50))
            tipsImageBottomNavImageButton.setImage(UIImage(named: "icons8-sheet-filled-50.png"), for: .normal)
            self.view.addSubview(tipsImageBottomNavImageButton)
            
            let socialMediaImageBottomNavImageButton = UIButton(frame: CGRect(x: Int(navItemX*3 - 75), y: Int(screenSize.height - 75), width:50, height: 50))
            socialMediaImageBottomNavImageButton.setImage(UIImage(named: "icons8-news-feed-50.png"), for: .normal)
            socialMediaImageBottomNavImageButton.addTarget(self, action: #selector(self.streamSelectAndTipsButtonAction), for: .touchUpInside)
            self.view.addSubview(socialMediaImageBottomNavImageButton)
            
            let infoImageBottomNavImageButton = UIButton(frame: CGRect(x: Int(navItemX*4 - 75), y: Int(screenSize.height - 75), width:50, height: 50))
            infoImageBottomNavImageButton.setImage(UIImage(named: "icons8-info-50.png"), for: .normal)
            infoImageBottomNavImageButton.addTarget(self, action: #selector(self.aboutButtonAction), for: .touchUpInside)
            self.view.addSubview(infoImageBottomNavImageButton)
        }
    }
    // Navigation actions
    @objc func homeButtonAction(sender: UIButton!) {
        print("Button tapped")
        self.performSegue(withIdentifier: "competitionAndWebsiteToHomeSegue", sender: self)
    }
    @objc func streamSelectAndTipsButtonAction(sender: UIButton!) {
        print("Button tapped")
        self.performSegue(withIdentifier: "competitionAndWebsiteToStreamSelectAndTipsSegue", sender: self)
    }
    @objc func aboutButtonAction(sender: UIButton!) {
        print("Button tapped")
        self.performSegue(withIdentifier: "competitionAndWebsiteToAboutSegue", sender: self)
    }

    
    @objc func competitionAndWebsiteToHomeGestureFunction(fromGesture gesture: UISwipeGestureRecognizer) {
        self.performSegue(withIdentifier: "competitionAndWebsiteToHomeSegue", sender: self)
    }
    @objc func competitionAndWebsiteToStreamSelectAndTipsGestureFunction(fromGesture gesture: UISwipeGestureRecognizer) {
        self.performSegue(withIdentifier: "competitionAndWebsiteToStreamSelectAndTipsSegue", sender: self)
    }
    
    // Refresh function
    @objc func refreshPage(){
        print("ekfbeigkrtdbgigk")
        let email = UserDefaults.standard.object(forKey: "email") as! String
        let password = UserDefaults.standard.object(forKey: "password") as! String
        print(email)
        print(password)
        AuthenticationViewController().callApi(email: email, password: password)
        print("ppdergwrbrwg")
        DispatchQueue.main.async{
            self.view.setNeedsLayout()
        }
        refreshControlCompetitionAndWebsite.endRefreshing()
    }
    
    // Func to make links external
    @objc func openCompetitionLink(sender: UIButton!) {
        print("sde")
        let senderInt = sender.tag
        let competitionLink = UserDefaults.standard.stringArray(forKey: "competitionLink") ?? [String]()
        let urlStr = competitionLink[senderInt]
        if let url = URL(string:urlStr), !url.absoluteString.isEmpty {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
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
