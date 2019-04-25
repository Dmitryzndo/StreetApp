//
//  MenuViewController.swift
//  StreetApp
//
//  Created by Dmitry Belousov on 25/04/2019.
//  Copyright © 2019 Dmitry Belousov. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    
    @IBOutlet weak var backgroundMaskView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var buttomView: UIView!
    @IBOutlet weak var userView: UIView!
    @IBOutlet weak var dialogView: UIView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //set Blur Effect
        addBlurEffect(view: backgroundMaskView, style: .dark)
        addBlurEffect(view: headerView, style: .dark)
        addBlurEffect(view: buttomView, style: .dark)
    }
  
    func addBlurEffect  (view: UIView, style: UIBlurEffect.Style) {
        
        view.backgroundColor = UIColor.clear
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        view.insertSubview(blurEffectView, at: 0)
        
        
    }
   
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
