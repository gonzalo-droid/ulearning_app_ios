//
//  ULConversationTableViewCell.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 27/08/23.
//

import UIKit

class ULConversationTableViewCell: UITableViewCell {

    @IBOutlet weak var ContentLabel: UILabel!{
        didSet {
            ContentLabel.font = UIFont.systemFont(ofSize: 12)
            ContentLabel.textColor = .blueUL
            ContentLabel.numberOfLines = 3
            ContentLabel.lineBreakMode = .byTruncatingTail
        }
    }
    
    @IBOutlet weak var timeLabel: UILabel!{
        didSet {
            timeLabel.font = UIFont.systemFont(ofSize: 11)
            timeLabel.textColor = .blueUL
        }
    }
    
    @IBOutlet weak var containerItem: UIView!
    
    
    static var identifier: String {
        get {
            "ULConversationTableViewCell"
        }
    }
    
    static func register() -> UINib {
        UINib(nibName: "ULConversationTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerItem.round()
        containerItem.heightAnchor.constraint(equalToConstant: 10)    
    }
    
    func setupCell(viewModel: ULMessageTableCellViewModel) {
        ContentLabel.text = viewModel.content
        timeLabel.text = viewModel.publishedAt

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
