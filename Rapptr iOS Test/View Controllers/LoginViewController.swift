//
//  LoginViewController.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit

class LoginViewController: UIViewController {
    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     * 1) Make the UI look like it does in the mock-up.
     *
     * 2) Take email and password input from the user
     *
     * 3) Use the endpoint and paramters provided in LoginClient.m to perform the log in
     *
     * 4) Calculate how long the API call took in milliseconds
     *
     * 5) If the response is an error display the error in a UIAlertController
     *
     * 6) If the response is successful display the success message AND how long the API call took in milliseconds in a UIAlertController
     *
     * 7) When login is successful, tapping 'OK' in the UIAlertController should bring you back to the main menu.
     **/
    
    // MARK: - Properties
        
    @IBOutlet weak var emailContainer: UIView!
    @IBOutlet weak var tfEmailAddress: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var passwordContainer: UIView!
    
    var timeTakenInApiCall = 0.0
    var timer :Timer?
  
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"
       // decorateView()
        if #available(iOS 13, *){
            [emailContainer,passwordContainer].forEach {
                $0?.layer.cornerRadius = 6
                $0?.layer.cornerCurve = .continuous
            }
        }
    }
    
    @objc func updateTimer() {
        timeTakenInApiCall += 0.01
        }
    

  
    
    
    
    // MARK: - Actions
    @IBAction func backAction(_ sender: Any) {
        let mainMenuViewController = MenuViewController()
        self.navigationController?.pushViewController(mainMenuViewController, animated: true)
    }
    
    @IBAction func didPressLoginButton(_ sender: Any) {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        guard let url = URL(string: "http://dev.rapptrlabs.com/Tests/scripts/login.php") else { return }
        let parameter: [String: String] = ["email" : "info@rapptrlabs.com", "password" : "Test123"]
        LoginClient.callPost(url: url, params: parameter) { [weak self] response in
            guard let self = self else { return }
            self.timer?.invalidate()
            self.alert(message:  "time Taken: \(self.timeTakenInApiCall) ms\n" + response, title: "")
        } error: { error in
            self.timer?.invalidate()
            self.alert(message:"time Taken: \(self.timeTakenInApiCall)m\n\(error ?? "")"  , title: "")
        }
    }
}
