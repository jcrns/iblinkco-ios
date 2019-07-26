//
//  HomeViewController.swift
//  restApi
//
//  Created by HGPMAC87 on 4/13/19.
//  Copyright © 2019 iBlinkco. All rights reserved.
//

import UIKit

// Importing Chart Lib
import Charts

class HomeViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var labelWelcome: UILabel!
    @IBOutlet weak var numberOfFollow: UILabel!
    var scrollView: UIScrollView!
    // we set a variable to hold the contentOffSet before scroll view scrolls
    var lastContentOffset: CGFloat = 0
    
    // Refresh control

    lazy var refreshControlHome: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .gray
        refreshControl.addTarget(self, action: #selector(self.refreshPage), for: .valueChanged)
        return refreshControl
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Putting all data in function to run at the same time
        DispatchQueue.main.async {
            
            // Setting Background image
            UIGraphicsBeginImageContext(self.view.frame.size)
            UIImage(named: "skyscraper.jpg")!.draw(in: self.view.bounds)
            
            if let image = UIGraphicsGetImageFromCurrentImageContext(){
                UIGraphicsEndImageContext()
                self.view.backgroundColor = UIColor(patternImage: image)
            }else{
                UIGraphicsEndImageContext()
                debugPrint("Image not available")
            }
            
            // Recognizing swipe right gesture
            let aboutSwipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.homeToCompetitionAndWebsiteGestureFunction))
            aboutSwipeRightGesture.direction = UISwipeGestureRecognizer.Direction.left
            self.view.addGestureRecognizer(aboutSwipeRightGesture)
            
            
            // Getting data from auth
            let name = UserDefaults.standard.object(forKey: "name") as! String
            print(name)
            
            // Competition
            let competitionLink = UserDefaults.standard.stringArray(forKey: "competitionLink") ?? [String]()
            print(competitionLink)
            
            let competitionTitle = UserDefaults.standard.stringArray(forKey: "competitionTitle") ?? [String]()
            print(competitionLink)
            
            // Stats
            let totalNumberOfFollowers = UserDefaults.standard.object(forKey: "totalNumberOfFollowers") as! Int
            
            // Tips
            let tips = UserDefaults.standard.stringArray(forKey: "tips") ?? [String]()
            
            // Website data
            let websiteLinks = UserDefaults.standard.stringArray(forKey: "websiteLinks") ?? [String]()
            let websiteName = UserDefaults.standard.object(forKey: "websiteName") as! String
            let websiteUrl = UserDefaults.standard.object(forKey: "websiteUrl") as! String
            
            // Twitter Data
            let twitterBio = UserDefaults.standard.object(forKey: "twitterBio") as! String
            let twitterUsername = UserDefaults.standard.object(forKey: "twitterUsername") as! String
            let twitterFollowerCount = UserDefaults.standard.object(forKey: "twitterFollowerCount") as! Int
            let twitterFollowingCount = UserDefaults.standard.object(forKey: "twitterFollowingCount") as! Int
            
            // Instagram Data
            let instagramBio = UserDefaults.standard.object(forKey: "instagramBio") as! String
            let instagramUsername = UserDefaults.standard.object(forKey: "instagramUsername") as! String
            let instagramFollowerCount = UserDefaults.standard.object(forKey: "instagramFollowerCount") as! Int
            let instagramFollowingCount = UserDefaults.standard.object(forKey: "instagramFollowingCount") as! Int
            
            // History
            let twitterFollowersHistoryDate = UserDefaults.standard.stringArray(forKey: "twitterFollowersHistoryDate") ?? [String]()
            
            let twitterFollowersHistoryFollowerCount = UserDefaults.standard.stringArray(forKey: "twitterFollowersHistoryFollowerCount") ?? [String]()

            print("twitterFollowersHistoryFollowerCount")
            print(twitterFollowersHistoryFollowerCount)
            
            // Getting Screensize
            let screenSize: CGRect = UIScreen.main.bounds

//            self.scrollView.addSubview(refreshControl)
            print("refreshing")
