//
//  ULUsersResponse.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 1/01/24.
//

import Foundation
import ObjectMapper

class ULUsersResponse: Mappable {
    var data: [ULUser]?
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
