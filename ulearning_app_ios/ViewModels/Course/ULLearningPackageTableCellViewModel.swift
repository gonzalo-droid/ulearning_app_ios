//
//  ULLearningPackageTableCellViewModel.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 17/07/23.
//

import Foundation


class ULLearningPackageTableCellViewModel {
    var id: Int
    var title: String
    var image: URL?
    
    init(subscription: ULSubscription) {
        self.id = subscription.id ?? 0
        self.title = subscription.learningPackage?.title ?? ""
        self.image = makeImageURL(subscription.course?.mainImage?.originalUrl ?? "")
    }
    
    private func makeImageURL(_ imageURL: String) -> URL? {
        URL(string: imageURL)
    }
}
