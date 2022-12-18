//
//  HomeContracts.swift
//  ViperProductListing
//
//  Created by Mustafa Çağrı Peker on 16.12.2022.
//

import Foundation


// MARK: PRESENTER

protocol HomePresenterProtocol: AnyObject
{
    var view: HomeVC? {get set}
    var likedProducts: [ProductModel]? { get set }
    func load()
    func handleAction(output: HomePresenterActionOutput)
}

enum HomePresenterActionOutput: Equatable
{
    static func == (lhs: HomePresenterActionOutput, rhs: HomePresenterActionOutput) -> Bool {
        true
    }
    
    case clickCartButton
    case addCart(product: ProductModel)
    case addFavorite(isFavorited: Bool, product: ProductModel)
    case getFavoriteProducts
    case openProductDetail(product: ProductModel, isFavorited: Bool)
    case openOrderConfirmationVC(products: [ProductModel])
}

// MARK: INTERACTOR

protocol HomeInteractorProtocol: AnyObject
{
    var delegate: HomeInteractorDelegate? { get set }
    func getProducts()
}

protocol HomeInteractorDelegate: AnyObject
{
    func handleOutput(output: HomeInteractorOutput)
}

enum HomeInteractorOutput: Equatable
{
    static func == (lhs: HomeInteractorOutput, rhs: HomeInteractorOutput) -> Bool {
        true
    }
    
    case loadData(response: [ProductModel])
    case reloadPage
}

// MARK: ROUTER

protocol HomeRouterProtocol: AnyObject
{
    func route(to: HomeRouterNavigateTo)
}

enum HomeRouterNavigateTo: Equatable
{
    static func == (lhs: HomeRouterNavigateTo, rhs: HomeRouterNavigateTo) -> Bool {
        true
    }
    
    case openDetailVC(product: ProductModel, isFavorited: Bool)
    case openCart
    case openOrderConfirmation(products: [ProductModel])
}

// MARK: VİEW

protocol HomeViewProtocol: AnyObject
{
    func handleOutput(output: HomeViewOutput)
}

enum HomeViewOutput: Equatable
{
    static func == (lhs: HomeViewOutput, rhs: HomeViewOutput) -> Bool {
        true
    }
    
    case showProducts(products: [ProductModel])
    case reloadPage
}
