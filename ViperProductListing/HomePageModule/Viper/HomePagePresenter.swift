//
//  HomePagePresenter.swift
//  ViperProductListing
//
//  Created by Mustafa Çağrı Peker on 15.12.2022.
//

import Foundation

final class HomePresenter: HomePresenterProtocol
{
    var view: HomeVC?
    var interactor: HomeInteractor?
    var router: HomeRouter?
    
    func load()
    {
        
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
    func handleOutput() {
        
    }

}

extension HomePresenter
{
    func handleAction(output: HomePresenterActionOutput)
    {
        switch output {
        case .clickCartButton:
            print("asdasd")
        }
    }
}
