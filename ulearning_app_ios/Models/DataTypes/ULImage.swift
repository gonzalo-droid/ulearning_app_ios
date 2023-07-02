//
//  ULCardImage.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 1/07/23.
//

import Foundation
import ObjectMapper

class ULImage:Mappable{
    
    var fileName: String?
    var id: Int?
    var name: String?
    var originalUrl: String?
    var previewUrl: String?
    var size: Int?
    var uuid: String?
    
    convenience required init?(map: Map) {
        self.init()
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
        fileName <- map["file_name"]
        id <- map["id"]
        name <- map["name"]
        originalUrl <- map["original_url"]
        previewUrl <- map["preview_url"]
        size <- map["size"]
        uuid <- map["uuid"]
    }
    
    
}
