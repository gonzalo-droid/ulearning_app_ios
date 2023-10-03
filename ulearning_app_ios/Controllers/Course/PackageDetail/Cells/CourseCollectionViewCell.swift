//
//  CourseCollectionViewCell.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 3/10/23.
//

import UIKit


protocol CourseCollectionViewCellProtocol: AnyObject {
    func showDetails(data: ULLearningPackageItem)
}


class CourseCollectionViewCell: UICollectionViewCell {

    var data: ULLearningPackageItem?
    var delegate: CourseCollectionViewCellProtocol?

    
    public let nib = UINib(nibName: "CourseCollectionViewCell", bundle: nil)

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCell(topic: ULLearningPackageItem, delegate: CourseCollectionViewCellProtocol?) {
        self.data = topic
        self.delegate = delegate
        

    }

}
