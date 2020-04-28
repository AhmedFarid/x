//
//  myOrdersCell.swift
//  Alforno
//
//  Created by Ahmed farid on 3/8/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class myOrdersCell: UITableViewCell {
    
    @IBOutlet weak var orderId: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var stutes: UILabel!
    
    func configureCell(orders: orderData){
        stutes.layer.cornerRadius = 8
        orderId.text = "Order Id: \(orders.orderID ?? 0)"
        price.text = "Order Total Price: \(orders.orderTotalPrice ?? "")"
        date.text = "Order date: \(orders.createdAt ?? "")"
        if orders.orderStat == "1" {
            stutes.text = "order dliverd"
        }else if orders.orderStat == "2" {
            stutes.text = "order canceld"
        }else {
            stutes.text = "order in way"
        }
    }
}
