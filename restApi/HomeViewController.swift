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

class HomeViewController: UIViewController {
    @IBOutlet weak var labelWelcome: UILabel!
    @IBOutlet weak var numberOfFollow: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Putting all data in function
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
            
            // Getting data from auth
            let name = UserDefaults.standard.object(forKey: "name") as! String
            print(name)
            let competitionLink = UserDefaults.standard.stringArray(forKey: "competitionLink") ?? [String]()
            print(competitionLink)
            
            let competitionTitle = UserDefaults.standard.stringArray(forKey: "competitionTitle") ?? [String]()
            print(competitionLink)
            
            let totalNumberOfFollowers = UserDefaults.standard.object(forKey: "totalNumberOfFollowers") as! Int
            
            let tips = UserDefaults.standard.stringArray(forKey: "tips") ?? [String]()
            
            let twitterBio = UserDefaults.standard.object(forKey: "twitterBio") as! String
            print(twitterBio)
            
            let twitterFollowersHistoryDate = UserDefaults.standard.stringArray(forKey: "twitterFollowersHistoryDate") ?? [String]()
            
            let twitterFollowersHistoryFollowerCount = UserDefaults.standard.stringArray(forKey: "twitterFollowersHistoryFollowerCount") ?? [String]()

            
            
            // Getting Screensize
            let screenSize: CGRect = UIScreen.main.bounds
            
            // Creating Scrollong view
            var scrollView: UIScrollView!
            scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
            
            // Creating needed colors
            let blueButton = UIColor(red: 30/255.0, green: 144/255.0, blue: 255/255.0, alpha: 1.0)
            
            
            // Defining needed variables
            let viewHeight = 128
            var viewY = 100
            
            // Creating first view
            let topSummaryView = UIView(frame: CGRect(x: 0, y: viewY, width: Int(screenSize.width), height: viewHeight))
            topSummaryView.backgroundColor = UIColor.white
            topSummaryView.center.x = self.view.center.x
            scrollView.addSubview(topSummaryView)
            
            // Welcome label
            viewY = viewY + 25
            let welcomeLabel = UILabel(frame: CGRect(x: 0, y: 50, width: Int(screenSize.width), height: 160))
            welcomeLabel.center = CGPoint(x: 160, y: viewY)
            welcomeLabel.textColor = .black
            welcomeLabel.textAlignment = .center
            welcomeLabel.text = "Welcome, " + name
            welcomeLabel.center.x = self.view.center.x
            welcomeLabel.font = welcomeLabel.font.withSize(20)
            scrollView.addSubview(welcomeLabel)
            
            // Adding total number label
            viewY = viewY + 40
            let numberLabelNumber = UILabel(frame: CGRect(x: 0, y: 50, width: Int(screenSize.width), height: 160))
            numberLabelNumber.center = CGPoint(x: 160, y: viewY)
            numberLabelNumber.textColor = .black
            numberLabelNumber.textAlignment = .center
            numberLabelNumber.text = String(totalNumberOfFollowers)
            numberLabelNumber.center.x = self.view.center.x
            numberLabelNumber.font = numberLabelNumber.font.withSize(36)
            scrollView.addSubview(numberLabelNumber)
            
            viewY = viewY + 40
            let numberLabel = UILabel(frame: CGRect(x: 0, y: 50, width: Int(screenSize.width), height: 160))
            numberLabel.center = CGPoint(x: 160, y: viewY)
            numberLabel.textColor = .black
            numberLabel.textAlignment = .center
            numberLabel.text = "Total Number of Followers"
            numberLabel.center.x = self.view.center.x
            numberLabel.font = numberLabel.font.withSize(17)
            scrollView.addSubview(numberLabel)
            
            
            print("viewY")
            print(viewY)
            // Creating second view
            viewY = viewY + 75
            let twitterBioView = UIView(frame: CGRect(x: 0, y: viewY, width: Int(screenSize.width), height: viewHeight))
            twitterBioView.backgroundColor = UIColor.white
            twitterBioView.center.x = self.view.center.x
            scrollView.addSubview(twitterBioView)
            //        for tip in tips {
            //            print(tip)
            //            print(increasedHeight)
            //
            //            // Creating label
            //            let label = UILabel(frame: CGRect(x: 0, y: 40, width: screenSize.width - 10, height: 40))
            //            label.lineBreakMode = .byWordWrapping
            //            label.numberOfLines = 0
            //            increasedHeight = increasedHeight + 25
            //            label.center = CGPoint(x: 160, y: increasedHeight)
            //            label.textAlignment = .center
            //            label.center.x = self.view.center.x
            //            label.textColor = .black
            //            label.text = tip
            //            self.view.addSubview(label)
            //
            //        }
            // Displaying Bio
            viewY = viewY + 25
            let twitterBioTitle = UILabel(frame: CGRect(x: 0, y: 50, width: Int(screenSize.width), height: 160))
            twitterBioTitle.center = CGPoint(x: 160, y: viewY)
            twitterBioTitle.textColor = .black
            twitterBioTitle.textAlignment = .center
            twitterBioTitle.text = "Twitter Bio"
            twitterBioTitle.center.x = self.view.center.x
            twitterBioTitle.font = twitterBioTitle.font.withSize(20)
            scrollView.addSubview(twitterBioTitle)
            
