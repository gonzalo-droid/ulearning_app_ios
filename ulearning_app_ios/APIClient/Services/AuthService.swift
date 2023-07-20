//
//  AuthService.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 20/07/23.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class AthService {
    
    static func getProfile(
        successBlock: @escaping(_ profile: ULProfile?) -> Void,
        errorBlock: @escaping(_ error:  String?) -> Void
    ) {
        
        let pathUrl: ULAPIAuth = .getProfile
        
        AF.request(pathUrl).validate(statusCode: 200..<205).responseObject {
            (response: DataResponse<BaseResponseProfile, AFError>) in
            
            switch response.result {
            case .success(let value):
                if value.message == nil {
                    if let subs = value.data {
                        successBlock(subs)
                    } else {
                        errorBlock("Profile data is nil")
                    }
                } else {
                    errorBlock(value.message ?? "ERROR AQUI")
                }
            case .failure(let error):
                errorBlock(error.localizedDescription)
            }
        }
    }
    
}

