//
//  ULChatViewModel.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 8/12/23.
//

import Foundation


class ULChatViewModel {
    
    var conversation: ULConversation
    var isLoadingData: ULObservable<Bool> = ULObservable(false)
    var title: String
    let urlStudent = "https://student.ulearning.com.pe"
    var dataSource: [ULMessageItem]?
    var messages: ULObservable<[ULMessageItemTableCellViewModel]> = ULObservable(nil)
    var messageItemResponse: ULObservable<ULMessageItem> = ULObservable(nil)
    var setUUID: ULObservable<String> = ULObservable("")
    
    
    var urlTopic: String?

    init(data: ULConversation) {
        self.conversation = data
        self.title =  ""
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(in section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    
    func sendMessageSupport(uuid:String, content:String){
        if isLoadingData.value ?? true {
            return
        }
        
        isLoadingData.value = true
        
        let params: [String:Any] = [
            "content":content,
            "uuid":uuid,
            "to_support": false,
            "user_ids": [],
        ]

        MessageService.sendMessageItems(params,successBlock: { [weak self] messageItem in
            guard let self = self else { return }
            self.messageItemResponse.value = messageItem
            if uuid == messageItem?.uuid {
                setUUID.value = uuid
                debugPrint("counts uuid \(uuid)")

            }
            isLoadingData.value = false
            
        }, errorBlock: { [weak self] error in
            guard let self = self else { return }
            isLoadingData.value = false
        })
        
    }
    
    func getMessageItems(uuid:String){
        
        if isLoadingData.value ?? true {
            return
        }
        
        isLoadingData.value = true
        
        MessageService.getMessageItems(uuid: uuid,  successBlock: { [weak self] messages in
            guard let self = self else { return }
            isLoadingData.value = false
            debugPrint("counts items \(messages?.count)")
            self.dataSource = messages?.reversed()
            
            self.mapData()
        }, errorBlock: { [weak self] error in
            guard let self = self else { return }
        })
    }
    
    private func mapData() {
        messages.value = self.dataSource?.compactMap({ULMessageItemTableCellViewModel(message: $0)})
    }
    
}
