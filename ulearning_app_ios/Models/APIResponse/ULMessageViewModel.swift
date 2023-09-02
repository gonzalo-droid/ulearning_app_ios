//
//  ULMessageViewModel.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 27/08/23.
//

import Foundation

class ULMessageSupportViewModel {
    
    var dataSource: [ULConversation]?
    var conversations: ULObservable<[ULMessageTableCellViewModel]> = ULObservable(nil)
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(in section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    
    func getData() {
        MessageService.getMessageSupport(page: 1, toSupport: true, successBlock: { [weak self] conversations in
            guard let self = self else { return }
            self.dataSource = conversations
            self.mapData()
        }, errorBlock: { [weak self] error in
            guard let self = self else { return }
        })
    }
    
    
    private func mapData() {
        conversations.value = self.dataSource?.compactMap({ULMessageTableCellViewModel(conversation: $0)})
    }
}
