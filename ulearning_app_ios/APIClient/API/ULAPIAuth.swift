//
//  ULAuth.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 20/07/23.
//

import Alamofire
import SwiftyJSON

enum ULAPIAuth: ULAPIConfig {
        
    var urlBase: String {
        return "https://sandbox.api.ulearning.com.pe/api/"
    }
    
    /// GET


    case getProfile
    
    
    /// POST
    
    case login
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case  .login:
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
