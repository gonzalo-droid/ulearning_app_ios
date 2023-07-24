//
//  AuthService.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 20/07/23.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class AuthService {
    
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
    
    
    static func login(
        _ params: Parameters,
        successBlock: @escaping(_ tokenLogin: String, _ expiredAt:String) -> Void,
        errorBlock: @escaping(_ error:  String?) -> Void
    ) {
        
        let pathUrl: ULAPIAuth = .login(params: params)
        
        AF.request(pathUrl).validate(statusCode: 200..<205).responseObject {
            (response: DataResponse<ULLoginResponse, AFError>) in
            debugPrint("Response Data: \(response)")
            switch response.result {
            case .success(let value):
                if let tokenLogin = value.token {
                    ULUserStore().saveToken(token: tokenLogin)
                    let expiredAt = value.expiredAt ?? ""
                    successBlock(tokenLogin, expiredAt)
                } else {
                    errorBlock("Tuvimos problemas al inciar sesión")
                }
            case .failure(let error):
                errorBlock(error.localizedDescription)
            }
        }
    }
    
}

