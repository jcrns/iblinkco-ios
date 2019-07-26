//
//  competitionAndWebsiteViewController.swift
//  restApi
//
//  Created by HGPMAC87 on 7/25/19.
//  Copyright © 2019 iBlinkco. All rights reserved.
//

import UIKit

class competitionAndWebsiteViewController: UIViewController {
    var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            let competitionTitle = UserDefaults.standard.stringArray(forKey: "competitionTitle") ?? [String]()
            let competitionLink = UserDefaults.standard.stringArray(forKey: "competitionLink") ?? [String]()
            // Creating scroll view
            let screenSize: CGRect = UIScreen.main.bounds
            
            self.scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
            var viewY = 100
            let viewHeight = 128
            // Competition
            for i in 0...competitionTitle.count {
                // Creating view for post
                let competitionView = UIView(frame: CGRect(x: 0, y: viewY, width: Int(screenSize.width), height: viewHeight))
                competitionView.backgroundColor = UIColor.white
                competitionView.center.x = self.view.center.x
                self.scrollView.addSubview(competitionView)
                
                let competitionName = UILabel(frame: CGRect(x: 0, y: 100, width: Int(screenSize.width), height: 236))
                competitionNameLabel.center = CGPoint(x: 160, y: viewY)
                competitionNameLabel.textColor = .black
                competitionNameLabel.lineBreakMode = .byWordWrapping
                competitionNameLabel.numberOfLines = 0
                competitionNameLabel.textAlignment = .center
                competitionNameLabel.text = competitionTitle[i]
                competitionNameLabel.center.x = self.view.center.x
                competitionNameLabel.font = competitionNameLabel.font.withSize(24)
                self.scrollView.addSubview(competitionNameLabel)
                
            }
            
            // Appending all
            let scrollViewHeightCGFloat = CGFloat(viewY + 100)
            self.scrollView.contentSize = CGSize(width: screenSize.width, height: scrollViewHeightCGFloat)
            self.view.addSubview(self.scrollView)
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
