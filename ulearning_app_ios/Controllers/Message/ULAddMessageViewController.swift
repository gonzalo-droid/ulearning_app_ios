//
//  UIAddMessageViewController.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 2/09/23.
//

import UIKit

class ULAddMessageViewController: UIViewController {

    var viewModel: ULAddMessageSupportViewModel

    @IBOutlet weak var inputSendMessage: UITextField!
    
    @IBOutlet weak var btnSendMessage: UIButton!
    
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
    
    
    init(viewModel: ULAddMessageSupportViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "ULAddMessageViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func closeButtonPress() {
        self.dismiss(animated: true)
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


}
