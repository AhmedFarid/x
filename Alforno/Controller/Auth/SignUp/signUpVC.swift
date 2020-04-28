//
//  signUpVC.swift
//  Alforno
//
//  Created by Ahmed farid on 2/18/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class signUpVC: UIViewController, NVActivityIndicatorViewable{
    
    var hide:Bool = true
    
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var phoneText: UITextField!
    @IBOutlet weak var fullNameText: UITextField!
    @IBOutlet weak var scroll: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scroll.delegate = self
        setUpNav(logo: false, menu: false, cart: false, back: true)
    }
    
    @IBAction func registerBtnAction(_ sender: Any) {
        
        let response = Validation.shared.validate(values:
            (ValidationType.alphabeticString, fullNameText.text ?? "")
            ,(ValidationType.phoneNo, phoneText.text ?? "")
            ,(ValidationType.email, emailText.text ?? "")
            ,(ValidationType.password, passwordText.text ?? ""))
        switch response {
        case .success:
            startAnimating(CGSize(width: 45, height: 45), message: "Loading",type: .ballSpinFadeLoader, color: .red, textColor: .white)
            registerApi.register(name: fullNameText.text ?? "", phone: phoneText.text ?? "", email: emailText.text ?? "", password: passwordText.text ?? "") { (error, success, Register) in
                if success {
                    if Register?.status == false{
                        self.showAlert(title: "Sign Up", message: "Faild your mail is used")
                        self.stopAnimating()
                    }else{
                        let login = Register?.data
                        print(login?.email ?? "")
                    }
                }else {
                    self.showAlert(title: "SignUp", message: "Check your network")
                    self.stopAnimating()
                }
                
            }
            break
        case .failure(_, let message):
            showAlert(title: "SignUp", message: message.localized())
        }
    }
}

extension signUpVC: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        if(velocity.y>0) {
            UIView.animate(withDuration: 1.0, delay: 0, options: UIView.AnimationOptions(), animations: {
                self.navigationController?.setNavigationBarHidden(true, animated: true)
                self.hide = false
            }, completion: nil)
            
        } else {
            UIView.animate(withDuration: 1.0, delay: 0, options: UIView.AnimationOptions(), animations: {
                self.navigationController?.setNavigationBarHidden(false, animated: true)
                self.hide = true
            }, completion: nil)
        }
    }
}
