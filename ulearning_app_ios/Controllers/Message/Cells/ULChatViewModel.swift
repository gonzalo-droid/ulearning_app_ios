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
    
    func getMessageItems(uuid:String){
        
        if isLoadingData.value ?? true {
            return
        }
        
        isLoadingData.value = true
        
        MessageService.getMessageItems(uuid: uuid,  successBlock: { [weak self] messages in
            guard let self = self else { return }
            debugPrint("counts items \(messages?.count)")
            self.dataSource = messages
            self.mapData()
        }, errorBlock: { [weak self] error in
            guard let self = self else { return }
        })
    }
    
    private func mapData() {
        messages.value = self.dataSource?.compactMap({ULMessageItemTableCellViewModel(message: $0)})
    }
    
}
