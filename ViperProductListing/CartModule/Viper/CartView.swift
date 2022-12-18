//
//  CartView.swift
//  ViperProductListing
//
//  Created by Mustafa Çağrı Peker on 18.12.2022.
//

import Foundation
import UIKit

class CartViewController: UIViewController
{
    @IBOutlet var cartCollectionView: UICollectionView!
    @IBOutlet var emptyDataLabel: UILabel!
    @IBOutlet var productTotalPriceLabel: UILabel!
    @IBOutlet var productCount: UILabel!
    @IBOutlet var checkOutButton: UIButton!
    var presenter: CartPresenter?
    var products = [ProductModel]()
    
    override func viewDidLoad()
    {
        self.registerCell()
        self.presenter?.load()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if products.isEmpty
        {
            self.checkOutButton.isUserInteractionEnabled = false
            self.checkOutButton.backgroundColor = .gray
            self.productCount.isHidden = true
            self.productTotalPriceLabel.isHidden = true
        }
        else
        {
            self.checkOutButton.isUserInteractionEnabled = true
            self.checkOutButton.backgroundColor = .orange
            self.productCount.isHidden = false
            self.productTotalPriceLabel.isHidden = false
        }
    }
    
    private func registerCell()
    {
        self.cartCollectionView.register(UINib(
            nibName: "CartItemCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "cartItem")
        self.cartCollectionView.delegate = self
        self.cartCollectionView.dataSource = self
    }
    
    @IBAction func actionCheckout(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: false)
        self.presenter?.delegate.openOrderConfirmationVC(products: self.products)
    }
}

extension CartViewController: CartViewProtocol
{
    func handleOutput(output: CartViewOutput)
    {
        switch output
        {
        case .showProducts(let products):
            self.products = products
            self.productCount.text = "Toplam Ürün Sayısı: \(products.count)"
            let totalPrice = products.map { $0.price }.reduce(0, +)
            self.productTotalPriceLabel.text = "Toplam Tutar: " + String(format: "%.2f", totalPrice) + "$"
            self.cartCollectionView.reloadData()
        case .dismissPage:
            self.navigationController?.popViewController(animated: false)
        }
    }  
}

extension CartViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.products.isEmpty
        {
            self.emptyDataLabel.isHidden = false
        }
        else
        {
            self.emptyDataLabel.isHidden = true
        }
        return self.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
 
        guard let cell = cartCollectionView.dequeueReusableCell(
            withReuseIdentifier: "cartItem", for: indexPath) as? CartItemCollectionViewCell else { return UICollectionViewCell() }
        let product = self.products[indexPath.row]
        cell.prepareCell(product: product)
        cell.parentVC = self
        cell.product = product
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: UIScreen.main.bounds.width , height: 132)
    }
}
