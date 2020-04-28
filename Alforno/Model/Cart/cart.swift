//
//  cart.swift
//  Alforno
//
//  Created by Ahmed farid on 3/4/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation


struct carts: Codable {
    let data: dataCart?
    let status: Bool?
    let error: String?
}

struct dataCart: Codable {
    let list: [listCart]?
    let totalTax: Int?
    let totalDeleveryFees: String?
    let price: Int?

    enum CodingKeys: String, CodingKey {
        case list
        case totalTax = "total_tax"
        case totalDeleveryFees = "total_delevery_fees"
        case price
    }
}

struct listCart: Codable {
    let cartID: Int?
    let productID, size, productName, shortDescription: String?
    let listDescription, quantity, image, unitPrice: String?
    let totalUnitPrice: Int?
    let totalPriceWithAddtions, currency: String?

    enum CodingKeys: String, CodingKey {
        case cartID = "cart_id"
        case productID = "product_id"
        case size
        case productName = "product_name"
        case shortDescription = "short_description"
        case listDescription = "description"
        case quantity, image
        case unitPrice = "unit_price"
        case totalUnitPrice = "total_unit_price"
        case totalPriceWithAddtions = "total_price_with_addtions"
        case currency
    }
}



