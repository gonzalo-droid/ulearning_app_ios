//
//  ULTopicComponentTableViewCell.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 2/08/23.
//

import UIKit

class ULTopicComponentTableViewCell: UITableViewCell {

    var tempArray: [ULTopic] = []
    var delegate: ULTopicComponentTableViewCellProtocol?
    
    @IBOutlet weak var containerBtnGoToMessage: UIView!{
        didSet {
            containerBtnGoToMessage.layer.cornerRadius = 8
            containerBtnGoToMessage.isHidden = true
        }
    }
    
    @IBOutlet weak var topicsCollectionView: UICollectionView!{
        didSet {
            topicsCollectionView.register(
                ULTopicCollectionViewCell().nib,
                forCellWithReuseIdentifier: String(describing: ULTopicCollectionViewCell.self)
            )
            topicsCollectionView.delegate = self
            topicsCollectionView.dataSource = self
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
    
    func setupCell(data: [ULTopic], delegate: ULTopicComponentTableViewCellProtocol) {
        // order list
        let unsortedList: [ULTopic] = data

        let sortedList = unsortedList.sorted { $0.orderIndex < $1.orderIndex }
        
        self.tempArray = sortedList
        self.delegate = delegate
        self.topicsCollectionView.reloadData()
        print("ULTopicComponentTableViewCell setupCell \(data.count)")
        
        var totalCellHeight: CGFloat = 0.0
        let cellHeight: CGFloat = 100.0
        totalCellHeight = cellHeight * CGFloat(data.count)
        topicsCollectionView.frame.size.height = totalCellHeight
        
    }
    
}


extension ULTopicComponentTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tempArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: ULTopicCollectionViewCell.self),
            for: indexPath
        ) as! ULTopicCollectionViewCell

        cell.setupCell(topic: self.tempArray[indexPath.row], delegate: delegate)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.showDetails(topic: self.tempArray[indexPath.row])
    }
    
}

extension ULTopicComponentTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 320, height: 35)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
