//
//  CategoriesController.swift
//  Group20Alpha
//
//  Created by Brandon Head on 4/21/18.
//  Copyright © 2018 Group 20. All rights reserved.
//

import UIKit
import Firebase
import Foundation 
//UIViewController, UITableViewDelegate, UITableViewDataSource,
//
class CategoriesController: BaseViewController, UITableViewDataSource {

    
    var tableView: UITableView = UITableView()
    let categories: [String] = ["Womens Clothing",
                                "Mens Clothing",
                                "Home Accessories",
                                "Home Appliances",
                                "Personal Electronics",
                                "Tickets",
                                "Textbooks",
                                "Course Content",
                                "Services"]
    
    let defaults = UserDefaults.standard
    var ref: DatabaseReference!
    
    var appUser: AppUser? {
        didSet {
            print ("value set")
            guard let userName = appUser?.name else { return }
            print (userName)
            self.navigationItem.title = userName
        }
    }

    

    override func viewDidLoad(){
        super.viewDidLoad()
        //fetchUserInfo()
        
        ref = Database.database().reference()
        //Set up the tableview
        tableView = UITableView(frame: UIScreen.main.bounds, style: UITableViewStyle.plain) //Will this fix itself once we conform to DataSource protocol?
        tableView.delegate = self as? UITableViewDelegate
        tableView.dataSource = self as? UITableViewDataSource
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "LogOut", style: .plain, target: self, action: #selector(logOut))
        self.view.addSubview(self.tableView)
        addSlideMenuButton()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func logOut() {
        print("logged out")
        do {
            try Auth.auth().signOut()
            defaults.set(false, forKey: "UserIsLoggedIn")
            
            //let loginController = UINavigationController(rootViewController: LoginController())
            //present(loginController, animated: true, completion: nil)
        } catch let err {
            print(err.localizedDescription)
        }
    }
    
    func fetchUserInfo() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        ref.child("users").child(userId).observeSingleEvent(of: .value) { (snapshot) in
            guard let data = snapshot.value as? NSDictionary else { return }
            guard let username = data["name"] as? String else { return }
            self.appUser = AppUser(name: username, uid: userId)
        }
    }
    
//    //Get the number of elements that should be in the table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.categories.count
    }
    
    //Set each cell with the appropriate title taken from categories list
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:UITableViewCell=UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "cell")
        cell.textLabel!.text = categories[indexPath.row]
        return cell;
    }
    
    //Handles selection of cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        print(categories[indexPath.row])    //This is just a placeholder right now. This will be where we transition to the next view
    }
    
    //sets height of table view cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    
}
