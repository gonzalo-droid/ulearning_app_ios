//
//  ULAuth.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 20/07/23.
//

import Alamofire
import SwiftyJSON

enum ULAPIAuth: ULAPIConfig {
    
    
    /// GET
    
    
    case getProfile
    
    
    /// POST
    
    case login(
        params: Parameters
    )
    
    case loginGoogle(
        params: Parameters
    )
    
    case loginFacebook(
        params: Parameters
    )
    
    case selfAuthToken
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .login, .loginGoogle, .loginFacebook, .selfAuthToken:
            return .post
        default:
            return .get
        }
    }
    
    
    var path: String {
        switch self {
        case .getProfile:
            return "profile"
        case .login:
            return "login"
        case .loginGoogle:
            return "login-google"
        case .loginFacebook:
            return "login-facebook"
        case .selfAuthToken:
            return "self-auth-token"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .login(let parameters), .loginGoogle(let parameters), .loginFacebook(let parameters):
            return parameters
        default:
            return nil
        }
    }
    
    var encoding: Alamofire.ParameterEncoding? {
        switch self {
        case .login, .loginGoogle, .loginFacebook:
            return Alamofire.JSONEncoding.default
        default:
            return URLEncoding.default
        }
    }
    
    
    func asURLRequest() throws -> URLRequest {
        return self.asURLRequest(baseURL: urlBase)
    }
    
}
