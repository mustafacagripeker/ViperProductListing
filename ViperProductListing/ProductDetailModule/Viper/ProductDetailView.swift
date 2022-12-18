//
//  ProductDetailView.swift
//  ViperProductListing
//
//  Created by Mustafa Çağrı Peker on 16.12.2022.
//

import Foundation
import UIKit

class ProductDetailVC: UIViewController
{
    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var productNameLabel: UILabel!
    @IBOutlet var productPriceLabel: UILabel!
    @IBOutlet var productColor: UILabel!
    @IBOutlet var productCategory: UILabel!
    @IBOutlet var addToCartButton: UIButton!
    
    var presenter: ProductDetailPresenter?
    
    override func viewDidLoad() {
        self.presenter?.load()
        self.setUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.presenter?.delegate.reloadPage()
    }
    
    private func setUI()
    {
        self.productImageView.layer.cornerRadius = 10
        self.addToCartButton.layer.cornerRadius = 8
        
        self.navigationItem.title = "\(self.presenter?.product.name ?? "")"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Helvetica Neue", size: 14)!]
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(
            named: self.presenter?.isFavorited ?? false ? "like_button_fill" : "like_button")
                                                                 , style: .done, target: self, action: #selector(addOrRemoveFavorites))
    }
    
    @IBAction func actionAddToCart(_ sender: Any)
    {
        self.presenter?.handleAction(action: .addToCart)
    }
    
    @objc func addOrRemoveFavorites()
    {
        guard let isFavorited = self.presenter?.isFavorited,
              isFavorited else {
            self.presenter?.handleAction(action: .addFavorite)
            return
        }
        
        self.presenter?.handleAction(action: .removeFavorite)
    }
    
}

extension ProductDetailVC: ProductDetailVCProtocol
{
    func handleOutput(output: ProductDetailVCOutput)
    {
        switch output
        {
        case .loadData(let product, let isFavorited):
            self.showDate(
                product: product,
                isFavorited: isFavorited)
        case .showProductAddedBasketAlert:
            self.presenter?.handleAction(action: .showAlert)
        }
    }
    
    private func showDate(
        product: ProductModel,
        isFavorited: Bool)
    {
        self.showAnimation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.productImageView.image = UIImage(named: product.image_name)
            self.productNameLabel.text = product.name
            self.productPriceLabel.text = "\(product.price) \(product.currency)"
            self.productColor.text = "Renk: \(product.color)"
            self.productCategory.text = "Ürün Kategorisi: \(product.category)"
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(
                named: isFavorited ? "like_button_fill" : "like_button")
                                                                     , style: .done, target: self, action: #selector(self.addOrRemoveFavorites))
            self.hideAnimation()
        }
    }
}
