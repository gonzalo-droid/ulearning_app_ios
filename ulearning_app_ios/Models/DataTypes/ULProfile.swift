//
//  ULProfile.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 20/07/23.
//

import Foundation
import ObjectMapper

class ULProfile: Mappable {
    var address: String?
    var avatar: Any?
    var dateOfBirth: String?
    var documentNumber: String?
    var documentType: String?
    var email: String?
    var firstName: String?
    var gender: String?
    var id: Int?
    var lastName: String?
    var name: String?
    var phone: String?
    var phoneCode: String?
    var role: String?
    var secondLastName: String?
    
    convenience required init?(map: Map) {
        self.init()
        mapping(map: map)
    }
    
    func mapping(map: Map) {

        address <- map["address"]
        avatar <- map["avatar"]
        dateOfBirth <- map["date_of_birth"]
        documentNumber <- map["document_number"]
        documentType <- map["document_type"]
        email <- map["email"]
        firstName <- map["first_name"]
        gender <- map["gender"]
        id <- map["id"]
        lastName <- map["last_name"]
        name <- map["name"]
        phone <- map["phone"]
        phoneCode <- map["phone_code"]
        role <- map["role"]
        secondLastName <- map["second_last_name"]
    }
}
