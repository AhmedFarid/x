//
//  cartCell.swift
//  Alforno
//
//  Created by Ahmed farid on 3/5/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class cartCell: UITableViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var qty: UILabel!
    @IBOutlet weak var minBtn: UIButton!
    @IBOutlet weak var maxBtn: UIButton!
    @IBOutlet weak var clearBTN: UIButton!
    @IBOutlet weak var additionalBTN: coustomRoundedButton!
    
    var add: (()->())?
    var min: (()->())?
    var deleteBtn: (()->())?
    var addtions: (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.img.layer.cornerRadius = 8.0
        
    }
    
    func configureCell(cart: listCart){
        title.text = cart.productName
        price.text = "\(cart.totalPriceWithAddtions ?? 0) \(cart.currency ?? "")"
        qty.text = "\(cart.quantity ?? 0)"
        let urlWithoutEncoding = ("\(URLs.mainImage)\(cart.image!)")
        let encodedLink = urlWithoutEncoding.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let encodedURL = NSURL(string: encodedLink!)! as URL
        img.kf.indicatorType = .activity
        if let url = URL(string: "\(encodedURL)") {
            img.kf.setImage(with: url,placeholder: UIImage(named: "placeholder"))
        }
    }
    
    @IBAction func clearBTNAction(_ sender: Any) {
        deleteBtn?()
    }
    
    @IBAction func plusBTNAction(_ sender: Any) {
        add?()
    }
    @IBAction func mainBTNAction(_ sender: Any) {
        min?()
    }
    @IBAction func additionalAction(_ sender: Any) {
        addtions?()
    }
    
    
}
