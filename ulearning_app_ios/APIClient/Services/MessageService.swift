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
}

/*
 @GET("conversations")
 suspend fun conversationsSupport(
     @Header(SettingRemote.AUTHORIZATION) token: String,
     @Query("per_page") perPage: Int,
     @Query("page") page: Int,
     @Query("to_support") toSupport: Boolean,
     @Query("includes") includes: String = "first_message",
 ): Response<BaseResponse<List<ConversationResponse>>>
 
 */
