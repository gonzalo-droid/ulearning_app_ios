//
//  ULProfileViewController.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 27/06/23.
//

import UIKit

class ULProfileViewController: UIViewController {
    
    var viewModel: ULProfileViewModel = ULProfileViewModel()
    
    var profileDataSource: ULProfile?
    var urlPayment: String?

    
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
        ULUserStore().logout{
            let login = ULLoginViewController()
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.changeRootViewController(login)
        }
    }
    
    @IBAction func goToPaymentsButton(_ sender: UIButton) {
        viewModel.getTokenWeb()
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
                
        viewModel.profile.bind { [weak self] profile in
            guard let self = self,
                  let profile = profile else {
                      return
                  }
            self.profileDataSource = profile
            setProfileData(data: self.profileDataSource)
        }
        
        viewModel.webPayment.bind { [weak self] urlPayment in
            guard let self = self,
                  let urlPayment = urlPayment else {
                      return
                  }
            self.urlPayment = urlPayment
            goToPayemts(web: self.urlPayment)
        }
    }
    
    func goToPayemts(web: String?) {

        if let url = URL(string: web ?? viewModel.urlStudent) {
            UIApplication.shared.open(url, options: [:])
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
