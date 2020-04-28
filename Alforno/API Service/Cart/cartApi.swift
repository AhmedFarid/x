//
//  cartApi.swift
//  Alforno
//
//  Created by Ahmed farid on 3/4/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation
import Alamofire

class cartApi: NSObject {
    
    class func addCarts(product_id: String,product_quantity: String,size_id: String,addition_id: String, completion: @escaping(_ error: Error?,_ success: Bool,_ message: messages?)-> Void){
        
        guard let user_token = helperLogin.getAPIToken() else {
            completion(nil, false,nil)
            return
        }
        
        let parametars = [
            "product_id": product_id,
            "product_quantity": product_quantity,
            "size_id": size_id,
            "addition_id": addition_id
            ] as [String : Any]
        
        
        
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Authorization": "Bearer \(user_token)"
        ]
        
        let url = URLs.addCart
        print(url)
        print(parametars)
        
        AF.request(url, method: .post, parameters: parametars, encoding: URLEncoding.queryString, headers: headers).responseJSON{ (response) in
            switch response.result
            {
            case .failure(let error):
                completion(error, false,nil)
                print(error)
            case .success:
                do{
                    print(response)
                    let message = try JSONDecoder().decode(messages.self, from: response.data!)
                    if message.status == false {
                        completion(nil,true,message)
                    }else {
                        completion(nil,true,message)
                    }
                }catch{
                    print("error")
                }
            }
        }
    }
    
    class func listOfCart(completion: @escaping(_ error: Error?,_ networkSuccess: Bool,_ codeSucess: Bool ,_ cart: carts?)-> Void){
        
        guard let user_token = helperLogin.getAPIToken() else {
            completion(nil, false,false,nil)
            return
        }
        
        let parametars = [
            "lang": "en"
        ]
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(user_token)"
        ]
        
        let url = URLs.listDataCart
        print(url)
        print(parametars)
        AF.request(url, method: .post, parameters: parametars, encoding: URLEncoding.default, headers: headers).responseJSON{ (response) in
            switch response.result
            {
            case .failure(let error):
                completion(error, false,false,nil)
                print(error)
            case .success:
                do{
                    print(response)
                    let cart = try JSONDecoder().decode(carts.self, from: response.data!)
                    if cart.status == false {
                        completion(nil,true,true,cart)
                    }else {
                        completion(nil,true,true,cart)
                    }
                }catch{
                    print("error")
                    completion(nil,true,false,nil)
                }
            }
        }
    }
     
    class func listCartAddtional(Url: String,product_id: String,order_id: String,cart_id: String,completion: @escaping(_ error: Error?,_ networkSuccess: Bool,_ codeSucess: Bool ,_ cart: Offers?)-> Void){
        
        guard let user_token = helperLogin.getAPIToken() else {
            completion(nil, false,false,nil)
            return
        }
        
        let parametars = [
            "lang": "en",
            "cart_id": cart_id,
            "order_id": order_id,
            "product_id": product_id
        ]
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(user_token)"
        ]
        
        print(parametars)
        AF.request(Url, method: .post, parameters: parametars, encoding: URLEncoding.default, headers: headers).responseJSON{ (response) in
            switch response.result
            {
            case .failure(let error):
                completion(error, false,false,nil)
                print(error)
            case .success:
                do{
                    print(response)
                    let cart = try JSONDecoder().decode(Offers.self, from: response.data!)
                    if cart.status == false {
                        completion(nil,true,true,cart)
                    }else {
                        completion(nil,true,true,cart)
                    }
                }catch{
                    print("error")
                    completion(nil,true,false,nil)
                }
            }
        }
    }
    
    class func optionCarts(url: String,cart_id: String, completion: @escaping(_ error: Error?,_ success: Bool,_ message: messages?)-> Void){
        
        guard let user_token = helperLogin.getAPIToken() else {
            completion(nil, false,nil)
            return
        }
        
        let parametars = [
            "cart_id": cart_id
            ] as [String : Any]
        
        
        
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Authorization": "Bearer \(user_token)"
        ]
        
        //let url = URLs.plusQuentityCart
        print(url)
        print(parametars)
        
        AF.request(url, method: .post, parameters: parametars, encoding: URLEncoding.queryString, headers: headers).responseJSON{ (response) in
            switch response.result
            {
            case .failure(let error):
                completion(error, false,nil)
                print(error)
            case .success:
                do{
                    print(response)
                    let message = try JSONDecoder().decode(messages.self, from: response.data!)
                    if message.status == false {
                        completion(nil,true,message)
                    }else {
                        completion(nil,true,message)
                    }
                }catch{
                    print("error")
                }
            }
        }
    }
    
    class func createOreder(order_totalPrice: String,customerAddress: String,customerPhone: String,customerCity: String,customerStreet: String,customerAppartmentNumber: String,customerFloorNumber: String,customerHomeNumber: String,customerCommentsExtra: String,customerCountry: String,completion: @escaping(_ error: Error?,_ success: Bool,_ message: messages?)-> Void){
        
        guard let user_token = helperLogin.getAPIToken() else {
            completion(nil, false,nil)
            return
        }
        
        
        let parametars = [
            "order_total_price": order_totalPrice,
            "customer_address": customerAddress,
            "customer_phone": customerPhone,
            "customer_city": customerCity,
            "customer_street": customerStreet,
            "customer_appartment_number": customerAppartmentNumber,
            "customer_floor_number": customerFloorNumber,
            "customer_home_number":customerHomeNumber,
            "customer_comments_extra": customerCommentsExtra,
            "customer_country": customerCountry,
            "langtude": "0.0",
            "lattude": "0.0",
            "payment_method": "1",
            "payment_status": "1",
            "customer_postal_code": "1",
            "customer_region": "111"
            ] as [String : Any]

        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Authorization": "Bearer \(user_token)"
        ]
        
        let url = URLs.createOrder
        print(url)
        print(parametars)
        
        AF.request(url, method: .post, parameters: parametars, encoding: URLEncoding.queryString, headers: headers).responseJSON{ (response) in
            switch response.result
            {
            case .failure(let error):
                completion(error, false,nil)
                print(error)
            case .success:
                do{
                    print(response)
                    let message = try JSONDecoder().decode(messages.self, from: response.data!)
                    if message.status == false {
                        completion(nil,true,message)
                    }else {
                        completion(nil,true,message)
                    }
                }catch{
                    print("error")
                }
            }
        }
    }
}
