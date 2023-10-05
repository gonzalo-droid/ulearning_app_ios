//
//  CourseLearningCollectionViewCell.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 4/10/23.
//

import UIKit


protocol CourseLearningCollectionViewCellProtocol: AnyObject {
    func showDetails(data: ULLearningPackageItem)
}


class CourseLearningCollectionViewCell: UICollectionViewCell {

    var data: ULLearningPackageItem?
    var delegate: CourseLearningCollectionViewCellProtocol?


    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var categoryLabel: UILabel!{
        didSet {
            categoryLabel.font = UIFont.boldSystemFont(ofSize: 12)
            categoryLabel.textColor = .blueUL
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!{
        didSet {
            titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
            titleLabel.textColor = .blueUL
            titleLabel.numberOfLines = 3
        }
    }
    
    
    @IBOutlet weak var percentageLabel: UILabel!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var containerRequired: UIView!{
        didSet {
            containerRequired.layer.cornerRadius = 8
            containerRequired.isHidden = true
            containerRequired.round()

        }
    }
    
    @IBOutlet weak var containerView: UIView!{
        didSet {
            containerView.round()
        }
    }
    
    public let nib = UINib(nibName: "CourseLearningCollectionViewCell", bundle: nil)

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCell(data: ULLearningPackageItem, delegate: CourseLearningCollectionViewCellProtocol?) {
        self.data = data
        self.delegate = delegate
        
        titleLabel.text = data.course?.title
        categoryLabel.text = data.course?.category?.name
        
        containerRequired.isHidden = !data.isRequired

    }

}
