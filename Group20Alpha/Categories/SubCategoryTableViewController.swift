//
//  SubCategoryTableViewController.swift
//  Group20Alpha
//
//  Created by Brandon Head on 4/25/18.
//  Copyright © 2018 Group 20. All rights reserved.
//

import UIKit
import Firebase

class SubCategoryTableViewController: UITableViewController {
    var ref: DatabaseReference!

    var category: String?    //This gets set in the prepareForSegue deal in the other controller? Maybe? It shouldn't ever be nil, I don't think.
    var postList: [Post] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference().child(category!)
        
        ref.observe(DataEventType.value, with: { (snapshot) in
            
            //if the reference have some values
            if snapshot.childrenCount > 0 {
                
                //clearing the list
                self.postList.removeAll()
                
                //iterating through all the values
                for posts in snapshot.children.allObjects as! [DataSnapshot] {
                    //getting values
                    let postObject = posts.value as? [String: AnyObject]
                    let postTitle  = postObject?["title"]
                    let postDescription  = postObject?["description"]
                    let postPrice = postObject?["price"]
                    let postCategory = postObject?["category"]
                    let postUserID = postObject?["userID"]
                    let postID = postObject?["postID"]
                    let postComments = postObject?["comments"]
                    
                    //creating post object with model and fetched values
                    let post = Post(title: postTitle as! String, description: postDescription as! String, price: postPrice as! String, category: postCategory as! String, userID: postUserID as! String, id: postID as! String, comments: postComments as! [String])
                    
                    //appending it to list
                    self.postList.append(post)
                }
                
                //reloading the tableview
                self.tableView.reloadData()
            }
        })


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        return postList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subCatCell", for: indexPath)
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? PostViewController,
            let selectedIndexPath = tableView.indexPathForSelectedRow {
            destinationVC.post = postList[selectedIndexPath.row]
        }
    }

}
