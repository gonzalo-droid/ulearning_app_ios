//
//  ULMessageItemTableCellViewModel.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 8/12/23.
//

import Foundation
class ULMessageItemTableCellViewModel {
    var id: Int
    var content: String
    var name: String
    var publishedAt: String
    
    init(message: ULMessageItem) {
        self.id = message.id ?? 0
        self.content = message.content ?? ""
        self.name = message.sendBy?.name ?? ""
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let fromtDateFormat = message.publishedAt ?? ""
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
