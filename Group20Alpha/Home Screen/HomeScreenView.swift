//
//  HomeScreenView.swift
//  Group20Alpha
//
//  Created by Adam Luna on 4/4/18.
//  Copyright © 2018 Group 20. All rights reserved.
//
//based on LoginView

import Foundation
import UIKit
import Firebase

class HomeScreenView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
     */
    var loginAction: (() -> Void)?
    var signupAction: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup() {
        let stackView = createStackView(views: [progressCircle,
                                                addWorkOutButton,
                                                viewCurrentWorkOutsButton])
        addSubview(backgroundImageView)
        addSubview(stackView)
        //adding to stack view since UILabel
        //let ProgressCircle = createStackView(views: [progressCircle])
        //addSubview(ProgressCircle)
        backgroundImageView.setAnchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        stackView.setAnchor(width: self.frame.width - 60, height: 210)
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    let backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "Bitmap")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    
    //*****************************************************************
    //**********************PROBLEM AREA*******************************
    //*****************************************************************
    //progress circle that holds the streak (call from UIlable extension)
    let progressCircle: UILabel = {
        let tf = UILabel(placeHolder: "Streak", borderColor: .blackBorderColor, title: "Test")
        return tf
    }()
    let addWorkOutButton: UIButton = {
        let button = UIButton(title: "Add Workout", borderColor: .greenBorderColor)
        //button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    let viewCurrentWorkOutsButton: UIButton = {
        let button = UIButton(title: "Existing Workouts", borderColor: .redBorderColor)
        //button.addTarget(self, action: #selector(handleSignup), for: .touchUpInside)
        return button
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



