
//
//  AuthenticationViewController.swift
//  restApi
//
//  Created by HGPMAC87 on 4/11/19.
//  Copyright © 2019 iBlinkco. All rights reserved.
//
import UIKit

// Model Object for returned Sign In Json
struct parsedData: Decodable  {
    let account: accountData
    let competition: competitionData
    let instagram: instagramData
    let statistics: statisticsData
    let tips: [String]
    let twitter: twitterData
    let user: userData
    let website: websiteData
}
struct accountData: Decodable {
    let email: String!
    let firstname: String!
    let lastname: String!
    let niche: String!
    let setup_complete: Bool!
}
struct competitionData: Decodable {
    let title: [String]
    let link: [String]
}
struct instagramData: Decodable {
    let biography: String!
    let business_category_name: String!
    let edge_felix_video_timeline: Int!
    let edge_follow: Int!
    let edge_followed_by: Int!
    let edge_media_collections: Int!
    let edge_mutual_followed_by: Int!
    let edge_saved_media: Int!
    let external_url: String!
    let external_url_linkshimmed: String!
    let full_name: String!
    let history: historyData
    let id: String!
    let instagramPosts: [instagramPostsData]
    let is_business_account: Bool!
    let is_private: Bool!
    let profile_pic_url: String!
    let profile_pic_url_hd: String!
    let username: String!
}
struct instagramPostsData: Decodable {
    let caption: String!
    let number_of_comments: Int!
    let number_of_likes: Int!
    let pic_url: String!
    let picture_text: String!
    let tips: [String]
}
struct statisticsData: Decodable {
    let averageAmountOfFollowers: Float!
    let instagramRecentAvgComments: Float!
    let instagramRecentAvgDescriptionLen: Float!
    let instagramRecentAvgLikes: Float!
    let maxAmountOfFollowers: Int!
    let minAmountOfFollowers: Int!
    let twitterRecentAvgComments: Float!
    let twitterRecentAvgDescriptionLen: Float!
    let twitterRecentAvgLikes: Float!
}
struct twitterData: Decodable {
    let description: String!
    let followers: Int!
    let following: Int!
    let history: historyData
    let likes: Int!
    let location: String!
    let name: String!
    let tweets: [twitterTweetData]
    let username: String!
}
struct twitterTweetData: Decodable {
    let time: String!
    let tweet: String!
    let tips: [String]
}
struct userData: Decodable {
    let email: String!
    let expiresIn: String!
    let idToken: String!
    let kind: String!
    let localId: String!
    let refreshToken: String!
}
struct websiteData: Decodable {
    let website_name: String!
    let website_url: String!
    let header_text: String!
    let links: [String]
}

struct historyData: Decodable {
    let followers: [historyListData]
    let following: [historyListData]
}
struct historyListData: Decodable {
    let date: String!
    let followers_count: Int!
}

class AuthenticationViewController: UIViewController, UIScrollViewDelegate {
    
    // Elements from UI
    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!
    
    @IBOutlet weak var submitChange: UIButton!
    
    @IBOutlet weak var emailTopConstraint: NSLayoutConstraint!
    // Boolean for signIn view
    var isSignIn:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func submitChangeTapped(_ sender: UIButton) {
        // Flipping the Boolean
        isSignIn = !isSignIn
        
        // Checking the boolean value and changing labels
        if isSignIn{
            print("is sign in")
            showLogin()
        } else {
            print("not sign in")
            showSignUp()
        }
    }
    
    // Showing Sign Up
    func showSignUp() {
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 1, animations: {
            self.emailTopConstraint.constant = 20
            self.view.layoutIfNeeded()
        })
        
        
        // Hidding name textboxes
        firstnameTextField.isHidden = false
        lastnameTextField.isHidden = false
        
