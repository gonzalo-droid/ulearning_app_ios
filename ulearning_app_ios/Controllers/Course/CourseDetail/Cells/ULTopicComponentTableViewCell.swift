//
//  ULTopicComponentTableViewCell.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 2/08/23.
//

import UIKit

protocol ULTopicComponentTableViewCellProtocol: AnyObject {
    func goToMessageBtn(sender: UIButton, cell: ULTopicComponentTableViewCell)
}

class ULTopicComponentTableViewCell: UITableViewCell {

    
    @IBOutlet weak var containerBtnGoToMessage: UIView!{
        didSet {
            containerBtnGoToMessage.layer.cornerRadius = 8
        }
    }
    
    
    
    public let nib = UINib(
        nibName: String(describing: ULTopicComponentTableViewCell.self),
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
    
    func setupCell(data: ULSubscription, delegate: ULTopicComponentTableViewCellProtocol) {
        print("ULTopicComponentTableViewCellProtocol \(data.course?.title)")
        
    }
    
}
