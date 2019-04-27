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
    
    var animator: UIDynamicAnimator!
    var attachmentBehavior: UIAttachmentBehavior!
    var snapBehavior: UISnapBehavior!
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLoad()
        let scale = CGAffineTransform(scaleX: 0.5,y: 0.5)
        let translate = CGAffineTransform(translationX: 0, y: -300)
        //может не правильно, надо запомнить
        dialogView.transform = scale.concatenating (translate)
        
        UIView.animate(withDuration: 0.5) {
            let scale = CGAffineTransform(scaleX: 1,y: 1)
            let translate = CGAffineTransform(translationX: 0, y: 0)
            self.dialogView.transform = scale.concatenating (translate)
        }
         
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //set Blur Effect
        addBlurEffect(view: backgroundMaskView, style: .dark)
        addBlurEffect(view: headerView, style: .dark)
        addBlurEffect(view: buttomView, style: .dark)
       
        animator = UIDynamicAnimator(referenceView: view)
        snapBehavior = UISnapBehavior(item: dialogView, snapTo: view.center)
        
    }
  
    
    @IBAction func handleRecognizer(_ sender: Any) {
        let myView = dialogView
        let location = (sender as AnyObject).location(in: view)
        let boxLocation = (sender as AnyObject).location(in: dialogView)
        dialogView.center = location
        
        if (sender as AnyObject).state == UIGestureRecognizer.State.began {
            animator.removeBehavior(snapBehavior)
            //пробую пересторить формулу - разница в swift поколениях
            let centerOffset = UIOffset(horizontal: boxLocation.x - (myView?.bounds.midX)!,
                                        vertical: boxLocation.y - (myView?.bounds.midY)!)
            attachmentBehavior = UIAttachmentBehavior(item: myView!, offsetFromCenter: centerOffset, attachedToAnchor: location)
            attachmentBehavior.frequency = 0
            animator.addBehavior(attachmentBehavior)
        }
        else if (sender as AnyObject).state == UIGestureRecognizer.State.changed {
            attachmentBehavior.anchorPoint = location
        }
        else if (sender as AnyObject).state == UIGestureRecognizer.State.ended {
            animator.removeBehavior(attachmentBehavior)
            snapBehavior = UISnapBehavior(item: myView!, snapTo: view.center)
            animator.addBehavior(snapBehavior )
        }
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
