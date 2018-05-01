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

class CreatePostViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    var ref: DatabaseReference!
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descriptField: UITextView!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var catPicker: UIPickerView!
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    
    var selectedCategory: String = "Clothing"
    
    var categories: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectButton.isHidden = false
        
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
    
    //Stuff for keyboards
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 'First Responder' is the same as 'input focus'.
        // We are removing input focus from the text field.
        textField.resignFirstResponder()
        return true
    }
    
    //STILL NOT MY CODE
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // This causes the keyboard to be dismissed.
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func selectPicturePressed(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        image.allowsEditing = false
        
        self.present(image, animated: true)
        
    }
    
    // I hate Xcode
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
        } else {
            // error message
        }
        selectButton.isHidden = true
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
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
    
//    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: AnyObject]) {
//        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
//            imageView.contentMode = .scaleAspectFit
//            imageView.image = pickedImage
//        }
//
//        dismiss(animated: true, completion: nil)
//    }
//

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
        
        let autoIdInt = Int((Date().timeIntervalSince1970 * 1000).rounded())
        let autoID = String(autoIdInt)
        //Debug
        print(autoID)
        
        let comments: [String] = ["Placeholder"]
        
        //Put all of this stuff into a Firebase friendly thing
        let postData: [String: Any] = [
            "title": postTitle,
            "description": postDescription,
            "price": postPrice,
            "category": postCategory,
            "userID": Auth.auth().currentUser?.uid,
            "postID": autoID,    //Probably wouldn't hurt to save this as a part of the post as well. Will almost certainly make life better in the future.
            "comments": comments
            
        ]
        //Push to the database
        //let autoID = String((Date().timeIntervalSince1970 * 1000.0).rounded())
        self.ref.child(postCategory).child(autoID).setValue(postData)
        
        //This all works now! DON'T TOUCH THIS FOR THE LOVE OF ALL THAT IS HOLY
        ref?.child("users").child((Auth.auth().currentUser?.uid)!)
                    .observeSingleEvent(of: .value, with: { (snapshot) in
        
                        let userDict = snapshot.value as! [String: Any]
                        print ("this is old user dict asgiment")
                        print (userDict)
        
                        var totalPosts = userDict["numPosts"] as! Int
                        var displayName = userDict["name"] as! String
                        var postList = userDict["posts"] as! [String]
                        totalPosts += 1
                        postList.append(autoID)
                        print ("this is new user dict asgiment")
                        print (userDict)
                        
                        let userData: [String: Any] = [
                            "name": displayName,
                            "posts": postList,
                            "numPosts": totalPosts
                        ]   //This creates a data set with everything the user needs.
                        
                        self.ref.child("users").child((Auth.auth().currentUser?.uid)!).setValue(userData)   //Updates the user with ALL of its info, even the sutff that didn't get touched (display name, previous posts)
                        
                        
                            let alertController = UIAlertController(title: "Comment Recorded", message: "Your comment has been recorded!", preferredStyle: .alert)
                            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                            alertController.addAction(defaultAction)
                        
                            self.present(alertController, animated: true, completion: nil)
                        
                        self.titleField.text = ""
                        self.descriptField.text = ""
                        self.priceField.text = ""
        
                    })
        
        
        //And head back to the last visited page (should be the beautiful landing page right now)
        //self.dismiss(animated: true, completion: nil)   //Does having a navigation controller completely negate this? That's unfortunate :(
        //We should probably implement a segue or something and trigger it here in place of the dismiss. It makes for nice feedback that you actually did something.
    }
    
}
