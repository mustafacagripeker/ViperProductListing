//
//  HomePageInteractor.swift
//  ViperProductListing
//
//  Created by Mustafa Çağrı Peker on 15.12.2022.
//

import Foundation
import SwiftUI

final class HomeInteractor: HomeInteractorProtocol
{
    weak var delegate: HomeInteractorDelegate?
    
    func getProducts()
    {
        ProductService.shared.getProductList { products, isSuccess in
            if isSuccess
            {
                self.delegate?.handleOutput(output: .loadData(response: products ?? []))
            }
        }
    }
    
    func getLikedProducts() -> [ProductModel]
    {
        guard let likedProducts = UserDefaults.standard.data(forKey: "liked_products") else { return [] }
        let likedProductsArray = try! JSONDecoder().decode([ProductModel].self, from: likedProducts)
        return likedProductsArray
    }
    
    func getCartProduct() -> [ProductModel]
    {
        guard let cartProducts = UserDefaults.standard.data(forKey: "cart_products") else { return [] }
        let cartProductsArray = try! JSONDecoder().decode([ProductModel].self, from: cartProducts)
        return cartProductsArray
    }
    
    func addCart(product: ProductModel, completion: @escaping ()->())
    {
        var cartProducts = self.getCartProduct()
        cartProducts.append(product)
        let cartData = try! JSONEncoder().encode(cartProducts)
        UserDefaults.standard.set(cartData, forKey: "cart_products")
        UserDefaults.standard.synchronize()
        DispatchQueue.main.async {
            completion()
        }
    }
    
    func addFavorites(product: ProductModel,  completion: @escaping () -> () )
    {
        
        var likedProducts = self.getLikedProducts()
        likedProducts.append(product)
        let likedData = try! JSONEncoder().encode(likedProducts)
        UserDefaults.standard.set(likedData, forKey: "liked_products")
        UserDefaults.standard.synchronize()
        DispatchQueue.main.async {
            completion()
        }
    }
    
    func removeFavorites(product: ProductModel, completion: @escaping () -> () )
    {
        var likedProducts = self.getLikedProducts()
        if let index = likedProducts.firstIndex(where: { $0.id == product.id })
        {
            likedProducts.remove(at: index)
        }
        let likedData = try! JSONEncoder().encode(likedProducts)
        UserDefaults.standard.set(likedData, forKey: "liked_products")
        UserDefaults.standard.synchronize()
        DispatchQueue.main.async {
            completion()
        }
    }
}
