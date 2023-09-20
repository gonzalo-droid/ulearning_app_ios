//
//  ULTopicResponse.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 13/08/23.
//

import Foundation
import ObjectMapper

class ULTopicResponse: Mappable {
    var data: [ULTopic]?
    var code: String?
    var message: String?

    convenience required init?(map: Map) {
        self.init()
        mapping(map: map)
    }

    func mapping(map: Map) {
        data <- map["data"]
        code <- map["code"]
        message <- map["message"]
    }
}
