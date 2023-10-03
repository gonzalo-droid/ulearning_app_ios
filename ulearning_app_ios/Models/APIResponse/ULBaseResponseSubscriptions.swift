//
//  ULBaseResponseSubscriptions.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 26/09/23.
//

import Foundation
import ObjectMapper

class BaseResponseSubscriptions: Mappable {
    var data: [ULSubscription]?
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
