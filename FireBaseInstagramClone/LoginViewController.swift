//
//  LoginViewController.swift
//  FireBaseInstagramClone
//
//  Created by Özgür  Elmaslı on 10.03.2019.
//  Copyright © 2019 Özgür  Elmaslı. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


class LoginViewController: UIViewController {

    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var usernameTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func loginButton(_ sender: Any) {
        
        if usernameTxt.text != "" && passwordTxt.text! != ""
        {
            Auth.auth().signIn(withEmail: usernameTxt.text!, password: passwordTxt.text!) { (userdata, error) in
                if error != nil
                {
                    let alert = UIAlertController(title: "Hata", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    let okbutton = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.cancel, handler: nil)
                    alert.addAction(okbutton)
                    self.present(alert,animated: true,completion: nil)
                }
                else
                {
                    UserDefaults.standard.set(userdata?.user.email!, forKey: "user")
                    UserDefaults.standard.synchronize()
                    
                    let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
                    delegate.rememberlogin()
                }
            }
        }
        else
        {
            let alert = UIAlertController(title: "Hata", message: "Boş Alanlar var ", preferredStyle: UIAlertController.Style.alert)
            let okbutton = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.cancel, handler: nil)
            alert.addAction(okbutton)
            self.present(alert,animated: true,completion: nil)
        }
        
        
        
        performSegue(withIdentifier: "showtabct", sender: nil)
    }
    
    @IBAction func signinButton(_ sender: Any) {
        
         if usernameTxt.text != "" && passwordTxt.text! != ""
         {
            Auth.auth().createUser(withEmail: usernameTxt.text!, password: passwordTxt.text!) { (user, error) in
                if error != nil
                {
                    let alert = UIAlertController(title: "Hata", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    let okbutton = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.cancel, handler: nil)
                    alert.addAction(okbutton)
                    self.present(alert,animated: true,completion: nil)
                }
                else
                {
                    UserDefaults.standard.set(user!.user.email!, forKey: "user")
                    UserDefaults.standard.synchronize()
                    
                    let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
                    delegate.rememberlogin()
                }
            }
        }
        else
         {
            let alert = UIAlertController(title: "Hata", message: "Boş Alanlar var ", preferredStyle: UIAlertController.Style.alert)
            let okbutton = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.cancel, handler: nil)
            alert.addAction(okbutton)
            self.present(alert,animated: true,completion: nil)
        }
        
    }
    
}
