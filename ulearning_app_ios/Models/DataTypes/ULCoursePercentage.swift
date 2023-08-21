//
//  ULCoursePercentage.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 20/08/23.
//

import Foundation
import ObjectMapper

class ULCoursePercentage:Mappable{
    
    var courseId: Int?
    var percentage: String?
    
    convenience required init?(map: Map) {
        self.init()
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        courseId <- map["course_id"]
        percentage <- map["percentage"]
    }
}
