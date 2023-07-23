//
//  ULCourseTableViewCell.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 11/07/23.
//

import UIKit

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
        // self.courseImageView.sd_setImage(with: viewModel.image)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
