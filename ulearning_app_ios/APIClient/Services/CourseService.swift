//
//  CourseService.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 30/06/23.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class CourseService {
    
    static func getSubscriptions(
        page: Int,
        isFinished: Bool,
        successBlock: @escaping(_ subscriptions: [ULSubscription]?) -> Void,
        errorBlock: @escaping(_ error:  String?) -> Void
    ) {
        
        let pathUrl: ULAPICourse = .getSubscriptions(
            perPage: 50,
            page: page,
            isFinished: isFinished
        )
        
        AF.request(pathUrl).validate(statusCode: 200..<205).responseObject {
            (response: DataResponse<BaseResponseSubscription, AFError>) in
            
            switch response.result {
            case .success(let value):
                if value.message == nil {
                    if let subs = value.data {
                        successBlock(subs)
                    } else {
                        errorBlock("Subscriptions data is nil")
                    }
                } else {
                    errorBlock(value.message ?? "ERROR AQUI")
                }
            case .failure(let error):
                errorBlock(error.localizedDescription)
            }
        }
    }
    
    static func getSubscriptionsPackage(
        classification: String,
        successBlock: @escaping(_ subscriptions: [ULSubscription]?) -> Void,
        errorBlock: @escaping(_ error:  String?) -> Void
    ) {
        
        let pathUrl: ULAPICourse = .getSubscriptionsPackage(classification: classification)
        
        AF.request(pathUrl).validate(statusCode: 200..<205).responseObject {
            (response: DataResponse<BaseResponseSubscription, AFError>) in
            
            switch response.result {
            case .success(let value):
                if value.message == nil {
                    if let subs = value.data {
                        successBlock(subs)
                    } else {
                        errorBlock("Subscriptions data is nil")
                    }
                } else {
                    errorBlock(value.message ?? "ERROR AQUI")
                }
            case .failure(let error):
                errorBlock(error.localizedDescription)
            }
        }
    }
    
    static func getTopics(
        courseId: Int,
        successBlock: @escaping(_ topics: [ULTopic]?) -> Void,
        errorBlock: @escaping(_ error:  String?) -> Void
    ) {
        
        let pathUrl: ULAPICourse = .getTopicsByCourse(courseId: courseId)
        
        AF.request(pathUrl).validate(statusCode: 200..<205).responseObject {
            (response: DataResponse<ULTopicResponse, AFError>) in
            
            switch response.result {
            case .success(let value):
                if value.message == nil {
                    if let subs = value.data {
                        successBlock(subs)
                    } else {
                        errorBlock("Topics data is nil")
                    }
                } else {
                    errorBlock(value.message ?? "ERROR AQUI")
                }
            case .failure(let error):
                errorBlock(error.localizedDescription)
            }
        }
    }
    
    static func getCoursePercentages(
        courseIds: String,
        successBlock: @escaping(_ topics: [ULCoursePercentage]?) -> Void,
        errorBlock: @escaping(_ error:  String?) -> Void
    ) {
        
        let pathUrl: ULAPICourse = .getCoursePercentage(courseIds: courseIds)
        
        AF.request(pathUrl).validate(statusCode: 200..<205).responseObject {
            (response: DataResponse<ULCoursePercentageResponse, AFError>) in
            
            switch response.result {
            case .success(let value):
                if value.message == nil {
                    if let subs = value.data {
                        successBlock(subs)
                    } else {
                        errorBlock("data is nil")
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
