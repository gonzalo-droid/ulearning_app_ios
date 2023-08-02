//
//  ULDetailComponentTableViewCell.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 2/08/23.
//

import UIKit

class ULDetailComponentTableViewCell: UITableViewCell {

    public let nib = UINib(
        nibName: String(describing: ULDetailComponentTableViewCell.self),
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
    
}
