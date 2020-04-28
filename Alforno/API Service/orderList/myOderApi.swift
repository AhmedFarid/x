//
//  myOderApi.swift
//  Alforno
//
//  Created by Ahmed farid on 3/8/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation
import Alamofire

class myOrderApi: NSObject {
    class func myOrders(completion: @escaping(_ error: Error?,_ networkSuccess: Bool,_ codeSucess: Bool ,_ myOrder: oderList?)-> Void){
        
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
        
        let url = URLs.orderList
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
                    let myOrder = try JSONDecoder().decode(oderList.self, from: response.data!)
                    if myOrder.status == false {
                        completion(nil,true,true,myOrder)
                    }else {
                        completion(nil,true,true,myOrder)
                    }
                }catch{
                    print("error")
                    completion(nil,true,false,nil)
                }
            }
        }
    }
    
    class func myOrdersDitelse(order_id: String,completion: @escaping(_ error: Error?,_ networkSuccess: Bool,_ codeSucess: Bool ,_ myOrder: oderListDiteals?)-> Void){
        
        guard let user_token = helperLogin.getAPIToken() else {
            completion(nil, false,false,nil)
            return
        }
        
        let parametars = [
            "lang": "en",
            "order_id": order_id
        ]
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(user_token)"
        ]
        
        let url = URLs.orderListDetails
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
                    let myOrder = try JSONDecoder().decode(oderListDiteals.self, from: response.data!)
                    if myOrder.status == false {
                        completion(nil,true,true,myOrder)
                    }else {
                        completion(nil,true,true,myOrder)
                    }
                }catch{
                    print("error")
                    completion(nil,true,false,nil)
                }
            }
        }
    }
}