            viewY = viewY + 50
            let twitterBioLabel = UILabel(frame: CGRect(x: Int(screenSize.width)/2, y: 50, width: Int(screenSize.width - 10), height: 160))
            twitterBioLabel.lineBreakMode = .byWordWrapping
            twitterBioLabel.numberOfLines = 0
            twitterBioLabel.center = CGPoint(x: 160, y: viewY)
            twitterBioLabel.center.x = self.view.center.x
            twitterBioLabel.textAlignment = .center
            twitterBioLabel.textColor = .black
            twitterBioLabel.text = twitterBio
            scrollView.addSubview(twitterBioLabel)
            
            // Adding graph to phone
            
            // Creating graph view
            viewY = viewY + 100
            let lineChartView = LineChartView(frame: CGRect(x: 0, y: viewY, width: Int(screenSize.width), height: viewHeight + 175))
            lineChartView.backgroundColor = UIColor.white
            lineChartView.center.x = self.view.center.x
            viewY = viewY + viewHeight
            
            // Importing graph
            let count = Int(arc4random_uniform(20) + 3)

            let values = (0..<count).map { (i) -> ChartDataEntry in
                let val = Double(arc4random_uniform(UInt32(count)) + 3)
                return ChartDataEntry(x: Double(i), y: val)
            }
            
            let set1 = LineChartDataSet(values: values, label: "Followers Twitter")
            let data = LineChartData(dataSet: set1)
            lineChartView.data = data
            scrollView.addSubview(lineChartView)
            
            // Competition View
            viewY = viewY + 265
            let competitionView = UIView(frame: CGRect(x: 0, y: viewY, width: Int(screenSize.width), height: viewHeight))
            competitionView.backgroundColor = UIColor.white
            competitionView.center.x = self.view.center.x
            
            scrollView.addSubview(competitionView)

            
            // Competition button and view change
            viewY = viewY + 64
            let competitionViewButton = UIButton(frame: CGRect(x: 0, y: 50, width: Int(screenSize.width)/2, height: 40))
            competitionViewButton.center = CGPoint(x: 225, y: viewY)
            competitionViewButton.backgroundColor = blueButton
            competitionViewButton.setTitle("Find Competition", for: .normal)
            competitionViewButton.center.x = self.view.center.x
            scrollView.addSubview(competitionViewButton)
            
            viewY = viewY + 36
            let competitionSmallText = UILabel(frame: CGRect(x: 0, y: 50, width: Int(screenSize.width), height: 160))
            competitionSmallText.center = CGPoint(x: 160, y: viewY)
            competitionSmallText.textColor = .black
            competitionSmallText.textAlignment = .center
            competitionSmallText.text = "These are Searches Related to your You"
            competitionSmallText.center.x = self.view.center.x
            competitionSmallText.font = competitionSmallText.font.withSize(12)
            scrollView.addSubview(competitionSmallText)
            
            // Followers Data
            viewY = viewY + 123
            let followersDataView = UIView(frame: CGRect(x: 0, y: viewY, width: Int(screenSize.width), height: viewHeight))
            followersDataView.backgroundColor = UIColor.white
            followersDataView.center.x = self.view.center.x
            scrollView.addSubview(followersDataView)
            
            
            // Followers data button and view change
            viewY = viewY + 64
            let followersDataViewButton = UIButton(frame: CGRect(x: 0, y: 50, width: Int(screenSize.width)/2, height: 40))
            followersDataViewButton.center = CGPoint(x: 225, y: viewY)
            followersDataViewButton.backgroundColor = blueButton
            followersDataViewButton.setTitle("Get Followers", for: .normal)
            followersDataViewButton.center.x = self.view.center.x
            scrollView.addSubview(followersDataViewButton)
            
            viewY = viewY + 36
            let followersDataSmallText = UILabel(frame: CGRect(x: 0, y: 50, width: Int(screenSize.width), height: 160))
            followersDataSmallText.center = CGPoint(x: 160, y: viewY)
            followersDataSmallText.textColor = .black
            followersDataSmallText.textAlignment = .center
            followersDataSmallText.text = "Find out data about your followers"
            followersDataSmallText.center.x = self.view.center.x
            followersDataSmallText.font = followersDataSmallText.font.withSize(12)
            scrollView.addSubview(followersDataSmallText)
            
            // Website Data
            viewY = viewY + 128
            let websiteView = UIView(frame: CGRect(x: 0, y: viewY, width: Int(screenSize.width), height: viewHeight*2))
            websiteView.backgroundColor = UIColor.white
            websiteView.center.x = self.view.center.x
            scrollView.addSubview(websiteView)
            
            print(viewY)
            
            viewY = viewY + 25
            let websiteTitle = UILabel(frame: CGRect(x: 0, y: 50, width: Int(screenSize.width), height: 160))
            websiteTitle.center = CGPoint(x: 160, y: viewY)
            websiteTitle.textColor = .black
            websiteTitle.textAlignment = .center
            websiteTitle.text = "Connected Website"
            websiteTitle.center.x = self.view.center.x
            websiteTitle.font = websiteTitle.font.withSize(20)
            scrollView.addSubview(websiteTitle)
            
            // Adding scroll view to main view
            let scrollHeight = viewY + 100
            scrollView.contentSize = CGSize(width: screenSize.width, height: 1700)
            self.view.addSubview(scrollView)
        }

        // Do any additional setup after loading the view.
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
