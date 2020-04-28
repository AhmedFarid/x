//
//  sideMenuVC.swift
//  Alforno
//
//  Created by Ahmed farid on 3/1/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import SideMenu

class sideMenuVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavColore(true)
    }
    
    @IBAction func homeBTN(_ sender: Any) {
        let vc = homeVC(nibName: "homeVC", bundle: nil)
        self.navigationController!.pushViewController(vc, animated: true)
        dismiss(animated: true, completion: nil)
    }
    @IBAction func menuBTN(_ sender: Any) {
        let vc = menuVC(nibName: "menuVC", bundle: nil)
        self.navigationController!.pushViewController(vc, animated: true)
        dismiss(animated: true, completion: nil)
    }
    @IBAction func cartBTN(_ sender: Any) {
        let vc = cartVC(nibName: "cartVC", bundle: nil)
        vc.fromMnue = true
        self.navigationController!.pushViewController(vc, animated: true)
        dismiss(animated: true, completion: nil)
    }
    @IBAction func orderBTN(_ sender: Any) {
        let vc = myOrdersVC(nibName: "myOrdersVC", bundle: nil)
        self.navigationController!.pushViewController(vc, animated: true)
        dismiss(animated: true, completion: nil)
    }
    @IBAction func favBTN(_ sender: Any) {
        let vc = favouritesVC(nibName: "favouritesVC", bundle: nil)
        self.navigationController!.pushViewController(vc, animated: true)
        dismiss(animated: true, completion: nil)
    }
    @IBAction func profileBTN(_ sender: Any) {
        let vc = profileVC(nibName: "profileVC", bundle: nil)
        self.navigationController!.pushViewController(vc, animated: true)
        dismiss(animated: true, completion: nil)
    }
    @IBAction func contactUSBTN(_ sender: Any) {
        let vc = contactUsVC(nibName: "contactUsVC", bundle: nil)
        self.navigationController!.pushViewController(vc, animated: true)
        dismiss(animated: true, completion: nil)
    }
    @IBAction func aboutUSBTN(_ sender: Any) {
        let vc = aboutUsVC(nibName: "aboutUsVC", bundle: nil)
        self.navigationController!.pushViewController(vc, animated: true)
        dismiss(animated: true, completion: nil)
    }
    @IBAction func logoutBTN(_ sender: Any) {
        helperLogin.dleteAPIToken()
    }
}
