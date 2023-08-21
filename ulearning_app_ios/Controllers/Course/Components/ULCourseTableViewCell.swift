//
//  ULCourseTableViewCell.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 11/07/23.
//

import UIKit
import Kingfisher


class ULCourseTableViewCell: UITableViewCell {
    
    @IBOutlet weak var categoryLabel: UILabel!{
        didSet {
            categoryLabel.font = UIFont.boldSystemFont(ofSize: 12)
            categoryLabel.textColor = .blueUL
        }
    }
    
    @IBOutlet weak var titleCourseLabel: UILabel!{
        didSet {
            titleCourseLabel.font = UIFont.boldSystemFont(ofSize: 20)
            titleCourseLabel.textColor = .blueUL
        }
    }
    
    @IBOutlet weak var courseImageView: UIImageView!
    
    @IBOutlet weak var containerView: UIView! {
        didSet {
        }
    }
    
    
    @IBOutlet weak var progressAdvance: UIProgressView!
    
    
    static var identifier: String {
        get {
            "ULCourseTableViewCell"
        }
    }
    
    static func register() -> UINib {
        UINib(nibName: "ULCourseTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.round()
        
    }
    
    func setupCell(viewModel: ULCourseTableCellViewModel) {
        self.categoryLabel.text = viewModel.category
        self.titleCourseLabel.text = viewModel.title
        progressAdvance.isHidden = viewModel.isFinished
        progressAdvance.setProgress(viewModel.percentage ?? Float(0), animated: true)
        
        if let imageUrl = viewModel.image {
            self.courseImageView.kf.setImage(with: imageUrl)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
