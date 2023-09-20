//
//  ULTopic.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 13/08/23.
//

import Foundation
import ObjectMapper

class ULTopic:Mappable{
    
    var children: [ULTopic]?
    var id: Int?
    var courseId: Int?
    var order: Int?
    var orderIndex: Int = 0
    var parentId: Int?
    var title: String?
    var type: String?
    
    convenience required init?(map: Map) {
        self.init()
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
        children <- map["children"]
        id <- map["id"]
        courseId <- map["courseId"]
        order <- map["order"]
        orderIndex <- map["orderIndex"]
        parentId <- map["parent_id"]
        title <- map["title"]
        type <- map["type"]
    }
}
