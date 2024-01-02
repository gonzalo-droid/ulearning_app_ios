//
//  UIAddMessageViewController.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 2/09/23.
//

import UIKit

protocol ULAddMessageViewControllerProtocol: AnyObject {
    func sendMessageBtn(controller: ULAddMessageViewController)
}

class ULAddMessageViewController: UIViewController {
    
    var viewModel: ULAddMessageSupportViewModel
    
    var delegate: ULAddMessageViewControllerProtocol?
    
    @IBOutlet weak var containerSeachUser: UIView!{
        didSet {
            containerSeachUser.isHidden = true
            containerSeachUser.layer.cornerRadius = 8
        }
    }
    
    @IBOutlet weak var userLabel: UILabel!
    
    @IBOutlet weak var searchUserBtn: UIButton!{
        didSet {
            
            searchUserBtn.addTarget(
                self,
                action: #selector(searchUser),
                for: .touchUpInside
            )
        }
    }
    
    @IBOutlet weak var itemBorderContainer: UIView! {
        didSet {
            itemBorderContainer.layer.cornerRadius = 8
        }
    }
    
    @IBOutlet weak var loadingProgress: UIActivityIndicatorView!{
        didSet {
            loadingProgress.hidesWhenStopped = true
        }
    }
    
    @IBOutlet weak var inputSendMessage: UITextField!{
        didSet {
            inputSendMessage.text = ""
        }
    }
    
    @IBOutlet weak var btnSendMessage: UIButton!{
        didSet {
            btnSendMessage.addTarget(
                self,
                action: #selector(sendMessageBtn),
                for: .touchUpInside
            )
        }
    }
    
    @IBOutlet weak var btnBack: UIButton!{
        didSet {
            btnBack.setTitle("", for: .normal)
            btnBack.setTitle("", for: .selected)
            btnBack.setTitle("", for: .focused)
            btnBack.addTarget(
                self,
                action: #selector(closeButtonPress),
                for: .touchUpInside
            )
        }
    }
    
    
    init(viewModel: ULAddMessageSupportViewModel, delegate: ULAddMessageViewControllerProtocol) {
        self.viewModel = viewModel
        self.delegate = delegate
        super.init(nibName: "ULAddMessageViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func closeButtonPress() {
        self.dismiss(animated: true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func sendMessageBtn() {
        if let textFieldText = inputSendMessage.text {
            if !textFieldText.isEmpty {
                viewModel.sendMessage(content: textFieldText)
            } else {
                self.showAlert()
            }
        } else {
            self.showAlert()
        }
    }
    
    @objc func searchUser() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        containerSeachUser.isHidden = (viewModel.typeMessage == "support")
        userLabel.text = (viewModel.courseId == nil) ? "Soporte plataforma" : "Selecciona un usuario"
    }
    
    func bindViewModel() {
        
        viewModel.isLoadingData.bind { [weak self] isLoading in
            guard let isLoading = isLoading else {
                return
            }
            DispatchQueue.main.async {
                if isLoading {
                    self?.loadingProgress.startAnimating()
                } else {
                    self?.loadingProgress.stopAnimating()
                }
            }
        }
        
        viewModel.conversationResponse.bind { [weak self] conversation in
            guard let self = self,
                  let conversation = conversation else {
                return
            }
            
            self.delegate?.sendMessageBtn(controller: self)
            
        }
    }
    
    @IBAction func showAlert() {
        // Create an alert controller
        let alertController = UIAlertController(title: "", message: "Ingrese un mensaje", preferredStyle: .alert)
        
        // Add an action (button) to the alert
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        // Present the alert
        present(alertController, animated: true, completion: nil)
    }
    
    
}
