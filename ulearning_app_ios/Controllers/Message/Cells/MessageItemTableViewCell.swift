//
//  MessageItemTableViewCell.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 7/12/23.
//

import UIKit

class MessageItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var contianerMessage: UIView!
    
    @IBOutlet weak var container: UIView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        container.round()
    }

    static var identifier: String {
        get {
            "MessageItemTableViewCell"
        }
    }
    
    static func register() -> UINib {
        UINib(nibName: "MessageItemTableViewCell", bundle: nil)
    }
    
    func setupCell(viewModel: ULMessageItemTableCellViewModel) {
        self.nameLabel.text = viewModel.name
        self.contentLabel.text = viewModel.content
        
        let textSize = contentLabel.sizeThatFits(CGSize(width: contentLabel.frame.width, height: CGFloat.greatestFiniteMagnitude))
        container.frame.size.height = textSize.height
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}
