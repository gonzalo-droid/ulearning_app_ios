//
//  ULLoginResponse.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 23/07/23.
//

import Foundation
import ObjectMapper

class ULLoginResponse: Mappable {
    var token: String?
    var expiredAt: String?

    convenience required init?(map: Map) {
        self.init()
        mapping(map: map)
    }

    func mapping(map: Map) {
        token <- map["token"]
        expiredAt <- map["expired_at"]
    }
}
