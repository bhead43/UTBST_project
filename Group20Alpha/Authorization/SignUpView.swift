//
//  SignUpView.swift
//  Group20Alpha
//
//  Created by Adam Luna on 4/3/18.
//  Copyright © 2018 Group 20. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class SignUpView: UIView {
    
    //These are just placeholder actions for buttons; the code connected to these is in the controller
    var submitAction: (() -> Void)?
    var cancelAction: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    //This guy is just here to not throw errors... I think
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        let mainStackView = createStackView(views: [nametextField,
                                                    emailTextField,
                                                    passwordTextField,
                                                    confirmPasswordTextField,
                                                    submitButton,
                                                    cancelButton])
        addSubview(backgroundImageView)
        addSubview(mainStackView)
        
        backgroundImageView.setAnchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
        mainStackView.setAnchor(width: self.frame.width - 60, height: 310)
        mainStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        mainStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    //All of these 'let' things are setting up the UI elements described in the stackView up top
    let backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "Bitmap")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let nametextField: UITextField = {
        let tf = UITextField(placeHolder: "Name")
        return tf
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField(placeHolder: "Email")
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField(placeHolder: "Password")
        return tf
    }()
    
    let confirmPasswordTextField: UITextField = {
        let tf = UITextField(placeHolder: "Confirm Password")
        return tf
    }()
    
    let submitButton: UIButton = {
        let button = UIButton(title: "Submit", borderColor: .greenBorderColor)
        button.addTarget(self, action: #selector(handleSubmit), for: .touchUpInside)
        return button
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton(title: "Cancel", borderColor: .redBorderColor)
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        return button
    }()
    
    //These are handlers for the buttons. Don't know why we need them, but they're here
    @objc func handleSubmit() {
        submitAction?()
    }
    
    @objc func handleCancel() {
        cancelAction?()
    }
    
    
}
