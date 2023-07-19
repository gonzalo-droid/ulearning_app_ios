//
//  ULProfileViewController.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 27/06/23.
//

import UIKit

class ULProfileViewController: UIViewController {
    
    
    @IBOutlet weak var nameUserLabel: UILabel!
    
    @IBOutlet weak var dniLabel: UILabel!
    
    @IBOutlet weak var numberDocumentLabel: UILabel!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var fatherLastnameTextField: UITextField!
    
    @IBOutlet weak var motherLastnameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var birthdateTextField: UITextField!
    
    @IBOutlet weak var containerScanQRView: UIView!{
        didSet {
            containerScanQRView.layer.cornerRadius = 8
        }
    }
    
    @IBOutlet weak var containerPaymentsView: UIView!{
        didSet {
            containerPaymentsView.layer.cornerRadius = 8
        }
    }
    
    @IBOutlet weak var containerLogoutView: UIView!{
        didSet {
            containerLogoutView.layer.cornerRadius = 8
        }
    }
    
    @IBAction func goToLogoutButton(_ sender: UIButton) {
    }
    
    @IBAction func goToPaymentsButton(_ sender: UIButton) {
    }
    
    @IBAction func goToScanQRButton(_ sender: UIButton) {
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}
