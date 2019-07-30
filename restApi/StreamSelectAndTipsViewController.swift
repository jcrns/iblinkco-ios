//
//  streamSelectAndTipsViewController.swift
//  restApi
//
//  Created by HGPMAC87 on 7/25/19.
//  Copyright © 2019 iBlinkco. All rights reserved.
//

import UIKit

class StreamSelectAndTipsViewController: UIViewController {
    var scrollView: UIScrollView!
    
    lazy var refreshControlStreamSelectAndTips: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .gray
        refreshControl.addTarget(self, action: #selector(self.refreshPage), for: .valueChanged)
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
            
            // Adding screen size
            let screenSize: CGRect = UIScreen.main.bounds
            
            let blueButton = UIColor(red: 30/255.0, green: 144/255.0, blue: 255/255.0, alpha: 1.0)
            let blackColor : UIColor = UIColor.black
            
            // Creating scroll view
            self.scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height-75))
            
            // Refresh
            self.scrollView.refreshControl = self.refreshControlStreamSelectAndTips
            
            // Recognizing swipe right gesture
            let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.streamSelectAndTipsToCompetitionAndWebsiteGestureFunction))
            swipeRightGesture.direction = UISwipeGestureRecognizer.Direction.right
            self.view.addGestureRecognizer(swipeRightGesture)
            
            let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.streamSelectAndTipsToAboutGestureFunction))
            swipeLeftGesture.direction = UISwipeGestureRecognizer.Direction.left
            self.view.addGestureRecognizer(swipeLeftGesture)
            
            // Getting data
            let twitterUsername = UserDefaults.standard.object(forKey: "twitterUsername") as! String
            let instagramUsername = UserDefaults.standard.object(forKey: "instagramUsername") as! String
            let tips = UserDefaults.standard.stringArray(forKey: "tips") ?? [String]()
            
            var viewY = 100
            let viewHeight = 128
            
            // Displaying tips
            let tipsCount = tips.count*56
            let tipsView = UIView(frame: CGRect(x: 0, y: viewY, width: Int(screenSize.width), height: viewHeight+tipsCount+32))
            tipsView.backgroundColor = UIColor.white
            tipsView.center.x = self.view.center.x
            self.scrollView.addSubview(tipsView)
            print(viewY)
            
            
            viewY = viewY + 25
            let tipsTitle = UILabel(frame: CGRect(x: 0, y: 50, width: Int(screenSize.width), height: 160))
            tipsTitle.center = CGPoint(x: 160, y: viewY)
            tipsTitle.textColor = .black
            tipsTitle.textAlignment = .center
            tipsTitle.text = "Main Tips"
            tipsTitle.center.x = self.view.center.x
            tipsTitle.font = tipsTitle.font.withSize(20)
            self.scrollView.addSubview(tipsTitle)
            
            viewY = viewY + 36
            let tipsSmallText = UILabel(frame: CGRect(x: 0, y: 50, width: Int(screenSize.width), height: 160))
            tipsSmallText.center = CGPoint(x: 160, y: viewY)
            tipsSmallText.textColor = .black
            tipsSmallText.textAlignment = .center
            tipsSmallText.text = "Showing tips for your social media accounts"
            tipsSmallText.center.x = self.view.center.x
            tipsSmallText.font = tipsSmallText.font.withSize(12)
            self.scrollView.addSubview(tipsSmallText)
            
            viewY = viewY + 24
            for tip in tips {
                print(tip)
                viewY = viewY + 60
                // Creating label
                let label = UILabel(frame: CGRect(x: 0, y: 40, width: screenSize.width - 10, height: 160))
                label.lineBreakMode = .byWordWrapping
                label.numberOfLines = 0
                label.center = CGPoint(x: 160, y: viewY)
                label.textAlignment = .center
                label.center.x = self.view.center.x
                label.textColor = .black
                label.text = tip
                self.scrollView.addSubview(label)
            }
            
            // Displaying Bios
            if twitterUsername.isEmpty {
                // Creating twitter view
                viewY = viewY + 75
                let instagramView = UIView(frame: CGRect(x: 0, y: viewY, width: Int(screenSize.width), height: viewHeight))
                instagramView.backgroundColor = UIColor.white
                instagramView.center.x = self.view.center.x
                self.scrollView.addSubview(instagramView)
                
                viewY = viewY + 75
                let instagramConnectTextBox = UITextField(frame: CGRect(x: 0, y: 50, width: Int(screenSize.width)/2, height: 40))
                instagramConnectTextBox.layer.borderColor = blackColor.cgColor
                instagramConnectTextBox.center = CGPoint(x: 225, y: viewY)
                instagramConnectTextBox.center.x = self.view.center.x
                instagramConnectTextBox.placeholder = "Connect Twitter"
                self.scrollView.addSubview(instagramConnectTextBox)
            } else {
                // Creating twitter view
                viewY = viewY + 75
                let twitterBioView = UIView(frame: CGRect(x: 0, y: viewY, width: Int(screenSize.width), height: viewHeight))
                twitterBioView.backgroundColor = UIColor.white
                twitterBioView.center.x = self.view.center.x
                self.scrollView.addSubview(twitterBioView)
                
                
                
                // Followers data button and view change
                viewY = viewY + 50
                let twitterStreamViewButton = UIButton(frame: CGRect(x: 0, y: 50, width: Int(screenSize.width)/2, height: 40))
                twitterStreamViewButton.center = CGPoint(x: 225, y: viewY)
                twitterStreamViewButton.backgroundColor = blueButton
                twitterStreamViewButton.setTitle("Twitter Stream", for: .normal)
                twitterStreamViewButton.center.x = self.view.center.x
                twitterStreamViewButton.addTarget(self, action: #selector(self.streamSelectAndTipsToTwitterStreamButtonAction), for: .touchUpInside)
                
                self.scrollView.addSubview(twitterStreamViewButton)
                
                viewY = viewY + 36
                let twitterStreamViewSmallText = UILabel(frame: CGRect(x: 0, y: 50, width: Int(screenSize.width), height: 160))
                twitterStreamViewSmallText.center = CGPoint(x: 160, y: viewY)
                twitterStreamViewSmallText.textColor = .black
                twitterStreamViewSmallText.textAlignment = .center
                twitterStreamViewSmallText.text = "Showing your latest tweets and analyzing them"
                twitterStreamViewSmallText.center.x = self.view.center.x
                twitterStreamViewSmallText.font = twitterStreamViewSmallText.font.withSize(12)
                self.scrollView.addSubview(twitterStreamViewSmallText)
            }
            
            if instagramUsername.isEmpty {
                viewY = viewY + 100
                let instagramBioView = UIView(frame: CGRect(x: 0, y: viewY, width: Int(screenSize.width), height: viewHeight))
                instagramBioView.backgroundColor = UIColor.white
                instagramBioView.center.x = self.view.center.x
                self.scrollView.addSubview(instagramBioView)
                
                viewY = viewY + 25
                let instagramConnectTextBox = UITextField(frame: CGRect(x: 0, y: 50, width: Int(screenSize.width)/2, height: 40))
                instagramConnectTextBox.layer.borderColor = blackColor.cgColor
                instagramConnectTextBox.center = CGPoint(x: 225, y: viewY)
                instagramConnectTextBox.center.x = self.view.center.x
                instagramConnectTextBox.placeholder = "Connect Instagram"
                self.scrollView.addSubview(instagramConnectTextBox)
            } else {
                // Creating instagram view
                viewY = viewY + 100
                let instagramBioView = UIView(frame: CGRect(x: 0, y: viewY, width: Int(screenSize.width), height: viewHeight))
                instagramBioView.backgroundColor = UIColor.white
                instagramBioView.center.x = self.view.center.x
                self.scrollView.addSubview(instagramBioView)
                
                
                // Followers data button and view change
                viewY = viewY + 50
                let instagramStreamViewButton = UIButton(frame: CGRect(x: 0, y: 50, width: Int(screenSize.width)/2, height: 40))
                instagramStreamViewButton.center = CGPoint(x: 225, y: viewY)
                instagramStreamViewButton.backgroundColor = blueButton
                instagramStreamViewButton.setTitle("Instagram Stream", for: .normal)
                instagramStreamViewButton.center.x = self.view.center.x
                instagramStreamViewButton.addTarget(self, action: #selector(self.streamSelectAndTipsToInstagramStreamButtonAction), for: .touchUpInside)
                //
                self.scrollView.addSubview(instagramStreamViewButton)
                
                viewY = viewY + 36
                let instagramStreamViewSmallText = UILabel(frame: CGRect(x: 0, y: 50, width: Int(screenSize.width), height: 160))
                instagramStreamViewSmallText.center = CGPoint(x: 160, y: viewY)
                instagramStreamViewSmallText.textColor = .black
                instagramStreamViewSmallText.textAlignment = .center
                instagramStreamViewSmallText.text = "Showing your latest instagram post and analyzing them"
                instagramStreamViewSmallText.center.x = self.view.center.x
                instagramStreamViewSmallText.font = instagramStreamViewSmallText.font.withSize(12)
                self.scrollView.addSubview(instagramStreamViewSmallText)
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
            tipsImageBottomNavImageButton.setImage(UIImage(named: "icons8-sheet-50.png"), for: .normal)
            tipsImageBottomNavImageButton.addTarget(self, action: #selector(self.competitionAndWebsiteButtonAction), for: .touchUpInside)
            self.view.addSubview(tipsImageBottomNavImageButton)
            
            let socialMediaImageBottomNavImageButton = UIButton(frame: CGRect(x: Int(navItemX*3 - 75), y: Int(screenSize.height - 75), width:50, height: 50))
            socialMediaImageBottomNavImageButton.setImage(UIImage(named: "icons8-news-feed-filled-50.png"), for: .normal)
            self.view.addSubview(socialMediaImageBottomNavImageButton)
            
            let infoImageBottomNavImageButton = UIButton(frame: CGRect(x: Int(navItemX*4 - 75), y: Int(screenSize.height - 75), width:50, height: 50))
            infoImageBottomNavImageButton.setImage(UIImage(named: "icons8-info-50.png"), for: .normal)
            infoImageBottomNavImageButton.addTarget(self, action: #selector(self.aboutButtonAction), for: .touchUpInside)
            self.view.addSubview(infoImageBottomNavImageButton)

        }
        // Do any additional setup after loading the view.
    }
    // Navigation actions
    @objc func homeButtonAction(sender: UIButton!) {
        print("Button tapped")
        self.performSegue(withIdentifier: "streamSelectAndTipsToHomeSegue", sender: self)
    }
    @objc func competitionAndWebsiteButtonAction(sender: UIButton!) {
        print("Button tapped")
        self.performSegue(withIdentifier: "streamSelectAndTipsToCompetitionAndWebsiteSegue", sender: self)
    }
    @objc func aboutButtonAction(sender: UIButton!) {
        print("Button tapped")
        self.performSegue(withIdentifier: "streamSelectAndTipsToAboutSegue", sender: self)
    }

    
    @objc func streamSelectAndTipsToCompetitionAndWebsiteGestureFunction(fromGesture gesture: UISwipeGestureRecognizer) {
        self.performSegue(withIdentifier: "streamSelectAndTipsToCompetitionAndWebsiteSegue", sender: self)
    }
    @objc func streamSelectAndTipsToAboutGestureFunction(fromGesture gesture: UISwipeGestureRecognizer) {
        self.performSegue(withIdentifier: "streamSelectAndTipsToAboutSegue", sender: self)
    }
    @objc func streamSelectAndTipsToInstagramStreamButtonAction(sender: UIButton!) {
        self.performSegue(withIdentifier: "streamSelectAndTipsToInstagramStreamSegue", sender: self)
    }
    @objc func streamSelectAndTipsToTwitterStreamButtonAction(sender: UIButton!) {
        self.performSegue(withIdentifier: "streamSelectAndTipsToTwitterStreamSegue", sender: self)
    }
    
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
        refreshControlStreamSelectAndTips.endRefreshing()
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
