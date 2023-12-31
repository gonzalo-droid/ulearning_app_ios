//
//  BannerTableViewCell.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 20/09/23.
//

import UIKit

protocol BannerTableViewCellProtocol: AnyObject {
    func closeButtonPress(sender: UIButton, cell: BannerTableViewCell)
}

class BannerTableViewCell: UITableViewCell {

    var delegate: BannerTableViewCellProtocol?
    
    @IBOutlet weak var percentageLabel: UILabel!
    
    @IBOutlet weak var backButton: UIButton!{
        didSet {
            backButton.setTitle("", for: .normal)
            backButton.setTitle("", for: .selected)
            backButton.setTitle("", for: .focused)
            backButton.addTarget(
                self,
                action: #selector(closeButtonPress(_:)),
                for: .touchUpInside
            )
        }
    }
    
    @IBOutlet weak var imagePackageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!{
        didSet {
            titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
            titleLabel.textColor = .blueUL
            titleLabel.numberOfLines = 3
        }
    }
    
    public let nib = UINib(
        nibName: String(describing: BannerTableViewCell.self),
        bundle: nil
    )

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setupCell(data: ULSubscription?, delegate: BannerTableViewCellProtocol) {
        self.delegate = delegate
        
        self.titleLabel.text = data?.learningPackage?.title
        
        calculatePercentage(data: data)
    }
    
    func calculatePercentage(data: ULSubscription?){
        let items = data?.learningPackage?.items
        
        let total: Double = 100.0
        var resultText = "0"
        var resultNumber: Double = 0.0

        if !items!.isEmpty {
            if let items = items {
                  let totalDivider = total / Double(items.count)
                  var result: Double = 0.0
                  
                for item in items {
                    let value =  Double(item.percentageAdvance ?? "0")
                    result = result + (totalDivider * (value ?? 0) / 100.0)
                  }
                  
                  resultNumber = result
                  resultText = String(result)
              }
        }
        
        percentageLabel.text = "\(resultText) %"
    }
    
    
    @objc func closeButtonPress(_ sender: UIButton) {
        self.delegate?.closeButtonPress(sender: sender, cell: self)
    }
    
}
