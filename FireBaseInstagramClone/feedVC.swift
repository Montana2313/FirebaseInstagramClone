//
//  FirstViewController.swift
//  FireBaseInstagramClone
//
//  Created by Özgür  Elmaslı on 9.03.2019.
//  Copyright © 2019 Özgür  Elmaslı. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import SDWebImage


class feedVC : UIViewController , UITableViewDelegate , UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var userEmailArray = [String]()
    var userCommentArray = [String]()
    var userImageArray = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getData()
    }
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(feedVC.getData), name: NSNotification.Name(rawValue: "newPost"), object: nil)
    }
    @objc func getData()
    {
        let databaseRef = Database.database().reference()
        databaseRef.child("Users").observe(DataEventType.childAdded) { (snapshot) in
          //  print("childer :  \(snapshot.children)")
           // print("values :  \(snapshot.value)")
           // print("key :  \(snapshot.key)")
            
            let values = snapshot.value! as! NSDictionary
            
            let post = values["post"] as! NSDictionary
            
            let postID = post.allKeys
            
            for itemId in postID
            {
                let singlepost = post[itemId] as! NSDictionary
                self.userCommentArray.append(singlepost["usercomment"] as! String)
                self.userEmailArray.append(singlepost["postedBy"] as! String)
                self.userImageArray.append(singlepost["image"] as! String)
            }
            self.tableView.reloadData()
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userEmailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! feedCell
        
        cell.userEmailLabel.text = userEmailArray[indexPath.row]
        cell.userCommentLabel.text = userCommentArray[indexPath.row]
        cell.userimageview.sd_setImage(with: URL(string: self.userImageArray[indexPath.row]))
        return cell
    }

    @IBAction func logoutButton(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "user")
        UserDefaults.standard.synchronize()
        
        let signIn = self.storyboard?.instantiateViewController(withIdentifier: "login") as! LoginViewController
        
        let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        delegate.window?.rootViewController = signIn
        
        delegate.rememberlogin()
        
        do{
            try    Auth.auth().signOut()
        }
        catch
        {
            print(error)
        }
      
    }
    
}

