//
//  ULCategory.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 1/07/23.
//

import Foundation
import ObjectMapper

class ULCategory:Mappable{
    
    var cardImage: ULImage?
    var color: String?
    var description: String?
    var id: Int?
    var name: String?
    var type: String?
    
    convenience required init?(map: Map) {
        self.init()
        mapping(map: map)
    }

    func mapping(map: Map) {
        cardImage <- map["card_image"]
        color <- map["color"]
        description <- map["description"]
        id <- map["id"]
        name <- map["name"]
        type <- map["type"]
    }

    
}
