//
//  ULAddMessageSupportViewModel.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 14/09/23.
//

class ULAddMessageSupportViewModel {
    
    var isLoadingData: ULObservable<Bool> = ULObservable(false)
    var courseId: Int?
    var typeMessage: String?
    var userIds: [Int] = []
    var conversationResponse: ULObservable<ULConversation> = ULObservable(nil)
    
    init(typeMessage: String?, courseId:Int?, userIds:[Int]) {
        self.typeMessage = typeMessage ?? ""
        self.userIds = userIds
        self.courseId = courseId ?? nil
    }
    
    func sendMessage(content:String, toSupport:Bool = true, courseID:String? = nil) {
        if isLoadingData.value ?? true {
            return
        }
        
        isLoadingData.value = true

        var params: [String:Any] = [
            "content":content,
            "to_support": toSupport,
            "user_ids": userIds,
            "course_id": courseID,
        ]
        
        if(toSupport){
            params.removeValue(forKey: "course_id")
        }
        
        MessageService.sendMessageSupport(params,successBlock: { [weak self] conversation in
            guard let self = self else { return }
            self.conversationResponse.value = conversation
            isLoadingData.value = false
            
        }, errorBlock: { [weak self] error in
            guard let self = self else { return }
            isLoadingData.value = false
        })
        
    }
}
