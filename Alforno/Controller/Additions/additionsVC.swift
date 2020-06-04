//
//  additionsVC.swift
//  Alforno
//
//  Created by Ahmed farid on 3/7/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class additionsVC: UIViewController,NVActivityIndicatorViewable {
    
    @IBOutlet weak var addtionalTabelView: UITableView!
    
    var additonal = [offfersData]()
    var singleItem: listCart?
    var singitemMyorders: orderDiteslData?
    var orderID = ""
    var fromMyorders = true
    @IBOutlet weak var popView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTap(_:))))
        popView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapPop(_:))))
        

        self.addtionalTabelView.register(UINib.init(nibName: "productsAdditionsCell", bundle: nil), forCellReuseIdentifier: "cell")
        addtionalTabelView.delegate = self
        addtionalTabelView.dataSource = self
        
        if fromMyorders == true{
            print("zzz")
            cartHandelRefresh(URl: URLs.listDataCartAdditions, cart_id: "\(singleItem?.cartID ?? 0)", order_id: "", product_id: "")
        }else {
            print("wwwz")
            cartHandelRefresh(URl: URLs.orderAddtionsDetails, cart_id: "", order_id: orderID, product_id: "\(singitemMyorders?.productID ?? 0)")
        }
        
    }
    
    @objc func onTap(_ sender:UIPanGestureRecognizer) {
       dismiss(animated: false, completion: nil)
    }
    
    @objc func onTapPop(_ sender:UIPanGestureRecognizer) {
        
    }
    
    @IBAction func closeBtn(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
    func cartHandelRefresh(URl: String,cart_id: String,order_id: String,product_id: String){
        startAnimating(CGSize(width: 45, height: 45), message: "Loading",type: .ballSpinFadeLoader, color: .red, textColor: .white)
        cartApi.listCartAddtional(Url: URl, product_id: product_id, order_id: order_id, cart_id: cart_id){ (error,networkSuccess,codeSucess,additonal) in
            if networkSuccess {
                if codeSucess {
                    if additonal?.status == true {
                        if let additonal = additonal{
                            self.additonal = additonal.data ?? []
                            print("zzzz\(additonal)")
                            self.addtionalTabelView.reloadData()
                            self.stopAnimating()
                        }else {
                            self.stopAnimating()
                            self.showAlert(title: "My orders", message: "Error My orders")
                        }
                    }else {
                        self.stopAnimating()
                        self.showAlert(title: "My orders", message: "Error My orders")
                    }
                }else {
                    self.stopAnimating()
                    self.showAlert(title: "My orders", message: "My orders is empty")
                }
            }else {
                self.stopAnimating()
                self.showAlert(title: "My orders", message: "Check your network connection")
            }
        }
        
    }
}


extension additionsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        additonal.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = addtionalTabelView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? productsAdditionsCell {
            cell.configureCell(offer: additonal[indexPath.row])
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.selctedImg.isHidden = true
            return cell
        }else {
            return productsAdditionsCell()
        }
    }
}
