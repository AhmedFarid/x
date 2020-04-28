//
//  createOrderVC.swift
//  Alforno
//
//  Created by Ahmed farid on 3/7/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class createOrderVC: UIViewController,NVActivityIndicatorViewable {
    
    @IBOutlet weak var comments: UITextField!
    @IBOutlet weak var appartNumber: UITextField!
    @IBOutlet weak var floorNumber: UITextField!
    @IBOutlet weak var buildingNumber: UITextField!
    @IBOutlet weak var cpuntry: UITextField!
    @IBOutlet weak var streetName: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var viewHight: NSLayoutConstraint!
    
    var totoalPrice = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNav(logo: true, menu: false, cart: false, back: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewHight.constant = self.view.frame.size.height + 280
    }
    
    @IBAction func checkOutAction(_ sender: Any) {
        
        guard let comment = comments.text, !comment.isEmpty else {
            let messages = NSLocalizedString("enter your comment", comment: "hhhh")
            let title = NSLocalizedString("order", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard let appartNum = appartNumber.text, !appartNum.isEmpty else {
            let messages = NSLocalizedString("enter your appart number", comment: "hhhh")
            let title = NSLocalizedString("order", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard let floorNum = floorNumber.text, !floorNum.isEmpty else {
            let messages = NSLocalizedString("enter your floor number", comment: "hhhh")
            let title = NSLocalizedString("order", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard let buildingNum = buildingNumber.text, !buildingNum.isEmpty else {
            let messages = NSLocalizedString("enter your building number", comment: "hhhh")
            let title = NSLocalizedString("order", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard let cpuntrys = cpuntry.text, !cpuntrys.isEmpty else {
            let messages = NSLocalizedString("enter your country", comment: "hhhh")
            let title = NSLocalizedString("order", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard let streetNam = streetName.text, !streetNam.isEmpty else {
            let messages = NSLocalizedString("enter your street name", comment: "hhhh")
            let title = NSLocalizedString("order", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        
        guard let citys = city.text, !citys.isEmpty else {
            let messages = NSLocalizedString("enter your city", comment: "hhhh")
            let title = NSLocalizedString("order", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard let phones = phone.text, !phones.isEmpty else {
            let messages = NSLocalizedString("enter your phone", comment: "hhhh")
            let title = NSLocalizedString("order", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard let addres = address.text, !addres.isEmpty else {
            let messages = NSLocalizedString("enter your address", comment: "hhhh")
            let title = NSLocalizedString("order", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        startAnimating(CGSize(width: 45, height: 45), message: "Loading...",type: .ballSpinFadeLoader, color: .red, textColor: .white)
        cartApi.createOreder(order_totalPrice: "\(totoalPrice)", customerAddress: address.text ?? "", customerPhone: phone.text ?? "", customerCity: city.text ?? "" , customerStreet: streetName.text ?? "", customerAppartmentNumber: appartNumber.text ?? "", customerFloorNumber: floorNumber.text ?? "", customerHomeNumber: buildingNumber.text ?? "", customerCommentsExtra: comments.text ?? "", customerCountry: cpuntry.text ?? ""){ (error, success, addTofav) in
            if success {
                self.stopAnimating()
                let alert = UIAlertController(title: "Order", message: "\(addTofav?.data ?? "")", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction) in
                    let vc = homeVC(nibName: "homeVC", bundle: nil)
                    self.navigationController!.pushViewController(vc, animated: true)
                }))
                self.present(alert, animated: true, completion: nil)
            }else {
                self.showAlert(title: "My orders", message: "Check your network")
                self.stopAnimating()
            }
        }
    }
}
