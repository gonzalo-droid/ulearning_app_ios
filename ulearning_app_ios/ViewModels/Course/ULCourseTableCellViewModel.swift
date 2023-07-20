//
//  ULCourseTableCellViewModel.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 10/07/23.
//

import Foundation

class ULCourseTableCellViewModel {
    var id: Int
    var title: String
    var category: String
    var image: URL?
    
    init(subscription: ULSubscription) {
        self.id = subscription.id ?? 0
        self.title = subscription.course?.title ?? ""
        self.category = subscription.course?.category?.name ?? ""
        self.image = makeImageURL(subscription.course?.mainImage?.originalUrl ?? "")
    }
    
    private func makeImageURL(_ imageURL: String) -> URL? {
        URL(string: imageURL)
    }
}
