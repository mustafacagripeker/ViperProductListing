//
//  ProductService.swift
//  ViperProductListing
//
//  Created by Mustafa Çağrı Peker on 16.12.2022.
//

import Foundation
import Alamofire

class ProductService
{
    static var shared : ProductService{
        return ProductService()
    }
    fileprivate init(){}
    
    func getProductList(completion : @escaping ([ProductModel]? , Bool)-> Void ){
        
        AF.request("https://www.momentup.com/challange/ProductsWithFilter.json")
            .validate()
            .responseDecodable(of: HomeModel.self) { (response) in
                guard let products = response.value?.products else {
                    completion(nil,false)
                    return
                }
                completion(products, true)
            }
    }
}
