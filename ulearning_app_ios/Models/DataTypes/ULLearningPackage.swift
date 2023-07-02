//
//  ULLearningPackage.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 1/07/23.
//

import Foundation
import ObjectMapper


class ULLearningPackage:Mappable{
    
    var amount: String?
    var code: String?
    var descriptionLarge: String?
    var descriptionShort: String?
    var id: Int?
    var isShop: Bool?
    var mainImage: ULImage?
    var title: String?
    var type: String?
    var items: [ULLearningPackageItem] = []
    
    convenience required init?(map: Map) {
        self.init()
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        amount <- map["amount"]
        code <- map["code"]
        descriptionLarge <- map["description_large"]
        descriptionShort <- map["description_short"]
        id <- map["id"]
        isShop <- map["is_shop"]
        mainImage <- map["main_image"]
        title <- map["title"]
        type <- map["type"]
        items <- map["items"]
    }
    
    
}
