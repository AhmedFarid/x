//
//  myOrderDitealsCell.swift
//  Alforno
//
//  Created by Ahmed farid on 3/8/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class myOrderDitealsCell: UITableViewCell {

    @IBOutlet weak var imagse: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var qty: UILabel!
    @IBOutlet weak var price: UILabel!
    
    
    var addtion: (()->())?
    
    
    func configureCell(orderDiteals: orderDiteslData){
        title.text = orderDiteals.productName
        price.text = "Price \(orderDiteals.productPrice ?? 0)"
        qty.text = "Quantity \(orderDiteals.productQuantity ?? 0)"
        let urlWithoutEncoding = ("\(URLs.mainImage)\(orderDiteals.image!)")
        let encodedLink = urlWithoutEncoding.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let encodedURL = NSURL(string: encodedLink!)! as URL
        imagse.kf.indicatorType = .activity
        if let url = URL(string: "\(encodedURL)") {
            imagse.kf.setImage(with: url,placeholder: UIImage(named: "placeholder"))
        }
    }
    
    
    
    @IBAction func addtionalBTNAction(_ sender: Any) {
        addtion?()
    }
}
