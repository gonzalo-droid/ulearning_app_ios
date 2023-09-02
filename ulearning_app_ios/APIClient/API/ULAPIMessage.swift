//
//  ULAPIMessage.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 27/08/23.
//

import Alamofire
import SwiftyJSON

enum ULAPIMessage: ULAPIConfig {

    /// GET

    case getMessageSupport(
        perPage: Int = 50,
        page: Int = 1,
        toSupport: Bool = false,
        includes: String = "first_message"
    )
    
    /// POST

    case showGuestFile(
        parameter: Parameters
    )
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case  .showGuestFile(_):
            return .post
        default:
            return .get
        }
    }

    var parameters: Parameters? {
        switch self {
        case .showGuestFile(let params):
            return params
        default:
            return nil
        }
    }

    var path: String {
        switch self {
            
        case .getMessageSupport(perPage: let perPage, page: let page,toSupport: let toSupport, includes: let includes):
            var urlComponents = URLComponents()
            urlComponents.queryItems = [
                URLQueryItem(name: "per_page", value: "\(perPage)"),
                URLQueryItem(name: "page", value: "\(page)"),
                URLQueryItem(name: "to_support", value: "\(toSupport)"),
                URLQueryItem(name: "includes", value: "\(includes)")
            ]
            return "conversations\(urlComponents.string!)"
            
        case .showGuestFile(parameter: let parameter):
            return "conversations"
        }
    }
    var encoding: Alamofire.ParameterEncoding? {
          switch self {
          case .showGuestFile:
              return Alamofire.JSONEncoding.default
          default:
              return URLEncoding.default
          }
      }


    func asURLRequest() throws -> URLRequest {
        return self.asURLRequest(baseURL: urlBase)
    }
        
}
