//
//  HomePageBuilder.swift
//  ViperProductListing
//
//  Created by Mustafa Çağrı Peker on 15.12.2022.
//

import Foundation
import UIKit

final class HomeBuilder
{
    static func create() -> HomeVC
    {
        let view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController (withIdentifier: "home") as! HomeVC
        let interactor = HomeInteractor()
        let router = HomeRouter(view: view)
        
        let presenter = HomePresenter(
            view: view,
            interactor: interactor,
            router: router)
        
        view.presenter = presenter

        return view
    }
}
