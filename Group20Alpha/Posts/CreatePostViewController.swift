//
//  CreatePostViewController.swift
//  Group20Alpha
//
//  Created by Brandon Head on 4/25/18.
//  Copyright © 2018 Group 20. All rights reserved.
//

import UIKit
import Firebase
import Foundation

class CreatePostViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var ref: DatabaseReference!
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descriptField: UITextView!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var catPicker: UIPickerView!
    
    var selectedCategory: String = "Clothing"
    
    var categories: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        //Do stuff for the PickerView (that's a god-awful name, just by the by)
        self.catPicker.delegate = self
        self.catPicker.dataSource = self
        
        //Populate the picker stuff
        categories = ["Clothing",
                      "Home",
                      "Electronics",
                      "School",
                      "Services"]   //Ripped straight from MainCategoriesController

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Pickerview Stuff!
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }
    
    //Grabs the selected value (I think?)
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent  component: Int) {
        selectedCategory = categories[row] as String
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
        //Create a new Post object using the data given here
        let postTitle: String = titleField.text!    //Assumes that there will NEVER be a nil value in any of these fields, which is pretty dumb. Fix later!
        let postDescription: String = descriptField.text!
        let postPrice: String = priceField.text!    //This is making a pretty big assumption that there'll only be numbers in that field... Should probably add some failsafes later
        let postCategory: String = selectedCategory
        
        //Put all of this stuff into a Firebase friendly thing
        let postData: [String: Any] = [
            "title": postTitle,
            "description": postDescription,
            "price": postPrice,
            "category": postCategory,
            "userID": Auth.auth().currentUser?.uid
        ]
        //Push to the database
        //let autoID = String((Date().timeIntervalSince1970 * 1000.0).rounded())
        let autoIdInt = Int((Date().timeIntervalSince1970 * 1000).rounded())
        let autoID = String(autoIdInt)
        //Debug
        print(autoID)
        self.ref.child(postCategory).child(autoID).setValue(postData)
        
        ref?.child("users").child((Auth.auth().currentUser?.uid)!)
                    .observeSingleEvent(of: .value, with: { (snapshot) in
        
                        let userDict = snapshot.value as! [String: Any]
        
                        var totalPosts = userDict["numPosts"] as! Int
//                        var displayName = userDict["name"] as! String
//                        var postList = userDict["posts"] as! [String]
                        totalPosts += 1
                        
                        self.ref.child("users").child((Auth.auth().currentUser?.uid)!).setValue(["numPosts": totalPosts])
                        
                        self.ref.child("users").child((Auth.auth().currentUser?.uid)!).child("posts").setValue([String(totalPosts): autoID])
        
                    })
        //self.ref.child((Auth.auth().currentUser?.uid)!).child("posts").setValue([String])
        //self.ref.child((Auth.auth().currentUser?.uid)!).setValue(["Post": autoID])  //Why is this making a whole new thing?
//        ref?.child("users").child((Auth.auth().currentUser?.uid)!)
//            .observeSingleEvent(of: .value, with: { (snapshot) in
//
//                let userDict = snapshot.value as! [String: Any]
//
//                var postList = userDict["posts"] as! [String]
//                postList.append(autoID)
//
//            })
//
        
        
        //And head back to the last visited page (should be the beautiful landing page right now)
        self.dismiss(animated: true, completion: nil)   //Does having a navigation controller completely negate this? That's unfortunate :(
    }
    
}
