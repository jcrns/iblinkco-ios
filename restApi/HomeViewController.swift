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
            
            
            // Adding graph to phone
            
            // Creating graph view
            viewY = viewY + 81
            let lineChartView = LineChartView(frame: CGRect(x: 0, y: viewY, width: Int(screenSize.width), height: viewHeight + 200))
            lineChartView.backgroundColor = UIColor.white
            lineChartView.center.x = self.view.center.x
            viewY = viewY + viewHeight

            // Importing graph
            let count = Int(arc4random_uniform(20) + 3)

            let values = (0..<count).map { (i) -> ChartDataEntry in
//                let val = Double(arc4random_uniform(UInt32(count)) + 3)
                var val = 0.0
                print(twitterFollowersHistoryFollowerCount)
                for followers_count in twitterFollowersHistoryFollowerCount {
                    print(twitterFollowersHistoryFollowerCount)
                    val = Double(twitterFollowersHistoryFollowerCount[i])!
                }
                print("i")
                print(i)
                print(val)
                return ChartDataEntry(x: Double(i), y: Double(val))
            }

            let set1 = LineChartDataSet(values: values, label: "Followers Twitter")
            let data = LineChartData(dataSet: set1)
            lineChartView.data = data
            self.scrollView.addSubview(lineChartView)
            

        
            
            viewY = viewY + 164
            let followersTrendSmallText = UILabel(frame: CGRect(x: 0, y: 50, width: Int(screenSize.width), height: 160))
            followersTrendSmallText.center = CGPoint(x: 160, y: viewY)
            followersTrendSmallText.textColor = .black
            followersTrendSmallText.textAlignment = .center
            followersTrendSmallText.text = "Here's a graph for your recent amounts of followers"
            followersTrendSmallText.center.x = self.view.center.x
            followersTrendSmallText.font = followersTrendSmallText.font.withSize(12)
            self.scrollView.addSubview(followersTrendSmallText)

            // Website Data
            viewY = viewY + 164
            let websiteView = UIView(frame: CGRect(x: 0, y: viewY, width: Int(screenSize.width), height: viewHeight - 36))
            websiteView.backgroundColor = UIColor.white
            websiteView.center.x = self.view.center.x
            self.scrollView.addSubview(websiteView)
            print(viewY)
            
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
