//
//  ULTopicCollectionViewCell.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 12/08/23.
//

import UIKit


protocol ULTopicComponentTableViewCellProtocol: AnyObject {
    func showDetails(topic: ULTopic)
}


class ULTopicCollectionViewCell: UICollectionViewCell {

    var topic: ULTopic?
    var delegate: ULTopicComponentTableViewCellProtocol?
    let iconModule = UIImage(systemName: "flag")?.withTintColor(.blueUL)
    let iconSession = UIImage(systemName: "checkmark.circle.fill")?.withTintColor(.blueUL)
    
    @IBOutlet weak var iconTypeImageView: UIImageView!{
        didSet {
            iconTypeImageView.image = iconSession
        }
    }
    
    @IBOutlet weak var titleTopicLabel: UILabel!
    
    @IBOutlet weak var containerTopic: UIView! {
        didSet {
            containerTopic.layer.cornerRadius = 16
            containerTopic.layer.borderWidth = 1
        }
    }

    
    public let nib = UINib(nibName: "ULTopicCollectionViewCell", bundle: nil)

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCell(topic: ULTopic, delegate: ULTopicComponentTableViewCellProtocol?) {
        self.topic = topic
        self.delegate = delegate
        titleTopicLabel.text = self.topic?.title
        iconTypeImageView.image = (self.topic?.parentId != nil) ? iconSession : iconModule

    }

}
