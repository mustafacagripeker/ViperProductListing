//
//  OrderConfirmationPresenter.swift
//  ViperProductListing
//
//  Created by Mustafa Çağrı Peker on 18.12.2022.
//

import Foundation

final class OrderConfirmationPresenter
{
    var view: OrderConfirmationView?
    var router: OrderConfirmationRouter
    var cartProducts: [ProductModel]?
    
    init(
        view: OrderConfirmationView,
        router: OrderConfirmationRouter,
        products: [ProductModel])
    {
        self.view = view
        self.router = router
        self.cartProducts = products
    }
    
    private func closePage(completion: @escaping ()->())
    {
        UserDefaults.standard.set([], forKey: "cart_products")
        UserDefaults.standard.set([], forKey: "liked_products")
        completion()
    }
}

extension OrderConfirmationPresenter: OrderConfirmationPresenterProtocol
{
    func handleAction(output: OrderConfirmationPresenterActionOutput) {
        switch output {
        case .clickClosePage:
            self.closePage {
                self.view?.handleOutput(output: .closePage)
            }
        }
    }
}
