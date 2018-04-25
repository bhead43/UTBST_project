//
//  AddWorkoutController.swift
//  Group20Alpha
//
//  Created by Brandon Head on 4/4/18.
//  Copyright © 2018 Group 20. All rights reserved.
//

import Foundation
import UIKit

class AddWorkoutController: UIViewController {
    
    //Variables
    var addWorkoutView: AddWorkoutView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkGray
        setupView()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupView() {
        let mainView = AddWorkoutView(frame: self.view.frame)
        self.addWorkoutView = mainView
        addWorkoutView.add45Action = add45ButtonPressed
        addWorkoutView.add25Action = add25ButtonPressed
        addWorkoutView.add10Action = add10ButtonPressed
        addWorkoutView.add5Action = add5ButtonPressed
        addWorkoutView.addBarAction = addBarButtonPressed
        addWorkoutView.saveWorkoutAction = saveWorkoutButtonPressed
        self.view.addSubview(addWorkoutView)
        addWorkoutView.setAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
    }
    
    //Actual stuff that the buttons do
    func add45ButtonPressed(){
        //Get text from Enter Weight text field and convert it to an int
        var weightString: String! = addWorkoutView.numWeight.text
        var weightInt: Int = 0
        
        //If text is null...
        if !(addWorkoutView.numWeight.text?.isEmpty)!{
           weightInt = Int(weightString)!
        }
        
        //Add 45 to the int, convert int back to string
        weightInt += 45
        weightString = String(weightInt)
        
        //Set the new text of the Enter Weight text field to the number with 45 added
        addWorkoutView.numWeight.text = weightString
    }
    
    func add25ButtonPressed(){
        //Get text from Enter Weight text field and convert it to an int
        var weightString: String! = addWorkoutView.numWeight.text
        var weightInt: Int = 0
        
        //If text is null...
        if !(addWorkoutView.numWeight.text?.isEmpty)!{
            weightInt = Int(weightString)!
        }
        //Add 25 to the int, convert int back to string
        weightInt += 25
        weightString = String(weightInt)
        
        //Set the new text of the Enter Weight text field to the number with 25 added
        addWorkoutView.numWeight.text = weightString
    }
    
    func add10ButtonPressed(){
        //Get text from Enter Weight text field and convert it to an int
        var weightString: String! = addWorkoutView.numWeight.text
        var weightInt: Int = 0
        
        //If text is null...
        if !(addWorkoutView.numWeight.text?.isEmpty)!{
            weightInt = Int(weightString)!
        }
        
        //Add 10 to the int, convert int back to string
        weightInt += 10
        weightString = String(weightInt)
        
        //Set the new text of the Enter Weight text field to the number with 10 added
        addWorkoutView.numWeight.text = weightString
    }
    
    func add5ButtonPressed(){
        //Get text from Enter Weight text field and convert it to an int
        var weightString: String! = addWorkoutView.numWeight.text
        var weightInt: Int = 0
        
        //If text is null...
        if !(addWorkoutView.numWeight.text?.isEmpty)!{
            weightInt = Int(weightString)!
        }
        
        //Add 5 to the int, convert int back to string
        weightInt += 5
        weightString = String(weightInt)
        
        //Set the new text of the Enter Weight text field to the number with 5 added
        addWorkoutView.numWeight.text = weightString
    }
    
    func addBarButtonPressed(){
        //Get text from Enter Weight text field and convert it to an int
        var weightString: String! = addWorkoutView.numWeight.text
        var weightInt: Int = 0
        
        //If text is null...
        if !(addWorkoutView.numWeight.text?.isEmpty)!{
            weightInt = Int(weightString)!
        }
        
        //Add 45 to the int, convert int back to string
        weightInt += 45
        weightString = String(weightInt)
        
        //Set the new text of the Enter Weight text field to the number with 45 added
        addWorkoutView.numWeight.text = weightString
    }
    
    //TODO - Make this button actually do something (save to some sort of user-specific database?)
    func saveWorkoutButtonPressed(){
        //Filler for now
        print("Button pressed!")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
