//
//  HomePageView.swift
//  ViperProductListing
//
//  Created by Mustafa Çağrı Peker on 15.12.2022.
//

import Foundation
import UIKit

class HomeVC: UIViewController
{
    @IBOutlet var homePageCollectionView: UICollectionView!
    
    var presenter: HomePresenterProtocol!
    
    var products = [ProductModel]()
    
    override func viewDidLoad()
    {
        self.registerCell()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "add_to_cart"), style: .done, target: self, action: #selector(openCart))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.presenter.load()
        self.navigationController?.navigationBar.tintColor = .black
    }
    
    private func registerCell()
    {
        self.homePageCollectionView.register(UINib(
            nibName: "ProductListingItemCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "homeItem")
        self.homePageCollectionView.delegate = self
        self.homePageCollectionView.dataSource = self
    }
    
    @objc func openCart()
    {
        self.presenter.handleAction(output: .clickCartButton)
    }
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let product = self.products[indexPath.row]
        
        guard let cell = homePageCollectionView.dequeueReusableCell(
            withReuseIdentifier: "homeItem", for: indexPath) as? ProductListingItemCollectionViewCell else { return UICollectionViewCell() }
        cell.product = product
        
        if let likedProducts = self.presenter.likedProducts
        {
            cell.isFavorited = likedProducts.contains(where: { item in
                item.id == product.id
            })
        }
        
        cell.prepareCell(product: product)
        
        cell.parentVC = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let itemWidth = (UIScreen.main.bounds.width / 2) - 26
        return CGSize(width: itemWidth , height: itemWidth + 170)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = self.products[indexPath.row]
        var isFavorited = Bool()
        if let likedProducts = self.presenter.likedProducts
        {
            isFavorited = likedProducts.contains(where: { item in item.id == product.id })
        }
        self.presenter.handleAction(output: .openProductDetail(product: product, isFavorited: isFavorited))
    }
}

extension HomeVC: HomeViewProtocol
{
    func handleOutput(output: HomeViewOutput) {
        switch output {
        case .showProducts(let products):
            self.products = products
            self.homePageCollectionView.reloadData()
        case .reloadPage:
            self.presenter.handleAction(output: .getFavoriteProducts)
            self.showAnimation()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.homePageCollectionView.reloadData()
                self.hideAnimation()
            }
        }
    }
}

extension HomeVC: HomePageDelegate
{
    func openOrderConfirmationVC(products: [ProductModel]) {
        self.presenter.handleAction(output: .openOrderConfirmationVC(products: products))
    }
    
    func reloadPage() {
        self.presenter.handleAction(output: .getFavoriteProducts)
        self.showAnimation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.homePageCollectionView.reloadData()
            self.hideAnimation()
        }
    }
}
