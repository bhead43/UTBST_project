//
//  ManagePostsTableViewController.swift
//  Group20Alpha
//
//  Created by Brandon Head on 4/28/18.
//  Copyright © 2018 Group 20. All rights reserved.
//

//Fun fact: The "observeSingleEvent" type things (snapshot nonsense) runs after EVERYTHING else in its respective block, even if there's code that comes after it. Only took a few hours of frustration to figure that one out.

import UIKit
import Foundation
import Firebase

class ManagePostsTableViewController: UITableViewController {

    var ref: DatabaseReference!
    var categories: [String] = ["Clothing", "Electronics", "Home", "School", "Services"]
    var idList: [String] = []   //Empty for now, will be filled in the snapshot event below
    var postList: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        let currentUser: String = (Auth.auth().currentUser?.uid)!   //This is safe because you'll always be an existing user at this point? I hope so, anyways
        
        //Grab the array of posts from the current user
        ref?.child("users").child(currentUser).observeSingleEvent(of: .value, with: { (snapshot) in
            let userDict = snapshot.value as? [String: Any]
            
            self.idList = userDict?["posts"] as! [String]
            
            //Test to make sure things work
            for id in self.idList{
                print(id)
            }
            
            //Now we nest the other observe event? Crazy shit.
            
            //Now we loop through the snapshot thing done in SubCategoryTableViewController a bunch
            //clearing the list
            self.postList.removeAll()
            
            for cat in self.categories{
                //Set the database to look in the current category accorsing to the loop
                self.ref = Database.database().reference().child(cat)
                
                self.ref.observe(DataEventType.value, with: { (snapshot) in
                    
                    //if the reference have some values
                    if snapshot.childrenCount > 0 {
                        //iterating through all the values
                        for posts in snapshot.children.allObjects as! [DataSnapshot] {
                            //If the id of the post matches one of the ids in idList...
                            if (self.idList.contains(String(posts.key))){
                                //getting values
                                let postObject = posts.value as? [String: AnyObject]
                                let postTitle  = postObject?["title"]
                                let postDescription  = postObject?["description"]
                                let postPrice = postObject?["price"]
                                let postCategory = postObject?["category"]
                                let postUserID = postObject?["userID"]
                                let postID = postObject?["postID"]
                                
                                //creating post object with model and fetched values
                                let post = Post(title: postTitle as! String, description: postDescription as! String, price: postPrice as! String, category: postCategory as! String, userID: postUserID as! String, id: postID as! String)
                                
                                //appending it to list
                                self.postList.append(post)
                            }
                        }
                        //reloading the tableview
                        self.tableView.reloadData()
                    }
                })
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.postList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "manageCell", for: indexPath)
        
        let currentPost = postList[indexPath.row]
        cell.textLabel?.text = currentPost.postTitle
        
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? ManagePostViewController,
            let selectedIndexPath = tableView.indexPathForSelectedRow {
            destinationVC.currentPost = postList[selectedIndexPath.row]
        }
    }
    

}
