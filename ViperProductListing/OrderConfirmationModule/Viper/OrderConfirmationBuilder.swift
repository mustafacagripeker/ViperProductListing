//
//  OrderConfirmationBuilder.swift
//  ViperProductListing
//
//  Created by Mustafa Çağrı Peker on 18.12.2022.
//

import Foundation
import UIKit

final class OrderConfirmationBuilder
{
    static func create(products: [ProductModel]) -> OrderConfirmationView
    {
        let view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController (withIdentifier: "orderConfirmation") as! OrderConfirmationView
        let router = OrderConfirmationRouter(view: view)
        
        let presenter = OrderConfirmationPresenter(
            view: view,
            router: router,
            products: products)
        
        view.presenter = presenter
        return view
    }
}
