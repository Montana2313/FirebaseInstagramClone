//
//  SecondViewController.swift
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

class postVC: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate {

    @IBOutlet weak var postComment: UITextField!
    @IBOutlet weak var postimage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        postimage.isUserInteractionEnabled = true
        let gestureReco = UITapGestureRecognizer(target: self, action: #selector(postVC.selectimage))
        postimage.addGestureRecognizer(gestureReco)
    }
    @objc func selectimage()
    {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker,animated: true,completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        postimage.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func postButton(_ sender: Any) {
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let mediaobject = storageRef.child("media")
        
        if let data = postimage.image?.jpegData(compressionQuality: 0.5)
        {
            let uuid = NSUUID().uuidString
            let mediaimage = mediaobject.child("\(uuid).jpg")
            mediaimage.putData(data, metadata: nil) { (storagedata, error) in
                if error != nil
                {
                    let alert = UIAlertController(title: "Hata", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    let okbutton = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.cancel, handler: nil)
                    alert.addAction(okbutton)
                    self.present(alert,animated: true,completion: nil)
                }
                else {
                    mediaimage.downloadURL(completion: { (url, error) in
                        if error == nil
                        {
                             // we have url where image saved  and username
                            // and comment
                            // we can save all data on database
                            // Database
                             if self.postComment.text != ""
                             {
                                let imageURL = url?.absoluteString
                                let databaseRef = Database.database().reference()
                                
                                let post = ["image" : imageURL! , "postedBy" : Auth.auth().currentUser!.email!, "usercomment" : self.postComment.text!, "uuid" : uuid ] as [String : Any]
                                
                                databaseRef.child("Users").child((Auth.auth().currentUser!.uid)).child("post").childByAutoId().setValue(post)
                                
                                self.postimage.image = UIImage(named: "resim.jpg")
                                self.postComment.text = ""
                                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newPost"),object :nil)
                                
                                self.tabBarController?.selectedIndex = 0 
                                
                            }
                            else
                             {
                                let alert = UIAlertController(title: "Hata", message: "Boş Alanlar var ", preferredStyle: UIAlertController.Style.alert)
                                let okbutton = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.cancel, handler: nil)
                                alert.addAction(okbutton)
                                self.present(alert,animated: true,completion: nil)
                            }
                            
                            
                            
                        }
                    })
                    
                    
                }
            }
        }
        
        
        
        
    }
    

}

