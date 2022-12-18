//
//  OrderConfirmationView.swift
//  ViperProductListing
//
//  Created by Mustafa Çağrı Peker on 18.12.2022.
//

import Foundation
import UIKit

class OrderConfirmationView: UIViewController
{
    @IBOutlet var totalPricelABEL: UILabel!
    @IBOutlet var totalProductCountLabel: UILabel!
    
    var presenter: OrderConfirmationPresenter?
    
    override func viewDidLoad()
    {
        self.setUI()
    }
    
    @IBAction func actionClosePage(_ sender: Any)
    {
        self.presenter?.handleAction(output: .clickClosePage)
    }
    
    private func setUI()
    {
        guard let products = self.presenter?.cartProducts else { return }
        let totalPrice = products.map { $0.price }.reduce(0, +)
        self.totalPricelABEL.text = "Toplam Tutar: " + String(format: "%.2f", totalPrice) + "$"
        self.totalProductCountLabel.text = "Ürün Sayısı: \(products.count)"
    }
}

extension OrderConfirmationView: OrderConfirmationViewProtocol
{
    func handleOutput(output: OrderConfirmationViewOutput) {
        switch output {
        case .closePage:
            self.dismiss(animated: false)
        }
    }
}

