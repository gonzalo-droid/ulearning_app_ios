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
            debugPrint("Response Data: \(response.data)")
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
    
    static func loginGoogle(
        _ params: Parameters,
        successBlock: @escaping(_ tokenLogin: String, _ expiredAt:String) -> Void,
        errorBlock: @escaping(_ error:  String?) -> Void
    ) {
        
        let pathUrl: ULAPIAuth = .loginGoogle(params: params)
        
        AF.request(pathUrl).validate(statusCode: 200..<205).responseObject {
            (response: DataResponse<ULLoginResponse, AFError>) in
            debugPrint("Response Data: \(response.data?.description)")
            switch response.result {
            case .success(let value):
                if let tokenLogin = value.token {
                    ULUserStore().saveToken(token: tokenLogin)
                    let expiredAt = value.expiredAt ?? ""
                    debugPrint("Response Data: tokenLogin")

                    successBlock(tokenLogin, expiredAt)
                } else {
                    debugPrint("Response Data:Tuvimos problemas al inciar sesión")

                    errorBlock("Tuvimos problemas al inciar sesión")
                }
            case .failure(let error):
                debugPrint("Response Data: \(error.localizedDescription)")

                errorBlock(error.localizedDescription)
            }
        }
    }
    
    static func loginFacebook(
        _ params: Parameters,
        successBlock: @escaping(_ tokenLogin: String, _ expiredAt:String) -> Void,
        errorBlock: @escaping(_ error:  String?) -> Void
    ) {
        
        let pathUrl: ULAPIAuth = .loginFacebook(params: params)
        
        AF.request(pathUrl).validate(statusCode: 200..<205).responseObject {
            (response: DataResponse<ULLoginResponse, AFError>) in
            debugPrint("Response Data: \(response.data)")
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
    
    static func selfAuthToken(
        successBlock: @escaping(_ tokenWeb: String) -> Void,
        errorBlock: @escaping(_ error:  String?) -> Void
    ) {
        
        let pathUrl: ULAPIAuth = .selfAuthToken
        
        AF.request(pathUrl).validate(statusCode: 200..<205).responseObject {
            (response: DataResponse<ULTokenWebResponse, AFError>) in
            debugPrint("Response Data: \(response)")
            switch response.result {
            case .success(let value):
                if let tokenWeb = value.data?.token {
                    successBlock(tokenWeb)
                } else {
                    errorBlock("Tuvimos problemas al obtener la información")
                }
            case .failure(let error):
                errorBlock(error.localizedDescription)
            }
        }
    }
    
}