        // Changing submit text
        submitButton.setTitle("Sign Up", for: .normal)
        submitChange.setTitle("Already have an Account? Sign In!", for: .normal)
    }
    
    // Showing Login
    func showLogin() {
        UIView.animate(withDuration: 1, animations: {
            self.emailTopConstraint.constant = -70
            self.view.layoutIfNeeded()
        })
        // Hidding name textboxes
        firstnameTextField.isHidden = true
        lastnameTextField.isHidden = true
        
        // Changing submit text
        submitButton.setTitle("Login", for: .normal)
        submitChange.setTitle("Don't have an Account? Sign Up!", for: .normal)
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        let firstname = firstnameTextField.text
        let lastname = lastnameTextField.text
        let email = emailTextField.text
        let password = passwordTextField.text
        
        if isSignIn{
            self.callApi(email: email!, password: password!)
        } else {
            self.createAccount(firstname: firstname!, lastname: lastname!, email: email!, password: password!)
        }
    }
    
    // Calling api
    func callApi(email: String, password: String) {
        print("jajajalllllll")
        // User Sign In
        
        
        // Defining paremeters for json post
        let parameters = [
            "email": email,
            "password": password,
            "software": "ios"
        ]
        
        // Getting url of json postYY
        guard let url = URL(string: "https://www.iblinkco.com/signin") else { return }
        
        // Defining request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
                print("First Print Section\n")
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
//                    print(json)
//                    print("Second Print Section\n")
                    let userDataReturned = try JSONDecoder().decode(parsedData.self, from: data)
//
//                    print(userDataReturned)
                    
                    
                    // Putting data in session
                    UserDefaults.standard.set(true, forKey: "userDataReturned")
                    UserDefaults.standard.synchronize();
                    
//                    print("Third Print Section\n")
//                    //                        let message = userDataReturned.message as! String
//
//                    print("Four Print Section\n")
//
//                    // TEst code
//
//                    print(data)
//                    print("YOooo")
                    
                    
                    
                    
                    
                    //                        if message == "success"{
                    let defaults = UserDefaults.standard
                    
                    // Saving user instagram and twitter data in variable
                    //                            let instagramDataReturned = userDataReturned.returnedInfoInstagram.bio as! String
                    //                            print(instagramDataReturned)
//                    print("Six Print Section\n")
                    
                    // Saving returned user data in variable
                    let firstname = userDataReturned.account.firstname as! String
                    let lastname = userDataReturned.account.lastname as! String
                    let name = firstname + " " + lastname
                    let competitionLink = userDataReturned.competition.link
                    let competitionTitle = userDataReturned.competition.title
                    //                            let twitterFollowersName = userDataReturned.twitter.followersFormated.name
                    //                            let twitterFollowersLocation = userDataReturned.twitter.followersFormated.location
                    //                            let totalNumberOfFollowers = userDataReturned.twitter.userData.followers_count as! Int
                    // Getting total follower count
                    var totalNumberOfFollowers = 0
                    let twitterNumberOfFollowers = userDataReturned.twitter.followers as! Int
                    totalNumberOfFollowers = totalNumberOfFollowers + twitterNumberOfFollowers
                    let instagramNumberOfFollowers = userDataReturned.instagram.edge_followed_by as! Int
                    totalNumberOfFollowers = twitterNumberOfFollowers + instagramNumberOfFollowers
                    
                    let tips = userDataReturned.tips
                    
                    // Twitter Data
                    let twitterBio = userDataReturned.twitter.description
                    let twitterFollowersHistory = userDataReturned.twitter.history.followers
                    let twitterUsername = userDataReturned.twitter.username
                    let twitterFollowerCount = userDataReturned.twitter.followers
                    let twitterFollowingCount = userDataReturned.twitter.following
                    let tweets = userDataReturned.twitter.tweets
                    
                    // Website Data
                    let websiteLinks = userDataReturned.website.links
                    let websiteName = userDataReturned.website.website_name
                    let websiteUrl = userDataReturned.website.website_url
                    
                    // Putting twitter follower history in list
                    var twitterFollowersHistoryDate = [String]()
                    var twitterFollowersHistoryFollowerCount = [Int]()
                    
                    
                    // Instagram
                    let instagramBio = userDataReturned.instagram.biography
                    let instagramUsername = userDataReturned.instagram.username
                    let instagramFollowerCount = userDataReturned.instagram.edge_followed_by
                    let instagramFollowingCount = userDataReturned.instagram.edge_follow
                    let instagramPosts = userDataReturned.instagram.instagramPosts
                    
                    var instagramPostsCaption = [String]()
                    var instagramPostsNumberOfComments = [Int]()
                    var instagramPostsNumberOfLikes =  [Int]()
                    var instagramPostsPicUrl = [String]()
                    var instagramPostsPictureText = [String]()
//                    var instagramPostsTips = [String: Array<String>]()
                    var instagramPostsTips = [[String]]()
                    var counter = 0
                    for post in instagramPosts {
                        instagramPostsCaption.append(post.caption)
                        instagramPostsNumberOfComments.append(post.number_of_comments)
                        instagramPostsNumberOfLikes.append(post.number_of_likes)
                        instagramPostsPicUrl.append(post.pic_url)
                        instagramPostsPictureText.append(post.picture_text)
                        instagramPostsTips.append(post.tips)
                    }
                    var tweetsText = [String]()
                    var tweetsTime = [String]()
                    var tweetsTips = [[String]]()
                    for tweet in tweets {
                        tweetsText.append(tweet.tweet)
                        tweetsTime.append(tweet.time)
                        tweetsTips.append(tweet.tips)
                    }
                    //                            print(twitterFollowersHistory[0].date)
                    //                            print(twitterFollowersHistory[1])
                    //                            print(twitterFollowersHistoryDate)
                    
                    // Putting specific data in session
                    print("\n\n\n\n\n\n\n\nefnwigrbue")
                    
                    // Instagram data
                    defaults.set(instagramFollowerCount, forKey: "instagramFollowerCount")
                    defaults.synchronize()
                    defaults.set(instagramFollowingCount, forKey: "instagramFollowingCount")
                    defaults.synchronize()
                    defaults.set(instagramUsername, forKey:"instagramUsername")
                    defaults.synchronize()
                    defaults.set(instagramBio, forKey:"instagramBio");
                    defaults.synchronize();
                    
                    // Instagram posts
                    defaults.setValue(instagramPostsCaption, forKey:"instagramPostsCaption");
                    defaults.synchronize();
                    defaults.setValue(instagramPostsNumberOfComments, forKey:"instagramPostsNumberOfComments");
                    defaults.synchronize();
                    defaults.setValue(instagramPostsNumberOfLikes, forKey:"instagramPostsNumberOfLikes");
                    defaults.synchronize();
                    defaults.setValue(instagramPostsPicUrl, forKey:"instagramPostsPicUrl");
                    defaults.synchronize();
                    defaults.setValue(instagramPostsPictureText, forKey:"instagramPostsPictureText");
                    defaults.synchronize();
                    print(instagramPostsTips)
                    defaults.setValue(instagramPostsTips, forKey:"instagramPostsTips");
                    defaults.synchronize();
                    
                    
                    
                    // Twitter data
                    defaults.set(twitterUsername, forKey:"twitterUsername")
                    defaults.synchronize()
                    defaults.set(twitterFollowerCount, forKey:"twitterFollowerCount")
                    defaults.synchronize()
                    defaults.set(twitterFollowingCount, forKey: "twitterFollowingCount")
                    defaults.synchronize()
                    defaults.set(twitterBio, forKey:"twitterBio");
                    defaults.synchronize();
                        
                    // Tweets
                    defaults.set(tweetsText, forKey: "tweetsText")
                    defaults.synchronize();
                    defaults.set(tweetsTime, forKey: "tweetsTime")
                    defaults.synchronize();
                    defaults.set(tweetsTips, forKey: "tweetsTips")
                    defaults.synchronize();
                        
                    defaults.set(totalNumberOfFollowers, forKey:"totalNumberOfFollowers")
                    defaults.synchronize()
                    defaults.set(name, forKey:"name");
                    defaults.synchronize();
                    defaults.set(competitionLink, forKey:"competitionLink");
                    defaults.synchronize();
                    defaults.set(competitionTitle, forKey:"competitionTitle");
                    defaults.synchronize();
                    defaults.set(tips, forKey:"tips");
                    defaults.synchronize();
                    defaults.set(websiteLinks, forKey:"websiteLinks");
                    defaults.synchronize();
                    defaults.set(websiteName, forKey:"websiteName");
                    defaults.synchronize();
                    defaults.set(websiteUrl, forKey:"websiteUrl");
                    defaults.synchronize();
                    defaults.set(twitterFollowersHistoryDate, forKey:"twitterFollowersHistoryDate");
                    defaults.synchronize();
                    defaults.set(twitterFollowersHistoryFollowerCount, forKey:"twitterFollowersHistoryFollowerCount");
                    defaults.synchronize();
                    print("aaaa")
                    // Changing View
                    self.performSegue(withIdentifier: "loggedInSegue", sender: self)
                    
                    //                        } else {
                    //                            print("failed")
                    //                        }
                    //
                    
                    
                } catch {
                    print(error)
                }
            }
            //                do{
            //                    let userData = JSONDecoder().decode(userData.self, from: data)
            //                    print(userData)
            //                }
            
            }.resume()
    }
    
    
    // Creating account
    func createAccount(firstname: String, lastname: String, email: String, password: String) {
        // User Registration
        print("jajaja")
        
        // Defining paremeters for json post
        let parameters = [
            "firstname": firstname,
            "lastname": lastname,
            "email": email,
            "password": password,
            "software": "ios"
        ]
        
        // Getting url of json post
        guard let url = URL(string: "https://www.iblinkco.com/create-user") else { return }
        
        // Defining request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        // Creating Session
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            if let data = data {
                do {
                    print(data)
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                    print("aaaa")
                    self.showLogin()
                    // Storing data in session
                    
                } catch {
                    print(error)
                }
            }
            
            }.resume()

    }
}
