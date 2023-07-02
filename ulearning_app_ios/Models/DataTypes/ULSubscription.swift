//
//  ULSubscription.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 1/07/23.
//

import Foundation
import ObjectMapper

class ULSubscription: Mappable {
    var amount: Int?
    var billingId: Int?
    var courseId: Int = 0
    var groupId: Int?
    var hasCertificate: Bool?
    var hasDegree: Bool?
    var hasRecord: Bool?
    var id: Int?
    var isFinished: Bool?
    var lastConnectionAt: String?
    var nextPaymentDate: String?
    var purchasedCertificate: Bool?
    var purchasedRecord: Bool?
    var registeredBy: Int?
    var status: String?
    var timeSession: Int?
    var type: String?
    var userId: Int?
    var classification: String?
    var learningPackageId: Int?
    var userResponse: ULUser?
    var learningPackage: ULLearningPackage?
    var course: ULCourse?
    var group: ULGroup?

    convenience required init?(map: Map) {
        self.init()
        mapping(map: map)
    }

    func mapping(map: Map) {
        amount <- map["amount"]
        billingId <- map["billing_id"]
        course <- map["course"]
        courseId <- map["course_id"]
        group <- map["group"]
        groupId <- map["group_id"]
        hasCertificate <- map["has_certificate"]
        hasDegree <- map["has_degree"]
        hasRecord <- map["has_record"]
        id <- map["id"]
        isFinished <- map["is_finished"]
        lastConnectionAt <- map["last_connection_at"]
        nextPaymentDate <- map["next_payment_date"]
        purchasedCertificate <- map["purchased_certificate"]
        purchasedRecord <- map["purchased_record"]
        registeredBy <- map["registered_by"]
        status <- map["status"]
        timeSession <- map["time_session"]
        type <- map["type"]
        userResponse <- map["user"]
        userId <- map["user_id"]
        classification <- map["classification"]
        learningPackage <- map["learning_package"]
        learningPackageId <- map["learning_package_id"]
    }
}
