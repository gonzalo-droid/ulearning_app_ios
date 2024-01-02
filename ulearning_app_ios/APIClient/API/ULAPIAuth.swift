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
    // /api/users?name=&course_id=22&without_pagination=true
    case getUsers(
        name: String = "",
        course_id: Int,
        without_pagination: Bool = true
    )
    
    case getProfile
    
    
    /// POST
    ///
    
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
        case .getUsers(name: let name, course_id: let course_id, without_pagination: let without_pagination):
            var urlComponents = URLComponents()
            urlComponents.queryItems = [
                URLQueryItem(name: "name", value: "\(name)"),
                URLQueryItem(name: "course_id", value: "\(course_id)"),
                URLQueryItem(name: "without_pagination", value: "\(without_pagination)")
            ]
            return "users\(urlComponents.string!)"
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
