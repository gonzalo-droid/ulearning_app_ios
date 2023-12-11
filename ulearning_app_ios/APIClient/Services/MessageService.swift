//
//  MessageService.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 27/08/23.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class MessageService {
    
    static func getMessageByCourse(
        page: Int,
        courseID: Int,
        successBlock: @escaping(_ conversations: [ULConversation]?) -> Void,
        errorBlock: @escaping(_ error:  String?) -> Void
    ) {
        
        let pathUrl: ULAPIMessage = .getMessageByCourse(
            perPage: 50,
            page: page,
            courseID: courseID
        )
        
        AF.request(pathUrl).validate(statusCode: 200..<205).responseObject {
            (response: DataResponse<ULMessagesSupportResponse, AFError>) in
            
            switch response.result {
            case .success(let value):
                if value.message == nil {
                    if let subs = value.data {
                        successBlock(subs)
                    } else {
                        errorBlock("Data is nil")
                    }
                } else {
                    errorBlock(value.message ?? "ERROR AQUI")
                }
            case .failure(let error):
                errorBlock(error.localizedDescription)
            }
        }
    }
    
    
    
    static func getMessageSupport(
        page: Int,
        toSupport: Bool,
        successBlock: @escaping(_ conversations: [ULConversation]?) -> Void,
        errorBlock: @escaping(_ error:  String?) -> Void
    ) {
        
        let pathUrl: ULAPIMessage = .getMessageSupport(
            perPage: 50,
            page: page,
            toSupport: toSupport
        )
        
        AF.request(pathUrl).validate(statusCode: 200..<205).responseObject {
            (response: DataResponse<ULMessagesSupportResponse, AFError>) in
            
            switch response.result {
            case .success(let value):
                if value.message == nil {
                    if let subs = value.data {
                        successBlock(subs)
                    } else {
                        errorBlock("Data is nil")
                    }
                } else {
                    errorBlock(value.message ?? "ERROR AQUI")
                }
            case .failure(let error):
                errorBlock(error.localizedDescription)
            }
        }
    }
    
    static func sendMessageSupport(
        _ params: Parameters,
        successBlock: @escaping(_ conversation: ULConversation?) -> Void,
        errorBlock: @escaping(_ error:  String?) -> Void
    ) {
        
        let pathUrl: ULAPIMessage = .sendConversationSupport(params: params)
        
        AF.request(pathUrl).validate(statusCode: 200..<205).responseObject {
            (response: DataResponse<ULMessageSupportResponse, AFError>) in
            
            switch response.result {
            case .success(let value):
                if value.message == nil {
                    if let d = value.data {
                         successBlock(d)
                    } else {
                        errorBlock("Data is nil")
                    }
                } else {
                    errorBlock(value.message ?? "ERROR AQUI")
                }
            case .failure(let error):
                errorBlock(error.localizedDescription)
            }
        }
    }
    
    static func getMessageItems(
        uuid: String,
        successBlock: @escaping(_ messages: [ULMessageItem]?) -> Void,
        errorBlock: @escaping(_ error:  String?) -> Void
    ) {
        
        let pathUrl: ULAPIMessage = .getMessageItems(uuid: uuid)
        
        AF.request(pathUrl).validate(statusCode: 200..<205).responseObject {
            (response: DataResponse<ULMessageItemsResponse, AFError>) in
            
            switch response.result {
            case .success(let value):
                if value.message == nil {
                    if let subs = value.data {
                        successBlock(subs)
                    } else {
                        errorBlock("Data is nil")
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
