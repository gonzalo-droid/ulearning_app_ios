//
//  ULCourse.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 1/07/23.
//

import Foundation
import ObjectMapper

class ULCourse:Mappable{
    
    var amount: Int?
    var asynchronousHour: String?
    var benefits: String?
    var category: ULCategory?
    var categoryId: Int?
    var certificate: Bool?
    var code: String?
    var currency: String?
    var descriptionLarge: String?
    var descriptionShort: String?
    var duration: String?
    var externalId: String?
    var externalLink: String?
    var groups: [ULGroup] = []
    var id: Int?
    var instructions: String?
    var isFree: Bool?
    var isPurchased: Bool?
    var isShop: Bool?
    var languageId: Int?
    var lessonsCount: Int?
    var mainImage: ULImage?
    var methodology: String?
    var modality: String?
    var nature: String?
    var origin: String?
    var politicsLink: String?
    var presentationLink: String?
    var ratingAverage: Int?
    var ratingCount: Int?
    var record: Bool?
    var scheduleLink: String?
    var selfStudyHour: Int?
    var slug: String?
    var studentsCount: Int?
    var syllabusLink: String?
    var synchronousHour: String?
    var target: String?
    var title: String?
    
    convenience required init?(map: Map) {
        self.init()
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        amount <- map["amount"]
        asynchronousHour <- map["asynchronous_hour"]
        benefits <- map["benefits"]
        category <- map["category"]
        categoryId <- map["category_id"]
        certificate <- map["certificate"]
        code <- map["code"]
        currency <- map["currency"]
        descriptionLarge <- map["description_large"]
        descriptionShort <- map["description_short"]
        duration <- map["duration"]
        externalId <- map["external_id"]
        externalLink <- map["external_link"]
        groups <- map["groups"]
        id <- map["id"]
        instructions <- map["instructions"]
        isFree <- map["is_free"]
        isPurchased <- map["is_purchased"]
        isShop <- map["is_shop"]
        languageId <- map["language_id"]
        lessonsCount <- map["lessons_count"]
        mainImage <- map["main_image"]
        methodology <- map["methodology"]
        modality <- map["modality"]
        nature <- map["nature"]
        origin <- map["origin"]
        politicsLink <- map["politics_link"]
        presentationLink <- map["presentation_link"]
        ratingAverage <- map["rating_average"]
        ratingCount <- map["rating_count"]
        record <- map["record"]
        scheduleLink <- map["schedule_link"]
        selfStudyHour <- map["self_study_hour"]
        slug <- map["slug"]
        studentsCount <- map["students_count"]
        syllabusLink <- map["syllabus_link"]
        synchronousHour <- map["synchronous_hour"]
        target <- map["target"]
        title <- map["title"]
    }
    
    
    func formatModality() -> String {
        switch modality {
        case "virtual":
            return "Virtual"
        case "onsite":
            return "En sitio"
        case "blend":
            return "Semipresencial"
        case "recorded":
            return "Grabado"
        case "online":
            return "Virtual"
        case "self_learning":
            return "Autoaprendizaje"
        case "teacher":
            return "Con docente"
        case "platform":
            return "En Plataforma"
        case "lms":
            return "LMS"
        default:
            return ""
        }
    }
}
