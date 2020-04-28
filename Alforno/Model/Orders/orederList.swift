//
//  orederList.swift
//  Alforno
//
//  Created by Ahmed farid on 3/8/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation

struct oderList: Codable {
    let data: [orderData]?
    let status: Bool?
    let error: String?
}

struct orderData: Codable {
    let orderID: Int?
    let orderTotalPrice: String?
    let tax: Int?
    let deleveryFees, orderStat, customerAddress, customerCity: String?
    let customerCountry, customerStreet, customerCommentsExtra, langtude: String?
    let lattude, paymentMethod, paymentStatus, customerPhone: String?
    let createdAt: String?

    enum CodingKeys: String, CodingKey {
        case orderID = "order_id"
        case orderTotalPrice = "order_total_price"
        case tax
        case deleveryFees = "delevery_fees"
        case orderStat = "order_stat"
        case customerAddress = "customer_address"
        case customerCity = "customer_city"
        case customerCountry = "customer_country"
        case customerStreet = "customer_street"
        case customerCommentsExtra = "customer_comments_extra"
        case langtude, lattude
        case paymentMethod = "payment_method"
        case paymentStatus = "payment_status"
        case customerPhone = "customer_phone"
        case createdAt = "created_at"
    }
}


struct oderListDiteals: Codable {
    let data: [ orderDiteslData]?
    let status: Bool?
    let error: String?
}

struct orderDiteslData: Codable {
    let productID, image, productName, productPrice: String?
    let productQuantity, productTax: String?

    enum CodingKeys: String, CodingKey {
        case productID = "product_id"
        case image
        case productName = "product_name"
        case productPrice = "product_price"
        case productQuantity = "product_quantity"
        case productTax = "product_tax"
    }
}
