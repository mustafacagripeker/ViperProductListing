//
//  CartConstract.swift
//  ViperProductListing
//
//  Created by Mustafa Çağrı Peker on 18.12.2022.
//

import Foundation

// MARK: INTERACTOR
protocol CartInteractorDelegate: AnyObject
{
    func handleOutput(output: CartInteractorOutput)
}

enum CartInteractorOutput: Equatable
{
    static func == (lhs: CartInteractorOutput, rhs: CartInteractorOutput) -> Bool {
        true
    }
    
    case loadData(products: [ProductModel])
}


// MARK: VİEW

protocol CartViewProtocol: AnyObject
{
    func handleOutput(output: CartViewOutput)
}

enum CartViewOutput: Equatable
{
    static func == (lhs: CartViewOutput, rhs: CartViewOutput) -> Bool {
        true
    }
    
    case showProducts(products: [ProductModel])
    case dismissPage
}

// MARK: PRESENTER

protocol CartPresenterProtocol: AnyObject
{
    var view: CartViewController? {get set}
    var cartProducts: [ProductModel]? {get set}
    func load()
    func handleAction(output: CartPresenterActionOutput)
}

enum CartPresenterActionOutput: Equatable
{
    static func == (lhs: CartPresenterActionOutput, rhs: CartPresenterActionOutput) -> Bool {
        true
    }
    
    case clickCheckout
    case removeProductFromCart(product: ProductModel)
}

// MARK: ROUTER

protocol CartRouterProtocol: AnyObject
{
    func route(to: CartRouterNavigateTo)
}

enum CartRouterNavigateTo: Equatable
{
    static func == (lhs: CartRouterNavigateTo, rhs: CartRouterNavigateTo) -> Bool {
        true
    }
    
    case openOrderConfirmation(products: [ProductModel], delegate: CartPageDismissDelegate)
}

protocol CartPageDismissDelegate: AnyObject
{
    func dismissPage()
}
