//
//  CartInteractor.swift
//  ViperProductListing
//
//  Created by Mustafa Çağrı Peker on 18.12.2022.
//

import Foundation

final class CartInteractor
{
    weak var delegate: CartInteractorDelegate?
    
    func fetchCartProducts()
    {
        let cartProducts = self.getCartProducts()
        self.delegate?.handleOutput(output: .loadData(products: cartProducts))
    }
    
    func getCartProducts() -> [ProductModel]
    {
        guard let cartProducts = UserDefaults.standard.data(forKey: "cart_products") else
        {
            return []
        }
        let cartProductsArray = try! JSONDecoder().decode([ProductModel].self, from: cartProducts)
       return cartProductsArray
    }
    
    func removeProductFromCart(product: ProductModel, completion: @escaping () -> () )
    {
        var cartProducts = self.getCartProducts()
        if let index = cartProducts.firstIndex(where: { $0.id == product.id })
        {
            cartProducts.remove(at: index)
        }
        let likedData = try! JSONEncoder().encode(cartProducts)
        UserDefaults.standard.set(likedData, forKey: "cart_products")
        UserDefaults.standard.synchronize()
        DispatchQueue.main.async {
            completion()
        }
    }
    
    func addCart(product: ProductModel, completion: @escaping () -> () )
    {
        var cartProducts = self.getCartProducts()
        cartProducts.append(product)
        let likedData = try! JSONEncoder().encode(cartProducts)
        UserDefaults.standard.set(likedData, forKey: "cart_products")
        UserDefaults.standard.synchronize()
        DispatchQueue.main.async {
            completion()
        }
    }
}
