//
//  SignupViewController.swift
//  Group20Alpha
//
//  Created by Brandon Head on 4/24/18.
//  Copyright © 2018 Group 20. All rights reserved.
//

import UIKit
import Foundation   //Not sure what Foundation does? The other files have it so better safe than sorry
import Firebase

class SignupViewController: UIViewController {

    //Don't know what these do but they're probably important
    var defaults = UserDefaults.standard
    var ref: DatabaseReference! //Oh, this is what talks to the Firebase database. Good to know, I guess.
    
    //Outlets for all the UI stuff
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func createButtonPressed(_ sender: Any) {
        guard let email = emailField.text else { return }
        guard let password = passwordField.text else { return }
        guard let name = nameField.text else { return }
        
        //stuff for user's posts
        let posts: [String] = ["Don't look at me!"]
        
        let userData: [String: Any] = [
            "name": name,
            "posts": posts,
            "numPosts": 0
        ]
        
        // Creates a new user in the Firebase database
        // Check if passwords match and utexas email used
        if passwordField.text == confirmField.text && (emailField.text?.hasSuffix("utexas.edu"))! {
            Auth.auth().createUserAndRetrieveData(withEmail: email, password: password) { (result, err) in
                if let err = err {
                    print(err.localizedDescription)
                } else {
                    print ("Made it to Firebase - kinda")
                    guard let uid = result?.user.uid else { return }
                    self.ref.child("users/\(uid)").setValue(userData)
                    self.defaults.set(false, forKey: "UserIsLoggedIn")
                    print("Successfully created a user:", uid)
                    //self.dismiss(animated: true, completion: nil)   //Pops this view from the stack or something? Completely defunct now that we have a nav controller
                    
                    //allert to tell user they've been created
                    let alertController = UIAlertController(title: "Congratulations", message: "You are now registered for UTBST!", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                    
                }
            }
        }
        else{
            print("Make sure that your passwords match, and that you're using a utexas.edu email address!") //To make sure nobody else gets confused like I was :)
            let alertController = UIAlertController(title: "Warning", message: "Make sure that your passwords match, and that you're using a utexas.edu email address!", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        emailField.text = ""
        passwordField.text = ""
        nameField.text = ""
        confirmField.text = ""
       
        
    }
        

            
    @IBAction func cancelButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)    //Could probably just nix this entire thing and make the cancel button redirect to the login view from the storyboard
    }
    
}

