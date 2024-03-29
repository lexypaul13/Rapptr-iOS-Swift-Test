//
//  Extensions.swift
//  Rapptr iOS Test
//
//  Created by Alex Paul on 8/15/21.
//

import UIKit

extension UIViewController{
    
    func alert(message: String, title: String = "") { //Presents alert controller
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: {_ in 
                self.navigationController?.popToRootViewController(animated: true)
            })
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
}
extension UIView{
    func roundCorners(corners:UIRectCorner, radius: CGFloat) { //Sets round corners
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    
    
    
    
    @IBInspectable var circle: Bool{ //Turns image view circular
        get{
            return false
        }
        set{
            if newValue{
                layer.cornerRadius = frame.width*0.5
                layer.masksToBounds = true
            }
            
        }
    }
    
}

extension UIImageView {
    func downloadImage( imageURL: String ) { //Downloads images
        guard let url = URL(string: imageURL) else {
            return
        }
        let _: Void = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            if error != nil { return }
            DispatchQueue.main.async {
                if let downloadedImage = UIImage(data: data!) {
                    self.image = downloadedImage
                }
            }
        }.resume()
    }
}



extension UIView{
    func fadeIn(_ duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}) { //Peforms fade in animation
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: completion)  }
    
    func fadeOut(_ duration: TimeInterval = 0.5, delay: TimeInterval = 1.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) { //Peforms fade out animation
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 0.3
        }, completion: completion)
    }
}


extension UIColor {
    convenience init(hexString: String) { //sets hexcolor for text
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}


