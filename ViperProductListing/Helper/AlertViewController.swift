//
//  AlertViewController.swift
//  ViperProductListing
//
//  Created by Mustafa Çağrı Peker on 18.12.2022.
//

import UIKit

class AlertViewController: UIViewController {

    @IBOutlet var containerView: UIView!
    @IBOutlet var alertLabel: UILabel!
    
    var alertTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.containerView.layer.cornerRadius = 10
        self.alertLabel.text = alertTitle
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.dismiss(animated: false)
        }
    }
}
