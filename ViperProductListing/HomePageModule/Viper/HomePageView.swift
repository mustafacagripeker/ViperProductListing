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
    
    override func viewDidLoad()
    {
        self.registerCell()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "add_to_cart"), style: .done, target: self, action: #selector(openCart))
        self.presenter.load()
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
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        guard let cell = homePageCollectionView.dequeueReusableCell(
            withReuseIdentifier: "homeItem", for: indexPath) as? ProductListingItemCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let itemWidth = (UIScreen.main.bounds.width / 2) - 20
        
        return CGSize(width: itemWidth , height: itemWidth + 130)
    }
    
    
}
