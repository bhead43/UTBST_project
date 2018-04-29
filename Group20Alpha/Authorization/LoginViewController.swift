//
//  LoginViewController.swift
//  Group20Alpha
//
//  Created by Brandon Head on 4/24/18.
//  Copyright © 2018 Group 20. All rights reserved.
//

import UIKit
import Foundation
import Firebase

class LoginViewController: UIViewController {

    let defaults = UserDefaults.standard    //We probably need this?
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    @IBAction func loginButtonPressed(_ sender: Any) {
        guard let email = emailField.text else { return }
        guard let password = passwordField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let err = error {
                print(err.localizedDescription)
            } else {
                print("User: \(user!.uid) signed in")   //can fix this error with ! bc we know the user is valid at this point
                self.defaults.set(true, forKey: "UserIsLoggedIn")
                // show main controller
                
                //Go on to next view (probably main categories screen)
                //But for now, just test with this print thing:
                print("Logged in succesfully! This stuff works so far!")  //Just realized that the above thing does this already, so this is pretty useless
                //Can this do the present stuff still, now that there are storyboards in play? Can you just present the controller attached to the storyboard view you want?
                
                self.performSegue(withIdentifier: "loginSegue", sender: sender)
            }
        }
    }
    
    
}
