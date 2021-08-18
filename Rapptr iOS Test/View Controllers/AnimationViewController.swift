//
//  AnimationViewController.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit

class AnimationViewController: UIViewController {
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     * 1) Make the UI look like it does in the mock-up.
     *
     * 2) Logo should fade out or fade in when the user hits the Fade In or Fade Out button
     *
     * 3) User should be able to drag the logo around the screen with his/her fingers
     *
     * 4) Add a bonus to make yourself stick out. Music, color, fireworks, explosions!!! Have Swift experience? Why not write the Animation
     *    section in Swfit to show off your skills. Anything your heart desires!
     *
     */
    //MARK:- Variables
    var panGesture =  UIPanGestureRecognizer()
    var tapGesture = UITapGestureRecognizer()
    var isFadeIn = false
    
    //MARK:- Outlets
    @IBOutlet weak var imageLogoView: UIImageView!
    
  
    
    
    // MARK: -  Viewiewntroller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Animation"
        
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(draggedView(_:)))
        imageLogoView.isUserInteractionEnabled = true
        imageLogoView.addGestureRecognizer(panGesture)
        imageLogoView.fadeOut()
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapView))
        self.view.addGestureRecognizer(tapGesture)
        
    }
    
    // MARK: - IBAction
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
    
    // MARK:- Objc Functions
    @objc func draggedView(_ sender:UIPanGestureRecognizer){ //Performs fade-in animation
        self.view.bringSubviewToFront(imageLogoView)
        let translation = sender.translation(in: self.view)
        imageLogoView.center = CGPoint(x: imageLogoView.center.x + translation.x, y: imageLogoView.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self.view)
    }
    
    @objc func onTapView() { //Performs fly animationa
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.imageLogoView.transform = CGAffineTransform(translationX: -25, y: 0)
        }) { (_) in
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.imageLogoView.alpha = 0
                self.imageLogoView.transform = self.imageLogoView.transform.translatedBy(x: 0, y: -200)
            }, completion: nil)
        }
        
    }
    
    
}
