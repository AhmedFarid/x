//
//  contactUsVC.swift
//  Alforno
//
//  Created by Ahmed farid on 3/3/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import SideMenu

class contactUsVC: UIViewController, NVActivityIndicatorViewable {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var message: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        message.delegate = self
        message.text = "Message"
        message.textColor = UIColor.lightGray
        setUpNav(logo: true, menu: true, cart: true, back: false)
        
    }
    
    @IBAction func sendAction(_ sender: Any) {
        
        guard let phones = phone.text, !phones.isEmpty else {
            let messages = NSLocalizedString("enter your phone", comment: "hhhh")
            let title = NSLocalizedString("order", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard let emails = email.text, !emails.isEmpty else {
            let messages = NSLocalizedString("enter your  email", comment: "hhhh")
            let title = NSLocalizedString("order", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        
        guard let names = name.text, !names.isEmpty else {
            let messages = NSLocalizedString("enter your full name", comment: "hhhh")
            let title = NSLocalizedString("order", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        startAnimating(CGSize(width: 45, height: 45), message: "Loading",type: .ballSpinFadeLoader, color: .red, textColor: .white)
        contactUsApi.message(name: name.text ?? "", email: email.text ?? "", phone: phone.text ?? "", message: message.text ?? "") { (error, success, addTofav) in
            if success {
                self.stopAnimating()
                self.showAlert(title: "contact us", message: addTofav?.data ?? "")
            }else {
                self.showAlert(title: "contact us", message: "Check your network")
                self.stopAnimating()
            }
        }
        
    }
}

extension contactUsVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Message"
            textView.textColor = UIColor.lightGray
        }
    }
}
