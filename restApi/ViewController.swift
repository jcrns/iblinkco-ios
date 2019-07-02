
//
//  ViewController.swift
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
    let tips: [String]
    let twitter: twitterData
    let message: String!
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
struct twitterData: Decodable {
    let followersFormated: followersFormatedData
    let history: twitterHistoryData
    let userData: userDataStruct
}
struct followersFormatedData: Decodable {
    let name: [String]
    let location: [String]
}
struct twitterHistoryData: Decodable {
    let followers: [twitterFollowersHistoryData]
//    let following: [twitterFollowingHistoryData]
}
struct twitterFollowersHistoryData: Decodable {
    let date: String!
    let followers_count: Int!
}
//struct twitterFollowingHistoryData: Decodable {
//    let date: String!
//    let following_count: Int!
//}
struct userDataStruct: Decodable {
    let contributors_enabled: Bool!
    let created_at: String!
    let default_profile: Bool!
    let default_profile_image: Bool!
    let description: String!
    let favorite_count: Int!
    let follow_request_sent: Bool!
    let followers_count: Int!
    let following: Bool!
    let friends_count: Int!
    let geo_enabled: Bool!
    let has_extended_profile: Bool!
    let id: Int!
    let id_str: String!
    let is_translation_enabled: Bool!
    let is_translator: Bool!
    let listed_count: Int!
    let location: String!
    let name: String!
    let needs_phone_verification: Bool!
    let notifications: Bool!
    let profile_background_color: String!
    let profile_background_title: Bool!
    let profile_image_url: String!
    let profile_image_url_https: String!
    let profile_link_color: String!
    let profile_sidebar_border_color: String!
    let profile_sidebar_fill_color: String!
    let profile_text_color: String!
    let profile_use_background_image: Bool!
    let protected: Bool!
    let screen_name: String!
    let status: statusData
    let statuses_count: Int!
    let suspended: Bool!
    let translator_type: String!
    let url: String!
    let verified: Bool!
}
struct statusData: Decodable {
    let created_at: String!
    let favorite_count: Int!
    let favorited: Bool!
    let id: Int!
    let id_str: String!
    let is_quote_status: Bool!
    let lang: String!
    let retweet_count: Int!
    let retweeted: Bool!
    let source: String!
    let text: String!
    let truncated: Bool!
}
//class User{
//    var email: String
//    var password: String
//    var message: String
//    func init(parameters) -> <#return type#> {
//        <#function body#>
//    }
//}
//class UserInstagram{
//    var bio: String
//    var instagram_username: String
//    var number_of_followers: String
//    var number_of_following: String
//    var number_of_post: String
//    var on_desktop: String
//    var on_mobile: String
//    var on_web: String
//}
//class UserTwitter{
//
//}
class ViewController: UIViewController {
    
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
                        print(json)
                        print("Second Print Section\n")
                        let userDataReturned = try JSONDecoder().decode(parsedData.self, from: data)
                        
                        print(userDataReturned)
                        
                        
                        // Putting data in session
                        UserDefaults.standard.set(true, forKey: "userDataReturned")
                        UserDefaults.standard.synchronize();
                        
                        print("Third Print Section\n")
                        let message = userDataReturned.message as! String
                        
                        print("Four Print Section\n")
                        
                        // TEst code
                        
                        print(data)
                        print("YOooo")
                        
                        
                        
                        
                        
                        if message == "success"{
                            let defaults = UserDefaults.standard
                            
                            // Saving user instagram and twitter data in variable
                            //                            let instagramDataReturned = userDataReturned.returnedInfoInstagram.bio as! String
                            //                            print(instagramDataReturned)
                            print("Six Print Section\n")
                            
                            // Saving returned user data in variable
                            let firstname = userDataReturned.account.firstname as! String
                            let lastname = userDataReturned.account.lastname as! String
                            let name = firstname + " " + lastname
                            let competitionLink = userDataReturned.competition.link
                            let competitionTitle = userDataReturned.competition.title
                            let totalNumberOfFollowers = userDataReturned.twitter.userData.followers_count as! Int
                            let tips = userDataReturned.tips
                            let bio = userDataReturned.twitter.userData.description
                            
                            // Putting specific data in session
                            defaults.set(bio, forKey:"twitterBio");
                            defaults.synchronize();
                            defaults.set(name, forKey:"name");
                            defaults.synchronize();
                            defaults.set(competitionLink, forKey:"competitionLink");
                            defaults.synchronize();
                            defaults.set(competitionTitle, forKey:"competitionTitle");
                            defaults.synchronize();
                            defaults.set(totalNumberOfFollowers, forKey:"totalNumberOfFollowers");
                            defaults.synchronize();
                            defaults.set(tips, forKey:"tips");
                            defaults.synchronize();
                            print("aaaa")
                            // Changing View
                            self.performSegue(withIdentifier: "loggedInSegue", sender: self)
                            
                        } else {
                            print("failed")
                        }
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
        } else {
            // User Registration
            print("jajaja")
            
            // Defining paremeters for json post
            let parameters = [
                "firstname": firstname,
                "lastname": lastname,
                "email": email,
                "password": password,
                ]
            
            // Getting url of json post
            guard let url = URL(string: "http://www.iblinkco.com/create-user") else { return }
            
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
}
