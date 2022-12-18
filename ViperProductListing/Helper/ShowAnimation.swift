//
//  ShowAnimation.swift
//  ViperProductListing
//
//  Created by Mustafa Çağrı Peker on 16.12.2022.
//

import Foundation
import UIKit
import Lottie


fileprivate var mainView : UIView?


extension UIViewController{
    
    func showAnimation(){
        mainView = UIView(frame: self.view.bounds)
        
        let animationView = LottieAnimationView(name: "loader_animation")
        animationView.frame = CGRect(x: ((mainView?.frame.width)!)/2-50 , y: ((mainView?.frame.height)!)/2-50, width: 100, height: 100)
        animationView.loopMode = .loop
        animationView.play()
        mainView?.addSubview(animationView)
        mainView?.backgroundColor = UIColor(named: "blur")
        self.view.addSubview(mainView!)
    }
    
    func hideAnimation(){
        mainView?.removeFromSuperview()
        mainView = nil
    }
}
