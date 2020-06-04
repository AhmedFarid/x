//
//  myOrderDitealsVC.swift
//  Alforno
//
//  Created by Ahmed farid on 3/8/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class myOrderDitealsVC: UIViewController, NVActivityIndicatorViewable {
    
    @IBOutlet weak var paymentMethod: UILabel!
    @IBOutlet weak var taxes: UILabel!
    @IBOutlet weak var shipping: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var totoalPrice: UILabel!
    @IBOutlet weak var orderDitealsTabelView: UITableView!
    
    var orderDitels = [orderDiteslData]()
    var singlItem: orderData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myOrdersDitelsHandelRefresh()
        paymentMethod.text = "\(singlItem?.paymentMethod ?? 0)"
        taxes.text = "\(singlItem?.tax ?? 0)"
        shipping.text = "\(singlItem?.deleveryFees ?? 0)"
        address.text = singlItem?.customerAddress
        totoalPrice.text = "\(singlItem?.orderTotalPrice ?? 0)"
        orderDitealsTabelView.delegate = self
        orderDitealsTabelView.dataSource = self
        self.orderDitealsTabelView.register(UINib.init(nibName: "myOrderDitealsCell", bundle: nil), forCellReuseIdentifier: "cell")
        myOrdersDitelsHandelRefresh()
        setUpNav(logo: true, menu: false, cart: false, back: true)
        
    }
    
    func myOrdersDitelsHandelRefresh(){
        startAnimating(CGSize(width: 45, height: 45), message: "Loading",type: .ballSpinFadeLoader, color: .red, textColor: .white)
        myOrderApi.myOrdersDitelse(order_id: "\(singlItem?.orderID ?? 0)"){ (error,networkSuccess,codeSucess,orderDitels) in
            if networkSuccess {
                if codeSucess {
                    if orderDitels?.status == true {
                        if let orderDitels = orderDitels{
                            self.orderDitels = orderDitels.data ?? []
                            print("zzzz\(orderDitels)")
                            self.orderDitealsTabelView.reloadData()
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

extension myOrderDitealsVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderDitels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = orderDitealsTabelView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? myOrderDitealsCell {
            cell.configureCell(orderDiteals: orderDitels[indexPath.row])
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.addtion = {
                let vc = additionsVC(nibName: "additionsVC", bundle: nil)
                vc.singitemMyorders = self.orderDitels[indexPath.row]
                vc.fromMyorders = false
                vc.orderID = "\(self.singlItem?.orderID ?? 0)"
                vc.modalPresentationStyle = .overCurrentContext
                self.present(vc,animated: true)
            }
            return cell
        }else {
            return myOrderDitealsCell()
        }
    }
}
