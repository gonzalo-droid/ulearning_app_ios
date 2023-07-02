//
//  ULGroup.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 1/07/23.
//

import Foundation
import ObjectMapper

class ULGroup:Mappable{
    var course: ULCourse?
    var courseId: Int?
    var dateStart: String?
    var dateUntil: String?
    var id: Int?
    var isSuspended: Bool?
    var isUnlimited: Bool?
    var membersCount: Int?
    var name: String?
    var studentsCount: Int?
    var teachers: [ULTeacher] = []
    var teachersCount: Int?
    var vacancies: Int?
    
    convenience required init?(map: Map) {
        self.init()
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        course <- map["course"]
        courseId <- map["course_id"]
        dateStart <- map["date_start"]
        dateUntil <- map["date_until"]
        id <- map["id"]
        isSuspended <- map["is_suspended"]
        isUnlimited <- map["is_unlimited"]
        membersCount <- map["members_count"]
        name <- map["name"]
        studentsCount <- map["students_count"]
        teachers <- map["teachers"]
        teachersCount <- map["teachers_count"]
        vacancies <- map["vacancies"]
    }
    
    
}
