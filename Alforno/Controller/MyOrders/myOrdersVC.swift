//
//  myOrdersVC.swift
//  Alforno
//
//  Created by Ahmed farid on 3/8/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import SideMenu
import NVActivityIndicatorView

class myOrdersVC: UIViewController, NVActivityIndicatorViewable{
    
    @IBOutlet weak var myOrdertabelView: UITableView!
    var myOrderList = [orderData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNav(logo: true, menu: true, cart: true, back: false)
        self.myOrdertabelView.register(UINib.init(nibName: "myOrdersCell", bundle: nil), forCellReuseIdentifier: "cell")
        myOrdertabelView.dataSource = self
        myOrdertabelView.delegate = self
        myOrdersHandelRefresh()
        
    }
    
    func myOrdersHandelRefresh(){
        startAnimating(CGSize(width: 45, height: 45), message: "Loading",type: .ballSpinFadeLoader, color: .red, textColor: .white)
        myOrderApi.myOrders{ (error,networkSuccess,codeSucess,myOrderList) in
            if networkSuccess {
                if codeSucess {
                    if myOrderList?.status == true {
                        if let myOrderList = myOrderList{
                            self.myOrderList = myOrderList.data ?? []
                            print("zzzz\(myOrderList)")
                            self.myOrdertabelView.reloadData()
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

extension myOrdersVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myOrderList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = myOrdertabelView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? myOrdersCell {
            cell.configureCell(orders: myOrderList[indexPath.row])
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }else {
            return myOrdersCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = myOrderDitealsVC(nibName: "myOrderDitealsVC", bundle: nil)
        vc.singlItem = myOrderList[indexPath.row]
        self.navigationController!.pushViewController(vc, animated: true)
    }
}


