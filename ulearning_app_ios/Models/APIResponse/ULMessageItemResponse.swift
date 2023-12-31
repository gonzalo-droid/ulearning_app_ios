//
//  ULMessageItemResponse.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 30/12/23.
//

import Foundation
import ObjectMapper

class ULMessageItemResponse: Mappable {
    var data: ULMessageItem?
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
