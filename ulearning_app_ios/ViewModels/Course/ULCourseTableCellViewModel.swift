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
    var isFinished: Bool = false
    var image: URL?
    var percentage: Float? = Float(0)
    var percentageTitle: String? = "0 %"
    
    init(subscription: ULSubscription) {
        self.id = subscription.id ?? 0
        self.title = subscription.course?.title ?? ""
        self.category = subscription.course?.category?.name ?? ""
        self.image = makeImageURL(subscription.course?.mainImage?.originalUrl ?? "")
        self.isFinished = subscription.isFinished ?? false
        
        if let value = subscription.percentageAdvance {
            let toFLoat = Float(value)
            self.percentage = (toFLoat ?? 0) / 100
            self.percentageTitle = "\(toFLoat ?? 0) %"
        }
        
    }
    
    private func makeImageURL(_ imageURL: String) -> URL? {
        URL(string: imageURL)
    }
}
