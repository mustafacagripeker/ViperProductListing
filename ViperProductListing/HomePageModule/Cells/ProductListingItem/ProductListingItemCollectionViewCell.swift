//
//  ProductListingItemCollectionViewCell.swift
//  ViperProductListing
//
//  Created by Mustafa Çağrı Peker on 16.12.2022.
//

import UIKit

class ProductListingItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet var productPrice: UILabel!
    @IBOutlet var productNameLabel: UILabel!
    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var addToCartButton: UIButton!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var containerView: UIView!
    
    var parentVC: HomeVC?
    var product: ProductModel?
    var isFavorited: Bool?
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.UISettings()
        
    }
    
    private func UISettings()
    {
        self.addToCartButton.layer.cornerRadius = 6
        self.productImageView.layer.cornerRadius = 10
        self.productImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    func prepareCell(product: ProductModel)
    {
        self.productImageView.image = UIImage(named: product.image_name)
        self.productNameLabel.text = product.name
        self.productPrice.text = "\(product.price) \(product.currency)"
        self.likeButton.setImage(UIImage(named: self.isFavorited ?? false ? "like_button_fill" : "like_button"), for: .normal)
    }
    
    @IBAction func actionLikeButton(_ sender: Any)
    {
        guard let product = self.product else { return }
        self.parentVC?.presenter.handleAction(output: .addFavorite(isFavorited: self.isFavorited ?? false, product: product))
    }
    
    @IBAction func actionAddToCart(_ sender: Any)
    {
        guard let product = self.product else { return }
        self.parentVC?.presenter.handleAction(output: .addCart(product: product))
    }
}

extension UIView {

  func dropShadow(scale: Bool = true) {
    layer.masksToBounds = false
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOpacity = 0.5
    layer.shadowOffset = CGSize(width: -1, height: 1)
    layer.shadowRadius = 1

    layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    layer.shouldRasterize = true
    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
  }

  func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
    layer.masksToBounds = false
    layer.shadowColor = color.cgColor
    layer.shadowOpacity = opacity
    layer.shadowOffset = offSet
    layer.shadowRadius = radius

    layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    layer.shouldRasterize = true
    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
  }
}
