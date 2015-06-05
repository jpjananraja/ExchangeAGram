//
//  ProfileViewController.swift
//  ExchangeAGram
//
//  Created by Janan Rajaratnam on 6/1/15.
//  Copyright (c) 2015 Janan Rajaratnam. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, FBLoginViewDelegate
{

    
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    
    
    @IBOutlet weak var fbLoginView: FBLoginView!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.fbLoginView.delegate = self
        
        self.fbLoginView.readPermissions = ["public_profile" , "publish_actions"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: - IBAction Methods
    
    
    @IBAction func mapViewButtonTapped(sender: UIButton)
    {
        self.performSegueWithIdentifier("mapSegue", sender: nil)
    }
    
    
    
    //MARK: - FBLoginViewDelegate methods
    
    func loginViewShowingLoggedInUser(loginView: FBLoginView!)
    {
        self.profileImageView.hidden = false
        self.nameLabel.hidden = false
        
        
    }
    
    
    func loginViewFetchedUserInfo(loginView: FBLoginView!, user: FBGraphUser!)
    {
        println(user)
        
        self.nameLabel.text = user.name
        
        
        //Steps to obtain the user's profile pic
        let userImageURL = "https://graph.facebook.com/\(user.objectID)/picture?type=small"
        
        let url = NSURL(string: userImageURL)
        
        var imageData = NSData(contentsOfURL: url!)
        
        let image = UIImage(data: imageData!)
        
        self.profileImageView.image = image
        
        
        
        
        
    }
    
    func loginViewShowingLoggedOutUser(loginView: FBLoginView!)
    {
        self.profileImageView.hidden = true
        self.nameLabel.hidden = true
        
        
    }
    
    
    func loginView(loginView: FBLoginView!, handleError error: NSError!)
    {
        println("Error: \(error.localizedDescription)")
        
        
    }
    

}
