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
    
    case selfAuthToken

    var method: Alamofire.HTTPMethod {
        switch self {
        case .login, .selfAuthToken:
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
        case .selfAuthToken:
            return "self-auth-token"
        }
    }

    var parameters: Parameters? {
           switch self {
           case .login(let parameters):
               return parameters
           default:
               return nil
           }
       }
    
    var encoding: Alamofire.ParameterEncoding? {
          switch self {
          case .login:
              return Alamofire.JSONEncoding.default
          default:
              return URLEncoding.default
          }
      }


    func asURLRequest() throws -> URLRequest {
        return self.asURLRequest(baseURL: urlBase)
    }

}
