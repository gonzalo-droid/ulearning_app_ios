//
//  ULLearningPackageItem.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 1/07/23.
//

import Foundation
import ObjectMapper


class ULLearningPackageItem: Mappable{
    
    var course: ULCourse?
    var courseId: Int?
    var id: Int?
    var isRequired: Bool = false
    var learningPackageId: Int?
    
    convenience required init?(map: Map) {
        self.init()
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        course <- map["course"]
        courseId <- map["courseId"]
        id <- map["id"]
        isRequired <- map["isRequired"]
        learningPackageId <- map["learningPackageId"]
    }
    
}
