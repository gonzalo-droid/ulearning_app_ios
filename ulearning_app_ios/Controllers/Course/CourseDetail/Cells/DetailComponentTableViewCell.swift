//
//  ULDetailComponentTableViewCell.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 2/08/23.
//

import UIKit

protocol DetailComponentTableViewCellProtocol: AnyObject {
    func closeButtonPress(sender: UIButton, cell: DetailComponentTableViewCell)
}

class DetailComponentTableViewCell: UITableViewCell {

    @IBAction func backBtn(_ sender: Any) {
    }
    
    @IBOutlet weak var courseaImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UITextView!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var modeLabel: UILabel!
    
    @IBOutlet weak var sessionLabel: UILabel!
    
    @IBAction func goToMessageBtn(_ sender: Any) {
    }
    
    var delegate: DetailComponentTableViewCellProtocol?

    
    public let nib = UINib(
        nibName: String(describing: DetailComponentTableViewCell.self),
        bundle: nil
    )

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell(data: ULSubscription, delegate: DetailComponentTableViewCellProtocol) {
        self.delegate = delegate
        print("DetailComponentTableViewCellProtocoll \(data.course?.title)")

        titleLabel.attributedText = NSMutableAttributedString(
            string: data.course?.title ?? "text",
            attributes: [
                .kern: -0.46,
            ]
        )
        
    }
    
}