//            refreshControl.endRefreshing()
            print("refreshed")
            let blackColor : UIColor = UIColor.black
            self.scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height - 75))
            self.scrollView.refreshControl = self.refreshControlHome
            
            // Creating needed colors
            let blueButton = UIColor(red: 30/255.0, green: 144/255.0, blue: 255/255.0, alpha: 1.0)
            let grayTextBox = UIColor(red: 192/255.0, green: 192/255.0, blue: 192/255.0, alpha: 1.0)
            
            // Defining needed variables
            let viewHeight = 128
            var viewY = 100
            
            // Creating first view
            let topSummaryView = UIView(frame: CGRect(x: 0, y: viewY, width: Int(screenSize.width), height: viewHeight))
            topSummaryView.backgroundColor = UIColor.white
            topSummaryView.center.x = self.view.center.x
            self.scrollView.addSubview(topSummaryView)
            
            // Welcome label
            viewY = viewY + 25
            let welcomeLabel = UILabel(frame: CGRect(x: 0, y: 50, width: Int(screenSize.width), height: 160))
            welcomeLabel.center = CGPoint(x: 160, y: viewY)
            welcomeLabel.textColor = .black
            welcomeLabel.textAlignment = .center
            welcomeLabel.text = "Welcome, " + name
            welcomeLabel.center.x = self.view.center.x
            welcomeLabel.font = welcomeLabel.font.withSize(20)
            self.scrollView.addSubview(welcomeLabel)
            
            // Adding total number label
            viewY = viewY + 40
            let numberLabelNumber = UILabel(frame: CGRect(x: 0, y: 50, width: Int(screenSize.width), height: 160))
            numberLabelNumber.center = CGPoint(x: 160, y: viewY)
            numberLabelNumber.textColor = .black
            numberLabelNumber.textAlignment = .center
            numberLabelNumber.text = String(totalNumberOfFollowers)
            numberLabelNumber.center.x = self.view.center.x
            numberLabelNumber.font = numberLabelNumber.font.withSize(36)
            self.scrollView.addSubview(numberLabelNumber)
            
            viewY = viewY + 40
            let numberLabel = UILabel(frame: CGRect(x: 0, y: 50, width: Int(screenSize.width), height: 160))
            numberLabel.center = CGPoint(x: 160, y: viewY)
            numberLabel.textColor = .black
            numberLabel.textAlignment = .center
            numberLabel.text = "Total Number of Followers"
            numberLabel.center.x = self.view.center.x
            numberLabel.font = numberLabel.font.withSize(17)
            self.scrollView.addSubview(numberLabel)
            
            
            print("viewY")
            print(viewY)

            // Displaying Bios
            if twitterUsername.isEmpty {

            } else {
                // Creating twitter view
                viewY = viewY + 75
                let twitterBioView = UIView(frame: CGRect(x: 0, y: viewY, width: Int(screenSize.width), height: viewHeight*2))
                twitterBioView.backgroundColor = UIColor.white
                twitterBioView.center.x = self.view.center.x
                self.scrollView.addSubview(twitterBioView)
                
                viewY = viewY + 25
                let twitterBioTitle = UILabel(frame: CGRect(x: 0, y: 50, width: Int(screenSize.width), height: 160))
                twitterBioTitle.center = CGPoint(x: 160, y: viewY)
                twitterBioTitle.textColor = .black
                twitterBioTitle.textAlignment = .center
                twitterBioTitle.text = twitterUsername + "(Twitter)"
                twitterBioTitle.center.x = self.view.center.x
                twitterBioTitle.font = twitterBioTitle.font.withSize(20)
                self.scrollView.addSubview(twitterBioTitle)
                
                viewY = viewY + 50
                let twitterBioLabel = UILabel(frame: CGRect(x: Int(screenSize.width)/2, y: 50, width: Int(screenSize.width - 10), height: 160))
                twitterBioLabel.lineBreakMode = .byWordWrapping
                twitterBioLabel.numberOfLines = 0
                twitterBioLabel.center = CGPoint(x: 160, y: viewY)
                twitterBioLabel.center.x = self.view.center.x
                twitterBioLabel.textAlignment = .center
                twitterBioLabel.textColor = .black
                twitterBioLabel.text = twitterBio
                self.scrollView.addSubview(twitterBioLabel)
                
                // Showing followers and following
                viewY = viewY + 75
                let twitterStatsCountLabel = UILabel(frame: CGRect(x: 0, y: 50, width: Int(screenSize.width), height: 160))
                twitterStatsCountLabel.center = CGPoint(x: 160, y: viewY)
                twitterStatsCountLabel.textColor = .black
                twitterStatsCountLabel.textAlignment = .center
                twitterStatsCountLabel.text = "Followers: " + String(twitterFollowerCount) + "  Following: " + String(twitterFollowingCount)
                twitterStatsCountLabel.center.x = self.view.center.x
                twitterStatsCountLabel.font = twitterStatsCountLabel.font.withSize(20)
                self.scrollView.addSubview(twitterStatsCountLabel)
                
                
                // Followers data button and view change
                viewY = viewY + 50
                let twitterStreamViewButton = UIButton(frame: CGRect(x: 0, y: 50, width: Int(screenSize.width)/2, height: 40))
                twitterStreamViewButton.center = CGPoint(x: 225, y: viewY)
                twitterStreamViewButton.backgroundColor = blueButton
                twitterStreamViewButton.setTitle("Twitter Stream", for: .normal)
                twitterStreamViewButton.center.x = self.view.center.x
                twitterStreamViewButton.addTarget(self, action: #selector(self.twitterStreamAction), for: .touchUpInside)
                
                self.scrollView.addSubview(twitterStreamViewButton)
                
                viewY = viewY + 36
                let twitterStreamViewSmallText = UILabel(frame: CGRect(x: 0, y: 50, width: Int(screenSize.width), height: 160))
                twitterStreamViewSmallText.center = CGPoint(x: 160, y: viewY)
                twitterStreamViewSmallText.textColor = .black
                twitterStreamViewSmallText.textAlignment = .center
                twitterStreamViewSmallText.text = "Showing your latest instagram post and analyzing them"
                twitterStreamViewSmallText.center.x = self.view.center.x
                twitterStreamViewSmallText.font = twitterStreamViewSmallText.font.withSize(12)
                self.scrollView.addSubview(twitterStreamViewSmallText)
            }
            
            if instagramUsername.isEmpty {

            } else {
                // Creating instagram view
                viewY = viewY + 100
                let instagramBioView = UIView(frame: CGRect(x: 0, y: viewY, width: Int(screenSize.width), height: viewHeight*2))
                instagramBioView.backgroundColor = UIColor.white
                instagramBioView.center.x = self.view.center.x
                self.scrollView.addSubview(instagramBioView)
                
                viewY = viewY + 25
                let instagramBioTitle = UILabel(frame: CGRect(x: 0, y: 50, width: Int(screenSize.width), height: 160))
                instagramBioTitle.center = CGPoint(x: 160, y: viewY)
                instagramBioTitle.textColor = .black
                instagramBioTitle.textAlignment = .center
                instagramBioTitle.text = instagramUsername + "(Instagram)"
                instagramBioTitle.center.x = self.view.center.x
                instagramBioTitle.font = instagramBioTitle.font.withSize(20)
                self.scrollView.addSubview(instagramBioTitle)
                
                viewY = viewY + 50
                let instagramBioLabel = UILabel(frame: CGRect(x: Int(screenSize.width)/2, y: 50, width: Int(screenSize.width - 10), height: 160))
                instagramBioLabel.lineBreakMode = .byWordWrapping
                instagramBioLabel.numberOfLines = 0
                instagramBioLabel.center = CGPoint(x: 160, y: viewY)
                instagramBioLabel.center.x = self.view.center.x
                instagramBioLabel.textAlignment = .center
                instagramBioLabel.textColor = .black
                instagramBioLabel.text = instagramBio
                self.scrollView.addSubview(instagramBioLabel)
                
                // Showing followers and following
                viewY = viewY + 75
                let instagramStatsCountLabel = UILabel(frame: CGRect(x: 0, y: 50, width: Int(screenSize.width), height: 160))
                instagramStatsCountLabel.center = CGPoint(x: 160, y: viewY)
                instagramStatsCountLabel.textColor = .black
                instagramStatsCountLabel.textAlignment = .center
                instagramStatsCountLabel.text = "Followers: " + String(instagramFollowerCount) + "  Following: " + String(instagramFollowingCount)
                instagramStatsCountLabel.center.x = self.view.center.x
                instagramStatsCountLabel.font = instagramStatsCountLabel.font.withSize(20)
                self.scrollView.addSubview(instagramStatsCountLabel)
                
                
                // Followers data button and view change
                viewY = viewY + 50
                let instagramStreamViewButton = UIButton(frame: CGRect(x: 0, y: 50, width: Int(screenSize.width)/2, height: 40))
                instagramStreamViewButton.center = CGPoint(x: 225, y: viewY)
                instagramStreamViewButton.backgroundColor = blueButton
                instagramStreamViewButton.setTitle("Instagram Stream", for: .normal)
                instagramStreamViewButton.center.x = self.view.center.x
                instagramStreamViewButton.addTarget(self, action: #selector(self.instagramStreamAction), for: .touchUpInside)
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
            
            // Displaying tips
            let tipsCount = tips.count*56
            viewY = viewY + 148
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
            
            
            // Adding graph to phone
            
            // Creating graph view
//            viewY = viewY + 164
//            let lineChartView = LineChartView(frame: CGRect(x: 0, y: viewY, width: Int(screenSize.width), height: viewHeight + 175))
//            lineChartView.backgroundColor = UIColor.white
//            lineChartView.center.x = self.view.center.x
//            viewY = viewY + viewHeight
//
//            // Importing graph
//            let count = Int(arc4random_uniform(20) + 3)
//
//            let values = (0..<count).map { (i) -> ChartDataEntry in
////                let val = Double(arc4random_uniform(UInt32(count)) + 3)
//                var val = 0.0
//                print(twitterFollowersHistoryFollowerCount)
//                for followers_count in twitterFollowersHistoryFollowerCount {
//                    print(twitterFollowersHistoryFollowerCount)
//                    val = Double(twitterFollowersHistoryFollowerCount[i])!
//                }
//                print("i")
//                print(i)
//                print(val)
//                return ChartDataEntry(x: Double(i), y: Double(val))
//            }
//
//            let set1 = LineChartDataSet(values: values, label: "Followers Twitter")
//            let data = LineChartData(dataSet: set1)
//            lineChartView.data = data
//            self.scrollView.addSubview(lineChartView)
            
            // Competition View
            viewY = viewY + 105
            let competitionView = UIView(frame: CGRect(x: 0, y: viewY, width: Int(screenSize.width), height: viewHeight))
            competitionView.backgroundColor = UIColor.white
            competitionView.center.x = self.view.center.x
            
            self.scrollView.addSubview(competitionView)

            
            // Competition button and view change
            viewY = viewY + 64
            print(competitionLink[0])
            if competitionLink[0] != "null"{
                print("Bet")
                let competitionViewButton = UIButton(frame: CGRect(x: 0, y: 50, width: Int(screenSize.width)/2, height: 40))
                competitionViewButton.center = CGPoint(x: 225, y: viewY)
                competitionViewButton.backgroundColor = blueButton
                competitionViewButton.setTitle("View Competition", for: .normal)
                competitionViewButton.center.x = self.view.center.x
                competitionViewButton.addTarget(self, action: #selector(self.findCompetitionButtonAction), for: .touchUpInside)
                self.scrollView.addSubview(competitionViewButton)
            } else {
                let competitionConnectTextBox = UITextField(frame: CGRect(x: 0, y: 50, width: Int(screenSize.width)/2, height: 40))
                competitionConnectTextBox.layer.borderColor = blackColor.cgColor
                competitionConnectTextBox.center = CGPoint(x: 225, y: viewY)
                competitionConnectTextBox.center.x = self.view.center.x
                competitionConnectTextBox.placeholder = "Find Competition"
                self.scrollView.addSubview(competitionConnectTextBox)
                print("Connected Competition")
                
            }
            
            viewY = viewY + 36
            let competitionSmallText = UILabel(frame: CGRect(x: 0, y: 50, width: Int(screenSize.width), height: 160))
            competitionSmallText.center = CGPoint(x: 160, y: viewY)
            competitionSmallText.textColor = .black
            competitionSmallText.textAlignment = .center
            competitionSmallText.text = "These are Searches Related to your You"
            competitionSmallText.center.x = self.view.center.x
            competitionSmallText.font = competitionSmallText.font.withSize(12)
            self.scrollView.addSubview(competitionSmallText)

            // Website Data
            let websiteLinkCount = websiteLinks.count*24
            viewY = viewY + 148
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
            // About button
            viewY = viewY + 28
            let aboutViewButton = UIButton(frame: CGRect(x: 0, y: 50, width: Int(screenSize.width)/2, height: 40))
            aboutViewButton.center = CGPoint(x: 225, y: viewY)
            aboutViewButton.backgroundColor = .white
            aboutViewButton.setTitleColor(.black, for: .normal)
            aboutViewButton.setTitle("About", for: .normal)
            aboutViewButton.center.x = self.view.center.x
            aboutViewButton.addTarget(self, action: #selector(self.aboutButtonAction), for: .touchUpInside)
            self.scrollView.addSubview(aboutViewButton)
            
            // Logout button
            viewY = viewY + 36
            let logoutHomeButton = UIButton(frame: CGRect(x: 0, y: 50, width: Int(screenSize.width)/2, height: 40))
            logoutHomeButton.center = CGPoint(x: 225, y: viewY)
            logoutHomeButton.backgroundColor = .white
            logoutHomeButton.setTitleColor(.red, for: .normal)
            logoutHomeButton.setTitle("Logout", for: .normal)
            logoutHomeButton.center.x = self.view.center.x
            logoutHomeButton.addTarget(self, action: #selector(self.logoutButtonAction), for: .touchUpInside)
            self.scrollView.addSubview(logoutHomeButton)
//            override func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//                
//                if(velocity.y>0){
//                    NSLog("dragging Up");
//                }else{
//                    NSLog("dragging Down");
//                }
//            }
            // Adding scroll view to main view
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
            homeImageBottomNavImageButton.setImage(UIImage(named: "icons8-home-filled-50.png"), for: .normal)
            self.view.addSubview(homeImageBottomNavImageButton)
            
            let tipsImageBottomNavImageButton = UIButton(frame: CGRect(x: Int(navItemX*2 - 75), y: Int(screenSize.height - 75), width:50, height: 50))
            tipsImageBottomNavImageButton.setImage(UIImage(named: "icons8-sheet-50.png"), for: .normal)
            self.view.addSubview(tipsImageBottomNavImageButton)
            
            let socialMediaImageBottomNavImageButton = UIButton(frame: CGRect(x: Int(navItemX*3 - 75), y: Int(screenSize.height - 75), width:50, height: 50))
            socialMediaImageBottomNavImageButton.setImage(UIImage(named: "icons8-news-feed-50.png"), for: .normal)
            self.view.addSubview(socialMediaImageBottomNavImageButton)
            
            let infoImageBottomNavImageButton = UIButton(frame: CGRect(x: Int(navItemX*4 - 75), y: Int(screenSize.height - 75), width:50, height: 50))
            infoImageBottomNavImageButton.setImage(UIImage(named: "icons8-info-50.png"), for: .normal)
            infoImageBottomNavImageButton.addTarget(self, action: #selector(self.aboutButtonAction), for: .touchUpInside)
            self.view.addSubview(infoImageBottomNavImageButton)

            
        }
        // Do any additional setup after loading the view.
    }
    // while scrolling this delegate is being called so you may now check which direction your scrollView is being scrolled to
    @objc func refreshHomeView(sender:AnyObject) {
        // Code to refresh table view
        print("It workedd")
    }
    @objc func findCompetitionButtonAction(sender: UIButton!) {
        print("Button tapped")
        self.performSegue(withIdentifier: "homeToCompetitionSegue", sender: self)
    }
    @objc func aboutButtonAction(sender: UIButton!) {
        print("Button tapped")
        self.performSegue(withIdentifier: "homeToAboutSegue", sender: self)
    }
    @objc func twitterStreamAction(sender: UIButton!) {
        self.performSegue(withIdentifier: "homeToTwitterStreamSegue", sender: self)
    }
    @objc func instagramStreamAction(sender: UIButton!) {
        self.performSegue(withIdentifier: "homeToInstagramStreamSegue", sender: self)
    }
    @objc func logoutButtonAction(sender: UIButton!) {
        print("Button tapped")
        // Clearing user defaults
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        
        self.performSegue(withIdentifier: "homeToAuthentication", sender: self)
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
        refreshControlHome.endRefreshing()
    }
    @objc func homeToCompetitionAndWebsiteGestureFunction(fromGesture gesture: UISwipeGestureRecognizer) {
        self.performSegue(withIdentifier: "homeToCompetitionAndWebsiteSegue", sender: self)
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
