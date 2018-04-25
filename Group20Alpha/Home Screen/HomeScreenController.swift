//
//  HomeScreenController.swift
//  Group20Alpha
//
//  Created by Adam Luna on 4/4/18.
//  Copyright © 2018 Group 20. All rights reserved.
//


import Foundation
import Firebase
import UIKit
//based on LoginController
class HomeScreenController: UIViewController {
    
    var homeView: HomeScreenView!
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
        let mainView = HomeScreenView(frame: self.view.frame)
        self.homeView = mainView
        self.view.addSubview(homeView)
        homeView.setAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
    }
    
}
