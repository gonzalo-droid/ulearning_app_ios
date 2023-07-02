//
//  ULAPICourse.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 29/06/23.
//

import Alamofire
import SwiftyJSON

enum ULAPICourse: ApiConfig {
        
    var urlBase: String {
        return "https://www.sandbox.api.ulearning.com.pe/api/"
    }
    /// GET

    case getSubscriptions(
        perPage: Int,
        page: Int,
        isFinished: Bool
    )
    
    case getSubscriptionsPackage(
        perPage: Int,
        page: Int,
        classification: String,
        includes: String = "learning_package"
    )

    case getLearningPackage(
        learningPackageId: Int,
        includes: String = "learning_package,learning_package_items,course"
    )

    case getCoursePercentage(
        courseIds: String
    )
    
    /// POST
    
    case myCertificates(
        subscriptionId: Int // subscriptionId: String
    )
    

    case showGuestFile(
        parameter: Parameters
    )
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case  .myCertificates(_):
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

    var queryItems: [URLQueryItem]? {
        switch self {
        case .getSubscriptions(let perPage, let page, let isFinished):
            var urlComponents = URLComponents()
             urlComponents.queryItems = [
                 URLQueryItem(name: "per_page", value: "\(perPage)"),
                 URLQueryItem(name: "page", value: "\(page)"),
                 URLQueryItem(name: "is_finished", value: "\(isFinished)")
             ]
            return urlComponents.queryItems

        default:
            return nil
        }
    }
    

    var path: String {
        switch self {
        
        case .getSubscriptions(perPage: let perPage, page: let page, isFinished: let isFinished):
            var urlComponents = URLComponents()
             urlComponents.queryItems = [
                 URLQueryItem(name: "per_page", value: "\(perPage)"),
                 URLQueryItem(name: "page", value: "\(page)"),
                 URLQueryItem(name: "is_finished", value: "\(isFinished)")
             ]
            return "subscriptions\(urlComponents.string!)"
            
        case .getSubscriptionsPackage(perPage: let perPage, page: let page, classification: let classification, includes: let includes):
            return "subscriptions?per_page=\(perPage)&page=\(page)&classification=\(classification)&includes=\(includes)"

        case .getLearningPackage(learningPackageId: let learningPackageId, includes: let includes):
            return "learning-packages/\(learningPackageId)/subscriptions?&includes=\(includes)"
        
        case .getCoursePercentage(courseIds: let courseIds):
            return "courses-advances?&course_ids=\(courseIds)"
        
        case .myCertificates(subscriptionId: let subscriptionId):
            return "my-certificates/{\(subscriptionId)"
        
        case .showGuestFile(_):
            return "show-guest-file"
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
