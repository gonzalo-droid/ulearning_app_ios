//
//  ULBaseResponseProfile.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 20/07/23.
//

import Foundation
import ObjectMapper

class BaseResponseProfile: Mappable {
    var data: ULProfile?
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
