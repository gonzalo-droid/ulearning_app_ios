//
//  ULMessageItem.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 8/12/23.
//

import Foundation
import ObjectMapper

class ULMessageItem: Mappable {

    var classification: String?  = ""
    var content: String? = ""
    var id: Int?
    var publishedAt: String?
    var sendBy: ULUser?
    var status: String?
    var subject: String?
    var type: String?
    var uuid: String?
    var userIds: [String]? = []
    
    
    convenience required init?(map: Map) {
        self.init()
        mapping(map: map)
    }

    func mapping(map: Map) {
        classification <- map["classification"]
        content <- map["content"]
        id <- map["id"]
        publishedAt <- map["published_at"]
        sendBy <- map["send_by"]
        status <- map["status"]
        subject <- map["subject"]
        type <- map["type"]
        uuid <- map["uuid"]
        userIds <- map["user_ids"]
    }
}
