//
//  ProductDetailConstract.swift
//  ViperProductListing
//
//  Created by Mustafa Çağrı Peker on 16.12.2022.
//

import Foundation
import UIKit

protocol HomePageDelegate: AnyObject
{
    func reloadPage()
    func openOrderConfirmationVC(products: [ProductModel])
}

// MARK: PRESENTER

protocol ProductDetailPresenterProtocol
{
    var view: ProductDetailVC { get set }
    var delegate: HomePageDelegate { get set }
    func load()
    func handleAction(action: ProductDetailPresenterAction)
}

enum ProductDetailPresenterAction: Equatable
{
    static func == (lhs: ProductDetailPresenterAction, rhs: ProductDetailPresenterAction) -> Bool {
        true
    }
    
    case addFavorite
    case addToCart
    case removeFavorite
    case showAlert
}

// MARK: VİEW

protocol ProductDetailVCProtocol
{
    func handleOutput(output: ProductDetailVCOutput)
}

enum ProductDetailVCOutput: Equatable
{
    static func == (lhs: ProductDetailVCOutput, rhs: ProductDetailVCOutput) -> Bool {
        true
    }
    
    case loadData(product: ProductModel, isFavorited: Bool)
    case showProductAddedBasketAlert
}

// MARK: INTERACTOR

protocol ProductDetailInteractorProtocol
{
    var delegate: ProductDetailInteractorDelegate? { get set }
}

protocol ProductDetailInteractorDelegate: AnyObject
{
    func handleOutput(output: ProductDetailInteractorOutput)
}

enum ProductDetailInteractorOutput: Equatable
{
    static func == (lhs: ProductDetailInteractorOutput, rhs: ProductDetailInteractorOutput) -> Bool {
        true
    }
    
    case reloadPage
}
