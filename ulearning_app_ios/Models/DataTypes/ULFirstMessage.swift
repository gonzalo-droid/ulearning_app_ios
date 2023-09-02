//
//  ULFirstMessage.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 27/08/23.
//

import Foundation
import ObjectMapper

class ULFirstMessage: Mappable {
    var classification: String?
    var content: String?
    var id: Int?
    var publishedAt: String?
    var sendBy: ULUser?
    var status: String?
    var subject: String?
    var type: String?
    var userIds: [String] = []
    var uuid: String?
    
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
        userIds <- map["user_ids"]
        uuid <- map["uuid"]
    }
}


