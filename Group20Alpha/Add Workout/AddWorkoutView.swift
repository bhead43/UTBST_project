//
//  AddWorkoutView.swift
//  Group20Alpha
//
//  Created by Brandon Head on 4/4/18.
//  Copyright © 2018 Group 20. All rights reserved.
//

//Everything is probably ugly right now.
import UIKit

class AddWorkoutView: UIView {

    //Variables
    var add45Action: (() -> Void)?
    var add25Action: (() -> Void)?
    var add10Action: (() -> Void)?
    var add5Action: (() -> Void)?
    var addBarAction: (() -> Void)?
    var saveWorkoutAction: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    //Just here to not throw errors?
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        //Create a bunch of small stackViews
        let titleStackView = createStackView(views: [nameExercise,
                                                     numWeight])
        let buttonsStackView = createHorizontalStackView(views: [add45Button,
                                                                 add25Button,
                                                                 add10Button,
                                                                 add5Button,
                                                                 addBarButton])
        let setsStackView = createHorizontalStackView(views: [numSets,
                                                              numReps])
        let saveStackView = createStackView(views: [saveButton])
        
        //Create a main stackView and put the other stack views in it
        let mainStackView = createStackView(views: [titleStackView,
                                                    buttonsStackView,
                                                    setsStackView,
                                                    saveStackView])
        
        mainStackView.spacing = 20
        
        //Add the main stackView as a subview of the overall UIView. Making more than one subView might break some things
        addSubview(mainStackView)
        
        mainStackView.setAnchor(width: self.frame.width - 60, height: 400)
        mainStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        mainStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        
    }
    
    //UI Elements
    let nameExercise: UITextField = {
        let tf = UITextField(placeHolder: "Name of exercise")
        //f.center = CGPoint(x: 540, y: 100)
        return tf
    }()
    
    let numWeight: UITextField = {
        let tf = UITextField(placeHolder: "Weight (numerical values only)")
        return tf
    }()
    
    let nametextField: UITextField = {
        let tf = UITextField(placeHolder: "Name")
        return tf
    }()
    
    //For all of these...
    //  Figure out how these handlers work and implement them!
    let add45Button: UIButton = {
        let button = UIButton(title: "45", borderColor: .greenBorderColor)
        button.addTarget(self, action: #selector(handleAdd45), for: .touchUpInside)
        return button
    }()
    
    let add25Button: UIButton = {
        let button = UIButton(title: "25", borderColor: .greenBorderColor)
        button.addTarget(self, action: #selector(handleAdd25), for: .touchUpInside)
        return button
    }()
    
    let add10Button: UIButton = {
        let button = UIButton(title: "10", borderColor: .greenBorderColor)
        button.addTarget(self, action: #selector(handleAdd10), for: .touchUpInside)
        return button
    }()
    
    let add5Button: UIButton = {
        let button = UIButton(title: "5", borderColor: .greenBorderColor)
        button.addTarget(self, action: #selector(handleAdd5), for: .touchUpInside)
        return button
    }()
    
    let addBarButton: UIButton = {
        let button = UIButton(title: "45", borderColor: .greenBorderColor)
        button.addTarget(self, action: #selector(handleAddBar), for: .touchUpInside)
        return button
    }()
    
    let numSets: UITextField = {
        let tf = UITextField(placeHolder: "Sets")
        return tf
    }()
    
    let numReps: UITextField = {
        let tf = UITextField(placeHolder: "Reps")
        return tf
    }()
    
    let saveButton: UIButton = {
        let button = UIButton(title: "Save Workout", borderColor: .greenBorderColor)
        button.addTarget(self, action: #selector(handleSaveWorkout), for: .touchUpInside)
        return button
    }()
    
    //Handlers for buttons
    @objc func handleAdd45() {
        add45Action?()
    }
    
    @objc func handleAdd25() {
        add25Action?()
    }
    
    @objc func handleAdd10() {
        add10Action?()
    }
    
    @objc func handleAdd5() {
        add5Action?()
    }
    
    @objc func handleAddBar() {
        addBarAction?()
    }
    
    @objc func handleSaveWorkout() {
        saveWorkoutAction?()
    }
    
}
