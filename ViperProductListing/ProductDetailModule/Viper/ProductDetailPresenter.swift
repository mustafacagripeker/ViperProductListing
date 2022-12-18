//
//  ProductDetailPresenter.swift
//  ViperProductListing
//
//  Created by Mustafa Çağrı Peker on 16.12.2022.
//

import Foundation
import UIKit

final class ProductDetailPresenter: ProductDetailPresenterProtocol
{
    var view: ProductDetailVC
    var interactor: ProductDetailInteractor
    var product: ProductModel
    var isFavorited: Bool
    var delegate: HomePageDelegate
    
    init(
        view: ProductDetailVC,
        interactor: ProductDetailInteractor,
        product: ProductModel,
        isFavorited: Bool,
        delegate: HomePageDelegate)
    {
        self.view = view
        self.interactor = interactor
        self.product = product
        self.isFavorited = isFavorited
        self.delegate = delegate
    }
    
    func load() {
        self.view.handleOutput(output: .loadData(
            product: self.product,
            isFavorited: self.isFavorited))
    }
}

extension ProductDetailPresenter
{
    func handleAction(action: ProductDetailPresenterAction) {
        switch action {
        case .addFavorite:
            self.interactor.addFavorite(product: self.product) {
                self.view.handleOutput(output: .loadData(product: self.product, isFavorited: !self.isFavorited))
            }
        case .removeFavorite:
            self.interactor.removeFavorite(product: self.product) {
                self.view.handleOutput(output: .loadData(product: self.product, isFavorited: !self.isFavorited))
            }
        case .addToCart:
            self.interactor.addCart(product: self.product) {
                self.view.handleOutput(output: .showProductAddedBasketAlert)
            }
        case .showAlert:
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "alert") as! AlertViewController
            vc.alertTitle = "Ürün Sepete Eklendi"
            self.view.present(vc, animated: false)
        }
    }
}

