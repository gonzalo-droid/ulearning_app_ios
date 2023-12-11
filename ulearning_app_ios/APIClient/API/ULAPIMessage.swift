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
        perPage: Int = 100,
        page: Int = 1,
        toSupport: Bool = false,
        includes: String = "first_message"
    )
    
    case getMessageByCourse(
        perPage: Int = 100,
        page: Int = 1,
        courseID: Int,
        includes: String = "first_message"
    )
    
    case getMessageItems(
        uuid: String
    )
    
    
    /// POST

    case sendConversationSupport(
        params: Parameters
    )
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case  .sendConversationSupport(_):
            return .post
        default:
            return .get
        }
    }

    var path: String {
        switch self {
        case .getMessageByCourse(perPage: let perPage, page: let page,courseID: let courseID, includes: let includes):
            var urlComponents = URLComponents()
            urlComponents.queryItems = [
                URLQueryItem(name: "per_page", value: "\(perPage)"),
                URLQueryItem(name: "page", value: "\(page)"),
                URLQueryItem(name: "course_id", value: "\(courseID)"),
                URLQueryItem(name: "includes", value: "\(includes)")
            ]
            return "conversations\(urlComponents.string!)"
            
        case .getMessageSupport(perPage: let perPage, page: let page,toSupport: let toSupport, includes: let includes):
            var urlComponents = URLComponents()
            urlComponents.queryItems = [
                URLQueryItem(name: "per_page", value: "\(perPage)"),
                URLQueryItem(name: "page", value: "\(page)"),
                URLQueryItem(name: "to_support", value: "\(toSupport)"),
                URLQueryItem(name: "includes", value: "\(includes)")
            ]
            return "conversations\(urlComponents.string!)"
            
        case .sendConversationSupport:
            return "messages"
        case .getMessageItems(uuid: let uuid):
            return "messages/\(uuid)"
        }
    }
    
    var parameters: Parameters? {
           switch self {
           case .sendConversationSupport(let parameters):
               return parameters
           default:
               return nil
           }
       }
    
    var encoding: Alamofire.ParameterEncoding? {
          switch self {
          case .sendConversationSupport:
              return Alamofire.JSONEncoding.default
          default:
              return URLEncoding.default
          }
      }


    func asURLRequest() throws -> URLRequest {
        return self.asURLRequest(baseURL: urlBase)
    }
        
}
