//
//  ULTeacher.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 1/07/23.
//

import Foundation
import ObjectMapper


class ULTeacher:Mappable{
    
    var firstName: String?
    var id: Int?
    var lastName: String?
    var subtype: String?
    var type: String?
    
    convenience required init?(map: Map) {
        self.init()
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        firstName <- map["first_name"]
        id <- map["id"]
        lastName <- map["last_name"]
        subtype <- map["subtype"]
        type <- map["type"]
    }
    
}
