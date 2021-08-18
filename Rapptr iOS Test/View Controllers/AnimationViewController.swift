//
//  AnimationViewController.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit

class AnimationViewController: UIViewController {
    
    
    var panGesture =  UIPanGestureRecognizer()
  
    @IBOutlet weak var imageLogoView: UIImageView!
    
   var isFadeIn = false
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Animation"
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(draggedView(_:)))
        imageLogoView.isUserInteractionEnabled = true
        imageLogoView.addGestureRecognizer(panGesture)
        imageLogoView.fadeOut()

        
    }
    
    // MARK: - Actions
    @IBAction func backAction(_ sender: Any) {
        let mainMenuViewController = MenuViewController()
        self.navigationController?.pushViewController(mainMenuViewController, animated: true)
    }
    
    @IBAction func didPressFade(_ sender: Any) {
        if isFadeIn{
            imageLogoView.fadeOut()
            isFadeIn = false
        }
        else{
            imageLogoView.fadeIn()
            isFadeIn = true
        }
        
    }
    
    @objc func draggedView(_ sender:UIPanGestureRecognizer){
            self.view.bringSubviewToFront(imageLogoView)
            let translation = sender.translation(in: self.view)
        imageLogoView.center = CGPoint(x: imageLogoView.center.x + translation.x, y: imageLogoView.center.y + translation.y)
            sender.setTranslation(CGPoint.zero, in: self.view)
        }
}
