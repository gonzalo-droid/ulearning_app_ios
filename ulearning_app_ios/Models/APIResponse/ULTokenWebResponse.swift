//
//  ULTokenWebResponse.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 25/07/23.
//

import Foundation
import ObjectMapper

class ULToken: Mappable{
    
    var token: String?
    
    convenience required init?(map: Map) {
        self.init()
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        token <- map["token"]
    }
    
}

class ULTokenWebResponse: Mappable {
    var data: ULToken?
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



