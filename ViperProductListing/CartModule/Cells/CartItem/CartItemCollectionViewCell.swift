//
//  CartItemCollectionViewCell.swift
//  ViperProductListing
//
//  Created by Mustafa Çağrı Peker on 18.12.2022.
//

import UIKit

class CartItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet var cartColorLabel: UILabel!
    @IBOutlet var cartPriceLabel: UILabel!
    @IBOutlet var cartProductNameLabel: UILabel!
    @IBOutlet var cartImageView: UIImageView!
    
    var parentVC: CartViewController?
    var product: ProductModel?
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.cartImageView.layer.cornerRadius = 8
    }
    
    func prepareCell(product: ProductModel)
    {
        self.cartImageView.image = UIImage(named: product.image_name)
        self.cartProductNameLabel.text = product.name
        self.cartPriceLabel.text = "\(product.price) \(product.currency)"
        self.cartColorLabel.text = product.color
    }
    
    @IBAction func actionDelete(_ sender: Any)
    {
        guard let product = product else {
            return
        }
        self.parentVC?.presenter?.handleAction(output: .removeProductFromCart(product: product))
    }
}
