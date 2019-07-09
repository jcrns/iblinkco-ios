//
//  FollowersDataViewController.swift
//  restApi
//
//  Created by HGPMAC87 on 7/3/19.
//  Copyright © 2019 iBlinkco. All rights reserved.
//

import UIKit

class FollowersDataViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let twitterFollowersName = UserDefaults.standard.stringArray(forKey: "twitterFollowersName") ?? [String]()
    let twitterFollowersLocation = UserDefaults.standard.stringArray(forKey: "twitterFollowersLocation") ?? [String]()
//    private let myArray: NSArray = twitterFollowersName
    private var followersDataTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        let skyBlueBackgroundView = UIColor(red: 126/255.0, green: 192/255.0, blue: 238/255.0, alpha: 1.0)
        
        var viewY = 72
        // Title view
        let followersDataTitleView = UIView(frame: CGRect(x: 0, y: 0, width: Int(displayWidth), height: viewY))
        followersDataTitleView.backgroundColor = skyBlueBackgroundView
        followersDataTitleView.center.x = self.view.center.x
        self.view.addSubview(followersDataTitleView)
        
        // Title Label
        let followersDataTitleLabel = UILabel(frame: CGRect(x: 0, y: 20, width: Int(displayWidth), height: 160))
        followersDataTitleLabel.center = CGPoint(x: 160, y: viewY-30)
        followersDataTitleLabel.textColor = .white
        followersDataTitleLabel.textAlignment = .center
        followersDataTitleLabel.text = "Followers Data"
        followersDataTitleLabel.center.x = self.view.center.x
        followersDataTitleLabel.font = followersDataTitleLabel.font.withSize(20)
        self.view.addSubview(followersDataTitleLabel)
        
        
        // Table view
        followersDataTableView = UITableView(frame: CGRect(x: 0, y: 72, width: displayWidth, height: displayHeight - barHeight))
        followersDataTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        followersDataTableView.dataSource = self
        followersDataTableView.delegate = self
        self.view.addSubview(followersDataTableView)
        
        // Recognizing swipe right gesture
        let followersDataSwipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(self.FollowersDataToHomeFunction))
        followersDataSwipeRightGesture.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(followersDataSwipeRightGesture)
    }
    // Swipe right function
    @objc func FollowersDataToHomeFunction(fromGesture gesture: UISwipeGestureRecognizer) {
        self.performSegue(withIdentifier: "followersDataToHomeSegue", sender: self)
    }
    // Table view functions
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        print("Value: \(twitterFollowersName[indexPath.row])")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return twitterFollowersName.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        cell.textLabel!.text = "\(twitterFollowersName[indexPath.row])"
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
