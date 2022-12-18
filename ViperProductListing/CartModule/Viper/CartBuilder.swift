//
//  CartBuilder.swift
//  ViperProductListing
//
//  Created by Mustafa Çağrı Peker on 18.12.2022.
//

import Foundation
import UIKit

final class CartBuilder
{
    static func create(delegate: HomePageDelegate) -> CartViewController
    {
        let view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController (withIdentifier: "cartVC") as! CartViewController
        let interactor = CartInteractor()
        let router = CartRouter(view: view)
        
        let presenter = CartPresenter(
            view: view,
            interactor: interactor,
            delegate: delegate,
            router: router)
        
        view.presenter = presenter
        return view
    }
}
