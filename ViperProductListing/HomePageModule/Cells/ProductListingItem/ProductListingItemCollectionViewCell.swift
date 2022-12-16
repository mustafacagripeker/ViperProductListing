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
    @IBAction func actionLikeButton(_ sender: Any)
    {
        
    }
    
    @IBAction func actionAddToCart(_ sender: Any)
    {
        
    }
}
