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
    func load()
    func handleAction(output: HomePresenterActionOutput)
}

enum HomePresenterActionOutput: Equatable
{
    case clickCartButton
}

// MARK: INTERACTOR

protocol HomeInteractorProtocol: AnyObject
{
    var delegate: HomeInteractorDelegate { get set }
}

protocol HomeInteractorDelegate: AnyObject
{
    func handleOutput()
}

// MARK: ROUTER

protocol HomeRouterProtocol: AnyObject
{
    func route(to: HomeRouterNavigateTo)
}

enum HomeRouterNavigateTo: Equatable
{
    case openDetailVC
    
}

// MARK: VİEW
