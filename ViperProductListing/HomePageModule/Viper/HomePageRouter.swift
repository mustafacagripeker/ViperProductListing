//
//  HomePageRouter.swift
//  ViperProductListing
//
//  Created by Mustafa Çağrı Peker on 15.12.2022.
//

import Foundation

final class HomeRouter: HomeRouterProtocol
{
    let view: HomeVC
    
    init(view: HomeVC)
    {
        self.view = view
    }
    
    func route(to: HomeRouterNavigateTo)
    {
        switch to {
        case .openDetailVC(let product, let isFavorited):
            self.openProductDetailPage(product: product, isFavorited: isFavorited)
        case .openCart:
            self.openCartVC()
        case .openOrderConfirmation(let products):
            self.openOrderConfirmation(products: products)
        }
    }
    
    private func openCartVC()
    {
        let vc = CartBuilder.create(delegate: self.view as HomePageDelegate)
        self.view.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func openOrderConfirmation(products: [ProductModel])
    {
        let vc = OrderConfirmationBuilder.create(products: products)
        self.view.present(vc, animated: true)
    }
    
    private func openProductDetailPage(
        product: ProductModel,
        isFavorited: Bool)
    {
        let vc = ProductDetailBuilder.create(
            product: product,
            isFavorited: isFavorited,
            delegate: self.view as HomePageDelegate
        )
        
        self.view.navigationController?.pushViewController(vc, animated: true)
    }
}
