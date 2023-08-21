//
//  ULBaseResponseCoursePercentage.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 20/08/23.
//

import Foundation
import ObjectMapper

class ULCoursePercentageResponse: Mappable {
    var data: [ULCoursePercentage]?
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
