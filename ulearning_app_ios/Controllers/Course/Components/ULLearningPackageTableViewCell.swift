//
//  ULLearningPackageTableViewCell.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 16/07/23.
//

import UIKit
import Kingfisher

class ULLearningPackageTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var subTitleLabel: UILabel!{
        didSet {
            subTitleLabel.isHidden = true
            subTitleLabel.font = UIFont.boldSystemFont(ofSize: 13)
            subTitleLabel.textColor = .blueUL
            subTitleLabel.text = "(Concluido)"
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!{
        didSet {
            titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
            titleLabel.textColor = .blueUL
            titleLabel.numberOfLines = 3
        }
    }
    
    @IBOutlet weak var learningPackageImageView: UIImageView!
    
    @IBOutlet weak var containerView: UIView!
    static var identifier: String {
        get {
            "ULLearningPackageTableViewCell"
        }
    }
    
    static func register() -> UINib {
        UINib(nibName: "ULLearningPackageTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.round()
        
    }
    
    func setupCell(viewModel: ULLearningPackageTableCellViewModel) {
         self.titleLabel.text = viewModel.title
        
        self.subTitleLabel.isHidden = !viewModel.isFinished
        if let imageUrl = viewModel.image {
            self.learningPackageImageView.kf.setImage(with: imageUrl)
            self.learningPackageImageView.alpha = 0.2
            self.learningPackageImageView.contentMode = .scaleAspectFill
            self.learningPackageImageView.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
