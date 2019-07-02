//
//  HomeViewController.swift
//  restApi
//
//  Created by HGPMAC87 on 4/13/19.
//  Copyright © 2019 iBlinkco. All rights reserved.
//

import UIKit

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
            
            
            // Getting Screensize
            let screenSize: CGRect = UIScreen.main.bounds
            
            // Creating Scrollong view
            var scrollView: UIScrollView!
            scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
            
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
            viewY = viewY + 100
            let graphFollowersView = UIView(frame: CGRect(x: 0, y: viewY, width: Int(screenSize.width), height: viewHeight + 175))
            graphFollowersView.backgroundColor = UIColor.white
            graphFollowersView.center.x = self.view.center.x
            scrollView.addSubview(graphFollowersView)
            print("viewY")
            
            // Adding scroll view to main view
            scrollView.contentSize = CGSize(width: screenSize.width, height: 2000)
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
