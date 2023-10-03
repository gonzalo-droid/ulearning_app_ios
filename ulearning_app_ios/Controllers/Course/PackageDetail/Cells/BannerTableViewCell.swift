//
//  BannerTableViewCell.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 20/09/23.
//

import UIKit

protocol BannerTableViewCellProtocol: AnyObject {
}

class BannerTableViewCell: UITableViewCell {

    var delegate: BannerTableViewCellProtocol?

    @IBOutlet weak var titleLabel: UILabel!
    
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
    }
    
}
