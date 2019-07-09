//
//  CompetitionViewController.swift
//  restApi
//
//  Created by HGPMAC87 on 7/3/19.
//  Copyright © 2019 iBlinkco. All rights reserved.
//

import UIKit

class CompetitionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let competitionTitle = UserDefaults.standard.stringArray(forKey: "competitionTitle") ?? [String]()
    let competitionLink = UserDefaults.standard.stringArray(forKey: "competitionLink") ?? [String]()
    private var competitionTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        let skyBlueBackgroundView = UIColor(red: 126/255.0, green: 192/255.0, blue: 238/255.0, alpha: 1.0)
        
        let viewY = 72
        // Title view
        let competitionTitleView = UIView(frame: CGRect(x: 0, y: 0, width: Int(displayWidth), height: viewY))
        competitionTitleView.backgroundColor = skyBlueBackgroundView
        competitionTitleView.center.x = self.view.center.x
        self.view.addSubview(competitionTitleView)
        
        // Title Label
        let competitionTitleLabel = UILabel(frame: CGRect(x: 0, y: 20, width: Int(displayWidth), height: 160))
        competitionTitleLabel.center = CGPoint(x: 160, y: viewY-30)
        competitionTitleLabel.textColor = .white
        competitionTitleLabel.textAlignment = .center
        competitionTitleLabel.text = "Competition"
        competitionTitleLabel.center.x = self.view.center.x
        competitionTitleLabel.font = competitionTitleLabel.font.withSize(20)
        self.view.addSubview(competitionTitleLabel)
        
        
        // Table view
        competitionTableView = UITableView(frame: CGRect(x: 0, y: 72, width: displayWidth, height: displayHeight - barHeight))
        competitionTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        competitionTableView.dataSource = self
        competitionTableView.delegate = self
        self.view.addSubview(competitionTableView)
        
        // Recognizing swipe right gesture
        let competitionSwipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.competitionToHomeFunction))
        competitionSwipeRightGesture.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(competitionSwipeRightGesture)
    }
    // Swipe right function
    @objc func competitionToHomeFunction(fromGesture gesture: UISwipeGestureRecognizer) {
        self.performSegue(withIdentifier: "competitionToHomeSegue", sender: self)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        print("Value: \(competitionTitle[indexPath.row])")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return competitionTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        cell.textLabel!.text = "\(competitionTitle[indexPath.row])"
        return cell
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
