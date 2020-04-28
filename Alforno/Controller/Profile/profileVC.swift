//
//  profileVC.swift
//  Alforno
//
//  Created by Ahmed farid on 3/3/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import SideMenu

class profileVC: UIViewController,NVActivityIndicatorViewable {
    
    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var editBTN: coustomRoundedButton!
    
    var profile = [profileData]()
   // var editProfiles = [editProfiel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNav()
        profileHandelRefresh()
    }
    
    func setUpNav() {
        let leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "menu-1"), style: .done, target: self, action: #selector(sideMenu))
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        
        
        let rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "Group 258-1"), style: .done, target: self, action: #selector(profileVC.showUpdate))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        
    }
    
    
    @objc func showUpdate() {
        editBTN.isHidden = false
        emailAddress.isEnabled = true
        phone.isEnabled = true
        fullName.isEnabled = true
        
        let rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "Group 259"), style: .done, target: self, action: #selector(profileVC.hideCart))
               self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    @objc func hideCart() {
        editBTN.isHidden = true
        emailAddress.isEnabled = false
        phone.isEnabled = false
        fullName.isEnabled = false
        
        let rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "Group 258-1"), style: .done, target: self, action: #selector(profileVC.showUpdate))
               self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    func profileHandelRefresh(){
        startAnimating(CGSize(width: 45, height: 45), message: "Loading",type: .ballSpinFadeLoader, color: .red, textColor: .white)
        userProfileApi.profile{ (error,networkSuccess,codeSucess,profile) in
            if networkSuccess {
                if codeSucess {
                    if profile?.status == true {
                        if let profile = profile{
                            self.profile = profile.data ?? []
                            print("zzzz\(profile)")
                            self.fullName.text = self.profile[0].name
                            self.phone.text = self.profile[0].phone
                            self.emailAddress.text = self.profile[0].email
                            self.stopAnimating()
                        }else {
                            self.stopAnimating()
                            self.showAlert(title: "Error", message: "Error profile")
                        }
                    }else {
                        self.stopAnimating()
                        self.showAlert(title: "profile", message: "Error profile")
                    }
                }else {
                    self.stopAnimating()
                    self.showAlert(title: "profile", message: "profile is Error")
                }
            }else {
                self.stopAnimating()
                self.showAlert(title: "Network", message: "Check your network connection")
            }
        }
    }
    
    
    @IBAction func editAction(_ sender: Any) {
        
        
        guard let emailA = emailAddress.text, !emailA.isEmpty else {
            let messages = NSLocalizedString("enter your country", comment: "hhhh")
            let title = NSLocalizedString("order", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard let phones = phone.text, !phones.isEmpty else {
            let messages = NSLocalizedString("enter your  phone", comment: "hhhh")
            let title = NSLocalizedString("order", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        
        guard let name = fullName.text, !name.isEmpty else {
            let messages = NSLocalizedString("enter your full name", comment: "hhhh")
            let title = NSLocalizedString("order", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
       
        
        startAnimating(CGSize(width: 45, height: 45), message: "Loading",type: .ballSpinFadeLoader, color: .red, textColor: .white)
        userProfileApi.upadateProfile(name: fullName.text ?? "", phone: phone.text ?? "", email: emailAddress.text ?? ""){ (error, success,contrct, addTofav) in
            if success {
                self.stopAnimating()
                self.showAlert(title: "Profile", message: addTofav?.data ?? "")
                self.editBTN.isHidden = true
                self.emailAddress.isEnabled = false
                self.phone.isEnabled = false
                self.fullName.isEnabled = false
                let rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "Group 258-1"), style: .done, target: self, action: #selector(profileVC.showUpdate))
                self.navigationItem.rightBarButtonItem = rightBarButtonItem
                self.profileHandelRefresh()
            }else {
                self.showAlert(title: "Profile", message: "Check your network")
                self.stopAnimating()
                self.editBTN.isHidden = true
                self.emailAddress.isEnabled = false
                self.phone.isEnabled = false
                self.fullName.isEnabled = false
                let rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "Group 258-1"), style: .done, target: self, action: #selector(profileVC.showUpdate))
                self.navigationItem.rightBarButtonItem = rightBarButtonItem
                self.profileHandelRefresh()
            }
        }
        
    }
    
}

