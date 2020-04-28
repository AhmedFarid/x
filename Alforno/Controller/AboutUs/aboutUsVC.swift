//
//  aboutUsVC.swift
//  Alforno
//
//  Created by Ahmed farid on 3/3/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import SideMenu

class aboutUsVC: UIViewController, NVActivityIndicatorViewable {
    
    var about = [Datum]()
    
    @IBOutlet weak var imageBack: UIImageView!
    @IBOutlet weak var titles: UILabel!
    @IBOutlet weak var decs: UILabel!
    @IBOutlet weak var viewHight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aboutHandelRefresh()
        setUpNav(logo: true, menu: true, cart: true, back: false)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewHight.constant = self.imageBack.frame.size.height + self.decs.frame.size.height + self.titles.frame.size.height
    }
    
    func aboutHandelRefresh(){
        startAnimating(CGSize(width: 45, height: 45), message: "Loading",type: .ballSpinFadeLoader, color: .red, textColor: .white)
        aboutApi.aboutApi{ (error,networkSuccess,codeSucess,about) in
            if networkSuccess {
                if codeSucess {
                    if about?.status == true {
                        if let about = about{
                            self.about = about.data ?? []
                            print("zzzz\(about)")
                            self.titles.text = self.about[0].title
                            self.decs.text = self.about[0].datumDescription
                            //self.viewHight.constant = self.imageBack.frame.size.height + self.decs.frame.size.height + self.titles.frame.size.height
                            self.stopAnimating()
                        }else {
                            self.stopAnimating()
                            self.showAlert(title: "Error", message: "Error About Us")
                        }
                    }else {
                        self.stopAnimating()
                        self.showAlert(title: "About Us", message: "Error About Us")
                    }
                }else {
                    self.stopAnimating()
                    self.showAlert(title: "About Us", message: "About Us Error")
                }
            }else {
                self.stopAnimating()
                self.showAlert(title: "Network", message: "Check your network connection")
            }
        }
    }
    
    
}
