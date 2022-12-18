//
//  HomePagePresenter.swift
//  ViperProductListing
//
//  Created by Mustafa Çağrı Peker on 15.12.2022.
//

import Foundation
import UIKit

final class HomePresenter: HomePresenterProtocol
{
    var view: HomeVC?
    var interactor: HomeInteractor?
    var router: HomeRouter?
    var likedProducts: [ProductModel]?
    
    func load()
    {
        self.interactor?.getProducts()
    }
    
    init(view: HomeVC,
         interactor: HomeInteractor,
         router: HomeRouter)
    {
        self.view = view
        self.interactor = interactor
        self.interactor?.delegate = self
        self.router = router
    }
}

extension HomePresenter: HomeInteractorDelegate
{
    func handleOutput(output: HomeInteractorOutput) {
        switch output {
        case .loadData(let response):
            self.view?.handleOutput(output: .showProducts(products: response))
            self.likedProducts = self.interactor?.getLikedProducts()
        case .reloadPage:
            self.view?.handleOutput(output: .reloadPage)
        }
    }
}

extension HomePresenter
{
    func handleAction(output: HomePresenterActionOutput)
    {
        switch output {
        case .clickCartButton:
            self.router?.route(to: .openCart)
        case .addFavorite(let isFavorited, let product):
            if isFavorited
            {
                self.interactor?.removeFavorites(
                    product: product,
                    completion: {
                    self.handleOutput(output: .reloadPage)
                })
            }
            else
            {
                self.interactor?.addFavorites(
                    product: product,
                    completion: {
                    self.handleOutput(output: .reloadPage)
                })
            }
        case .getFavoriteProducts:
            self.likedProducts = self.interactor?.getLikedProducts()
        case .openProductDetail(let product, let isFavorited):
            self.router?.route(to: .openDetailVC(product: product, isFavorited: isFavorited))
        case .addCart(let product):
            self.interactor?.addCart(product: product, completion: {
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "alert") as! AlertViewController
                vc.alertTitle = "Ürün Sepete Eklendi"
                self.view?.present(vc, animated: false)
            })
        case .openOrderConfirmationVC(let products):
            self.router?.route(to: .openOrderConfirmation(products: products))
        }
    }
}
