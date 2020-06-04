//
//  cartVC.swift
//  Alforno
//
//  Created by Ahmed farid on 3/5/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import SideMenu
import NVActivityIndicatorView

class cartVC: UIViewController, NVActivityIndicatorViewable{
    
    
    var fromMnue = false
    
    var liCart = [listCart]()
    var totalPrice = 0
    
    @IBOutlet weak var createOrderBTN: coustomRoundedButton!
    @IBOutlet weak var totlaPrice: UILabel!
    @IBOutlet weak var totalDeleveryFees: UILabel!
    @IBOutlet weak var cartDataList: UILabel!
    @IBOutlet weak var cartTabelView: UITableView!
    @IBOutlet weak var totalTax: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.cartTabelView.register(UINib.init(nibName: "cartCell", bundle: nil), forCellReuseIdentifier: "cell")
        cartTabelView.delegate = self
        cartTabelView.dataSource = self
        
        cartHandelRefresh()
        
        if fromMnue == false {
            setUpNav(logo: true, menu: false, cart: false, back: true)
        }else {
            setUpNav(logo: true, menu: true, cart: false, back: false)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cartHandelRefresh()
    }
    
    func cartHandelRefresh(){
        startAnimating(CGSize(width: 45, height: 45), message: "Loading",type: .ballSpinFadeLoader, color: .red, textColor: .white)
        cartApi.listOfCart{ (error,networkSuccess,codeSucess,liCart) in
            if networkSuccess {
                if codeSucess {
                    if liCart?.status == true {
                        if let liCart = liCart{
                            self.liCart = liCart.data?.list ?? []
                            print("zzzz\(liCart)")
                            self.cartDataList.text = "\(self.liCart.count) Items / Total Cost \(liCart.data?.price?.removeZerosFromEnd() ?? "") \(self.liCart[0].currency ?? "$")"
                            self.totlaPrice.text = "\(liCart.data?.price?.removeZerosFromEnd() ?? "") \(self.liCart[0].currency ?? "$")"
                            self.totalTax.text = "\(liCart.data?.totalTax?.removeZerosFromEnd() ?? "") \(self.liCart[0].currency ?? "$")"
                            self.totalDeleveryFees.text = "\(liCart.data?.totalDeleveryFees ?? 0) \(self.liCart[0].currency ?? "$")"
                            self.totalPrice = Int(liCart.data?.price ?? 0)
                            self.cartTabelView.reloadData()
                            self.stopAnimating()
                        }else {
                            self.stopAnimating()
                            self.showAlert(title: "Cart", message: "Error Cart")
                            self.createOrderBTN.isHidden = true
                            self.cartDataList.text = ""
                            self.totlaPrice.text = ""
                            self.totalTax.text = ""
                            self.totalDeleveryFees.text = ""
                        }
                    }else {
                        self.stopAnimating()
                        self.showAlert(title: "Cart", message: "Error Cart")
                        self.createOrderBTN.isHidden = true
                        self.cartDataList.text = ""
                        self.totlaPrice.text = ""
                        self.totalTax.text = ""
                        self.totalDeleveryFees.text = ""
                    }
                }else {
                    self.stopAnimating()
                    self.showAlert(title: "Cart", message: "Cart is empty")
                    self.createOrderBTN.isHidden = true
                    self.cartDataList.text = ""
                    self.totlaPrice.text = ""
                    self.totalTax.text = ""
                    self.totalDeleveryFees.text = ""
                }
            }else {
                self.stopAnimating()
                self.showAlert(title: "Cart", message: "Check your network connection")
                self.createOrderBTN.isHidden = true
                self.cartDataList.text = ""
                self.totlaPrice.text = ""
                self.totalTax.text = ""
                self.totalDeleveryFees.text = ""
            }
        }
    }
    
    func optionCart(url: String, cartID: String) {
        startAnimating(CGSize(width: 45, height: 45), message: "Loading...",type: .ballSpinFadeLoader, color: .red, textColor: .white)
        cartApi.optionCarts(url: url, cart_id: cartID){ (error, success, addTofav) in
            if success {
                self.stopAnimating()
                self.showAlert(title: "Cart", message: addTofav?.data ?? "")
                self.cartTabelView.reloadData()
            }else {
                self.showAlert(title: "Cart", message: "Check your network")
                self.stopAnimating()
                self.cartTabelView.reloadData()
            }
        }
    }
    
    @IBAction func checkOutBTN(_ sender: Any) {
        let vc = createOrderVC(nibName: "createOrderVC", bundle: nil)
        vc.totoalPrice = totalPrice
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
}


extension cartVC: UITableViewDataSource, UITableViewDelegate {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return liCart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = cartTabelView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? cartCell {
            cell.configureCell(cart: liCart[indexPath.row])
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            if self.liCart[indexPath.row].quantity == 1{
                cell.minBtn.isHidden = true
            }else {
                cell.minBtn.isHidden = false
            }
            cell.add = {
                self.optionCart(url: URLs.plusQuentityCart, cartID: "\(self.liCart[indexPath.row].cartID ?? 0)")
                self.cartHandelRefresh()
            }
            
            cell.deleteBtn = {
                self.optionCart(url: URLs.deleteCart, cartID: "\(self.liCart[indexPath.row].cartID ?? 0)")
                self.cartHandelRefresh()
                if self.liCart.count == 1{
                    self.liCart.removeAll()
                    self.cartHandelRefresh()
                }
            }
            
            cell.min = {
                self.optionCart(url: URLs.minQuentityCart, cartID: "\(self.liCart[indexPath.row].cartID ?? 0)")
                self.cartHandelRefresh()
            }
            
            cell.addtions = {
                let vc = additionsVC(nibName: "additionsVC", bundle: nil)
                // = modalTransitionStyle
                vc.modalPresentationStyle = .overCurrentContext
                vc.singleItem = self.liCart[indexPath.row]
                self.present(vc,animated: true)
                
                //self.pushViewController(vc, animated: true)
            }
            return cell
        }else {
            return cartCell()
        }
    }
}


extension Double {
    func removeZerosFromEnd() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 16 //maximum digits in Double after dot (maximum precision)
        return String(formatter.string(from: number) ?? "")
    }
}
