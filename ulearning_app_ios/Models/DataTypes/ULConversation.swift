//
//  ULConversation.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 27/08/23.
//

import Foundation
import ObjectMapper

class ULConversation: Mappable {

    var canByReply: Bool? = false
    var courseId: Int?
    var firstMessage: ULFirstMessage?
    var createdBy: ULUser?
    var id: Int?
    var isBroadcast: Bool? = false
    var replyToAuthor: Bool? = false
    var toSupport: Bool? = false
    var uuid: String?
    
    
    convenience required init?(map: Map) {
        self.init()
        mapping(map: map)
    }

    func mapping(map: Map) {
        canByReply <- map["can_by_reply"]
        courseId <- map["course_id"]
        firstMessage <- map["firstMessage"]
        createdBy <- map["createdBy"]
        id <- map["id"]
        isBroadcast <- map["is_broadcast"]
        replyToAuthor <- map["reply_to_author"]
        toSupport <- map["to_support"]
        uuid <- map["uuid"]
    }
}

