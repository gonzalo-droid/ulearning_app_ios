//
//  ULTopicCellViewModel.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 15/08/23.
//

import Foundation

class ULTopicCellViewModel {
    var id: Int
    var title: String
    var children: [ULTopic]?
    
    init(topic: ULTopic) {
        self.id = topic.id ?? 0
        self.title = topic.title ?? ""
        self.children = topic.children
    }

}
