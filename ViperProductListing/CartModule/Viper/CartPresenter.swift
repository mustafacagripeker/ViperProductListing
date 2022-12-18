//
//  CartPresenter.swift
//  ViperProductListing
//
//  Created by Mustafa Çağrı Peker on 18.12.2022.
//

import Foundation

final class CartPresenter: CartPresenterProtocol
{
    var view: CartViewController?
    var interactor: CartInteractor
    var delegate: HomePageDelegate
    var router: CartRouter
    
    var cartProducts: [ProductModel]?
    
    init(
        view: CartViewController,
        interactor: CartInteractor,
        delegate: HomePageDelegate,
        router: CartRouter)
    {
        self.view = view
        self.interactor = interactor
        self.delegate = delegate
        self.router = router
        self.interactor.delegate = self
    }
    
    func load() {
        self.cartProducts = interactor.getCartProducts()
        self.interactor.fetchCartProducts()
    }
    
    func handleAction(output: CartPresenterActionOutput) {
        switch output
        {
        case .clickCheckout:
            guard let cartProducts = cartProducts else {return}
            self.view?.dismiss(animated: true, completion: {
                
            })
        case .removeProductFromCart(let product):
            self.interactor.removeProductFromCart(product: product) {
                self.interactor.fetchCartProducts()
            }
        }
    }
}

extension CartPresenter: CartInteractorDelegate
{
    func handleOutput(output: CartInteractorOutput) {
        switch output
        {
        case .loadData(let products):
            self.view?.handleOutput(output: .showProducts(products: products))
        }
    }
}

extension CartPresenter: CartPageDismissDelegate
{
    func dismissPage() {
        self.view?.handleOutput(output: .dismissPage)
    }
}
