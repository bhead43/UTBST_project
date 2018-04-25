//
//  LoginController.swift
//  Group20Alpha
//
//  Created by Adam Luna on 4/3/18.
//  Copyright © 2018 Group 20. All rights reserved.
//

import Foundation
import Firebase
import UIKit

class LoginController: UIViewController {
    
    var loginView: LoginView!
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    func setupView() {
        let mainView = LoginView(frame: self.view.frame)
        self.loginView = mainView
        self.loginView.loginAction = loginPressed
        self.loginView.signupAction = signupPressed
        self.view.addSubview(loginView)
        loginView.setAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
    }
    
    func loginPressed() {
        guard let email = loginView.emailTextField.text else { return }
        guard let password = loginView.passwordTextField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let err = error {
                print(err.localizedDescription)
            } else {
                print("User: \(user?.uid) signed in")
                self.defaults.set(true, forKey: "UserIsLoggedIn")
                // show main controller
                
                //commenting out this line and adding a new one for testing only
                //let mainController = UINavigationController(rootViewController: MainController())
                //self.present(mainController, animated: true, completion: nil)
                
                //Just for testing, use the above lines for actual use
                //let addWorkoutController = AddWorkoutController()
                //self.present(addWorkoutController, animated: true, completion: nil)
                
//                let homeScreenController = HomeScreenController()
//                self.present(homeScreenController, animated: true, completion: nil)
                
                //present the categories page after succesful authorization
                let categoriesController = CategoriesController()
                print ("presenting CategoriesController")
                self.present(categoriesController, animated: true, completion: nil)
            }
        }
    }
    
    func signupPressed() {
        // 1
        let signUpVC = SignUpController()
        present(signUpVC, animated: true, completion: nil)
    }
    
}
