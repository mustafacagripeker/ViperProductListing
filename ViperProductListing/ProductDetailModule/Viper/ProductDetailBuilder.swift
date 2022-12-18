//
//  ProductDetailBuilder.swift
//  ViperProductListing
//
//  Created by Mustafa Çağrı Peker on 16.12.2022.
//

import Foundation
import UIKit

final class ProductDetailBuilder
{
    static func create(product: ProductModel, isFavorited: Bool, delegate: HomePageDelegate) -> ProductDetailVC
    {
        let view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController (withIdentifier: "productDetailPage") as! ProductDetailVC
        let interactor = ProductDetailInteractor()
        
        let presenter = ProductDetailPresenter(
            view: view,
            interactor: interactor,
            product: product,
            isFavorited: isFavorited,
            delegate: delegate)
        
        view.presenter = presenter
        return view
    }
}
