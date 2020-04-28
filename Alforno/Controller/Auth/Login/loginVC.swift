//
//  loginVC.swift
//  Alforno
//
//  Created by Ahmed farid on 2/18/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class loginVC: UIViewController, NVActivityIndicatorViewable {
    
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavColore(true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func loginBTN(_ sender: Any) {
        
        let response = Validation.shared.validate(values:
            (ValidationType.email, emailText.text ?? "")
            ,(ValidationType.password, passwordText.text ?? ""))
        switch response {
        case .success:
            startAnimating(CGSize(width: 45, height: 45), message: "Loading",type: .ballSpinFadeLoader, color: .red, textColor: .white)
            loginApi.login(email: emailText.text ?? "", password: passwordText.text ?? "") { (error, success, login) in
                if success {
                    if login?.status == false{
                        self.stopAnimating()
                        self.showAlert(title: "Login", message: "Faild email or password is wrong")
                    }else{
                        let login = login?.data
                        print(login?.email ?? "")
                    }
                }else {
                    self.stopAnimating()
                    self.showAlert(title: "Login", message: "Check your network")
                }
            }
            break
        case .failure(_, let message):
            showAlert(title: "Login", message: message.localized())
        }
    }
    
    @IBAction func signupActionButton(_ sender: Any) {
        let vc = signUpVC(nibName: "signUpVC", bundle: nil)
        self.navigationController!.pushViewController(vc, animated: true)
    }
}
