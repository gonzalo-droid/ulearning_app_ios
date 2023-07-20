//
//  ULProfileViewController.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 27/06/23.
//

import UIKit

class ULProfileViewController: UIViewController {
    
    @IBOutlet weak var indicatorProgress: UIActivityIndicatorView!{
        didSet {
            indicatorProgress.hidesWhenStopped = true
        }
    }
    
    var viewModel: ULProfileViewModel = ULProfileViewModel()
    
    var profileDataSource: ULProfile?
    
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
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.getData()
    }
    
    func bindViewModel() {
        
        viewModel.isLoadingData.bind { [weak self] isLoading in
            guard let isLoading = isLoading else {
                return
            }
            DispatchQueue.main.async {
                if isLoading {
                    self?.indicatorProgress.startAnimating()
                } else {
                    self?.indicatorProgress.stopAnimating()
                }
            }
        }
        
        viewModel.profile.bind { [weak self] profile in
            guard let self = self,
                  let profile = profile else {
                      return
                  }
            debugPrint("data?.name")
            self.profileDataSource = profile
            setProfileData(data: self.profileDataSource)
        }
    }
    
    func setProfileData(data : ULProfile?){
        if(data != nil){
            numberDocumentLabel.text = data?.documentNumber ?? "--"
            dniLabel.text = "DNI"
            nameUserLabel.text = data?.name ?? ""
            
            nameTextField.text = data?.name ?? ""
            nameTextField.isUserInteractionEnabled = false
            
            fatherLastnameTextField.text = data?.lastName ?? ""
            fatherLastnameTextField.isUserInteractionEnabled = false
            
            motherLastnameTextField.text = data?.secondLastName ?? ""
            motherLastnameTextField.isUserInteractionEnabled = false
            
            emailTextField.text = data?.email ?? ""
            emailTextField.isUserInteractionEnabled = false
            
            phoneTextField.text = data?.phone ?? ""
            phoneTextField.isUserInteractionEnabled = false
            
            birthdateTextField.text = data?.dateOfBirth ?? ""
            birthdateTextField.isUserInteractionEnabled = false
        }
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
