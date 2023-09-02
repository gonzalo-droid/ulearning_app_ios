//
//  ULMessageTableCellViewModel.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 27/08/23.
//

import Foundation

class ULMessageTableCellViewModel {
    var id: Int
    var content: String
    var publishedAt: String
    
    init(conversation: ULConversation) {
        self.id = conversation.id ?? 0
        self.content = conversation.firstMessage?.content ?? ""
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let fromtDateFormat = conversation.firstMessage?.publishedAt ?? ""
        if let inputDate = inputFormatter.date(from: fromtDateFormat) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "dd/MM/yyyy hh:mm a"
            
            let outputDateString = outputFormatter.string(from: inputDate)
            self.publishedAt = outputDateString
        } else {
            self.publishedAt = ""
            print("Invalid date format")
        }
        
    }
}
