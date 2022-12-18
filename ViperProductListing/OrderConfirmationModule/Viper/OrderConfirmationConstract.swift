//
//  OrderConfirmationConstract.swift
//  ViperProductListing
//
//  Created by Mustafa Çağrı Peker on 18.12.2022.
//

import Foundation
// MARK: VİEW

protocol OrderConfirmationViewProtocol: AnyObject
{
    func handleOutput(output: OrderConfirmationViewOutput)
}

enum OrderConfirmationViewOutput: Equatable
{
    static func == (lhs: OrderConfirmationViewOutput, rhs: OrderConfirmationViewOutput) -> Bool {
        true
    }
    
    case closePage
}

// MARK: PRESENTER

protocol OrderConfirmationPresenterProtocol: AnyObject
{
    var view: OrderConfirmationView? {get set}
    var cartProducts: [ProductModel]? {get set}
    func handleAction(output: OrderConfirmationPresenterActionOutput)
}

enum OrderConfirmationPresenterActionOutput: Equatable
{
    case clickClosePage
}

// MARK: ROUTER


protocol OrderConfirmationRouterProtocol: AnyObject
{
    func route(to: CartRouterNavigateTo)
}

enum OrderConfirmationRouterNavigateTo: Equatable
{
    
}
