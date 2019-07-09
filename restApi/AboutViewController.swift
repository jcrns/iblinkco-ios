//
//  AboutViewController.swift
//  restApi
//
//  Created by HGPMAC87 on 7/9/19.
//  Copyright © 2019 iBlinkco. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenSize: CGRect = UIScreen.main.bounds
        
        // About title
        var viewY = 48
        let aboutTitleTextLabel = UILabel(frame: CGRect(x: Int(screenSize.width)/2, y: 50, width: Int(screenSize.width - 10), height: 160))
        aboutTitleTextLabel.lineBreakMode = .byWordWrapping
        aboutTitleTextLabel.numberOfLines = 0
        aboutTitleTextLabel.center = CGPoint(x: 160, y: viewY)
        aboutTitleTextLabel.center.x = self.view.center.x
        aboutTitleTextLabel.textAlignment = .center
        aboutTitleTextLabel.textColor = .black
        aboutTitleTextLabel.text = "About"
        aboutTitleTextLabel.font = UIFont.boldSystemFont(ofSize: 28.0)
        self.view.addSubview(aboutTitleTextLabel)
        
        // Mission Statement
        viewY = viewY + 72
        let missionStatementTextLabel = UILabel(frame: CGRect(x: Int(screenSize.width)/2, y: 50, width: Int(screenSize.width - 10), height: 160))
        missionStatementTextLabel.lineBreakMode = .byWordWrapping
        missionStatementTextLabel.numberOfLines = 0
        missionStatementTextLabel.center = CGPoint(x: 160, y: viewY)
        missionStatementTextLabel.center.x = self.view.center.x
        missionStatementTextLabel.textAlignment = .center
        missionStatementTextLabel.textColor = .black
        missionStatementTextLabel.text = "iBlinkco provides tools to maximize businesses and brands online to help them adapt to the modern world."
        missionStatementTextLabel.font = UIFont.boldSystemFont(ofSize: 21.0)
        self.view.addSubview(missionStatementTextLabel)
        
        // About iBlinkco text
        viewY = viewY + 164
        let aboutTextLabel = UILabel(frame: CGRect(x: Int(screenSize.width)/2, y: 50, width: Int(screenSize.width - 10), height: 160))
        aboutTextLabel.lineBreakMode = .byWordWrapping
        aboutTextLabel.numberOfLines = 0
        aboutTextLabel.center = CGPoint(x: 160, y: viewY)
        aboutTextLabel.center.x = self.view.center.x
        aboutTextLabel.textAlignment = .center
        aboutTextLabel.textColor = .black
        aboutTextLabel.text = "We believe that we can help our customers manage things that matter and jumpstart something that matters to them. The iBlinkco dashboard service analyzes your social media account and your website to help you maximize your presence online. We maximize your presence by providing useful tips, graphs, and displaying a users competition. Only 44% of small businesses rely on social media to generate a presence online and we are doing are best to increase that number. "
        aboutTextLabel.font = aboutTextLabel.font.withSize(20)
        self.view.addSubview(aboutTextLabel)
        
        // Background text
        viewY = viewY + 164
        let backgroundStoryTextLabel = UILabel(frame: CGRect(x: Int(screenSize.width)/2, y: 50, width: Int(screenSize.width - 10), height: 160))
        backgroundStoryTextLabel.lineBreakMode = .byWordWrapping
        backgroundStoryTextLabel.numberOfLines = 0
        backgroundStoryTextLabel.center = CGPoint(x: 160, y: viewY)
        backgroundStoryTextLabel.center.x = self.view.center.x
        backgroundStoryTextLabel.textAlignment = .center
        backgroundStoryTextLabel.textColor = .black
        backgroundStoryTextLabel.text = "iBlinkco was founded by Jayden Cummings when he was 15 and in his first summer of The Hidden Genius Project. By the end of that summer I have already presented I rebuilt the website in multiple computer languages but I settled on Python. iBlinkco was originally a social media consulting service until I revised the business plan and decided to create a social media management tool."
        backgroundStoryTextLabel.font = backgroundStoryTextLabel.font.withSize(20)
        self.view.addSubview(backgroundStoryTextLabel)
        
        // Recognizing swipe right gesture
        let aboutSwipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.aboutToHomeSegueFunction))
        aboutSwipeRightGesture.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(aboutSwipeRightGesture)
    }
    @objc func aboutToHomeSegueFunction(fromGesture gesture: UISwipeGestureRecognizer) {
        self.performSegue(withIdentifier: "aboutToHomeSegue", sender: self)
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