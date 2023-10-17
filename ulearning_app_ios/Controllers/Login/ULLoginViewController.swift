//
//  ULLoginViewController.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 5/07/23.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

class ULLoginViewController: UIViewController {
    
    var viewModel: ULLoginViewmodel = ULLoginViewmodel()
    
    
    @IBOutlet weak var googleSignInButton: GIDSignInButton!
    
    @IBOutlet weak var eyeButton: UIButton!
    
    @IBOutlet weak var progressIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var inputEmailTextField: UITextField!{
        didSet {
            inputEmailTextField.textContentType = .emailAddress
            inputEmailTextField.autocorrectionType = .no
            inputEmailTextField.delegate = self
            
        }
    }
    
    @IBOutlet weak var inputPasswordTextField: UITextField!
    
    @IBOutlet weak var doLoginButton: UIButton!{
        didSet {
            doLoginButton.addTarget(self, action: #selector(doLogin(_:)), for: .touchUpInside)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPasswordField()
        progressIndicator.isHidden = true
        view.backgroundColor = .systemBackground
        bindViewModel()
        
        googleSignInButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onGoogleLoginTap)))
    }
    
    @objc func onGoogleLoginTap(){
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] userResult, errorResult in
            guard errorResult == nil else {
                
                let alertController = UIAlertController(title: "Oops!", message: "Error al ingresar con Google", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { action in
                }))
                present(alertController, animated: true, completion: nil)
                debugPrint("Error in Google Login \(String(describing: errorResult?.localizedDescription))")
                return
            }
            
            guard let user = userResult?.user,
                  let idToken = user.idToken?.tokenString
            else {
                self.showErrorLogin()
                debugPrint("Error in getting Token")
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { authResult, error in
                                    
                if let error = error {
                    self.showErrorLogin()
                    debugPrint("Error in Firebase Auth")
                    return
                }
                
                debugPrint("GoogleSing email: \(String(describing: authResult?.user.email))")

                self.successSignGoogle()
            
                
                debugPrint("Success in Firebase Auth")
                return
                
            }

            
        }
    
    }
 
    func successSignGoogle() {
        if let user = Auth.auth().currentUser {
            // Access user data
            let displayName = user.displayName
            let email = user.email
            var familyName = ""
            var givenName = ""
            
            // Access the family name from the Google profile data
            if let profile = GIDSignIn.sharedInstance.currentUser?.profile {
                familyName = profile.familyName ?? ""
                givenName = profile.givenName ?? ""
            }
    
            self.viewModel.sendLoginGoogle(
                username:displayName,
                email: email,
                familyName: familyName,
                givenName: givenName
            )
        }
    }

    
    func setupPasswordField() {
        inputPasswordTextField.textContentType = .password
        inputPasswordTextField.isSecureTextEntry = true
        inputPasswordTextField.autocorrectionType = .no
        inputPasswordTextField.delegate = self
        inputPasswordTextField.rightViewMode = .always
        
        let eyeButtonSize = CGRect(x: 0, y: 0, width: 24, height: 24)
        eyeButton.frame = eyeButtonSize
        eyeButton.setImage(UIImage(named: "eye.slash"), for: .normal)
        eyeButton.addTarget(self, action: #selector(eyeButtonTapped), for: .touchUpInside)
        
        inputPasswordTextField.rightView = eyeButton
    }
    
    @objc func eyeButtonTapped() {
        inputPasswordTextField.isSecureTextEntry.toggle()
        
        let eyeImage = inputPasswordTextField.isSecureTextEntry ? UIImage(named: "eye.slash") : UIImage(named: "eye")
        eyeButton.setImage(eyeImage, for: .normal)
    }
    
    
    func bindViewModel() {
        
        viewModel.isLoadingData.bind { [weak self] isLoading in
            guard let isLoading = isLoading else {
                return
            }
            DispatchQueue.main.async {
                if isLoading {
                    self?.progressIndicator.isHidden = false
                    self?.progressIndicator.startAnimating()
                } else {
                    self?.progressIndicator.isHidden = true
                    self?.progressIndicator.stopAnimating()
                }
            }
        }
        
        viewModel.tokenLogin.bind{ [weak self] tokenLogin in
            guard let self = self,
                  let tokenLogin = tokenLogin else {
                return
            }
            if tokenLogin == nil{
                showErrorLoginIncorrect()
            }
            self.goToHome()
        }
        
    }
    
    @objc func doLogin(_ sender: UIButton) {
        let emailInput = inputEmailTextField?.text ?? ""
        let passwordInput = inputPasswordTextField?.text ?? ""
        
        if !emailInput.isEmpty && !passwordInput.isEmpty {
            viewModel.sendLogin(username: emailInput, password: passwordInput)
        } else {
            showErrorLoginEmpty()
        }
    }
    
    func goToHome() {
        let homeTab = ULTabBarViewController()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.changeRootViewController(homeTab)
        
    }
    
    func showErrorLoginEmpty() {
        let alertController = UIAlertController(title: "Oops!", message: "Ingrese sus credenciales", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { action in
            
        }))
        
        present(alertController, animated: true, completion: nil)
    }
    
    func showErrorLoginIncorrect() {
        let alertController = UIAlertController(title: "Oops!", message: "Credenciales incorrectas", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { action in
            
        }))
        
        present(alertController, animated: true, completion: nil)
    }
    
    func showErrorLogin() {
        let alertController = UIAlertController(title: "Oops!", message: "Problemas al iniciar sesión, inténtelo más tarde", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { action in
            
        }))
        
        present(alertController, animated: true, completion: nil)
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

extension ULLoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Ocultar el teclado cuando se presiona "Return"
        return true
    }
}
