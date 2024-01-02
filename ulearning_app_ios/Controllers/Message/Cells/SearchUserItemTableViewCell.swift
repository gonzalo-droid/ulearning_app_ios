//
//  SearchUserItemTableViewCell.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 2/01/24.
//

import UIKit

class SearchUserItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var containerUser: UIView!
    
    @IBOutlet weak var userLable: UILabel!{
        didSet {
            userLable.font = UIFont.boldSystemFont(ofSize: 14)
            userLable.textColor = .blueUL
            userLable.numberOfLines = 3
        }
    }
    
    static var identifier: String {
        get {
            "SearchUserItemTableViewCell"
        }
    }
    
    static func register() -> UINib {
        UINib(nibName: "SearchUserItemTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerUser.round()
        
    }
    
    func setupCell(viewModel: ULSearchUserTableCellViewModel) {
        self.userLable.text = viewModel.name
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
