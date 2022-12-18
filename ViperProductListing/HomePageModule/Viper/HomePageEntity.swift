//
//  HomePageEntity.swift
//  ViperProductListing
//
//  Created by Mustafa Çağrı Peker on 15.12.2022.
//

import Foundation

struct HomeModel: Codable
{
    let products: [ProductModel]
}

struct ProductModel: Codable
{
    let id: Int
    var price: Double
    let name: String
    let category: String
    let currency: String
    let image_name: String
    let color: String
}
