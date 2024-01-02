//
//  ULSearchUserTableCellViewModel.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 2/01/24.
//

import Foundation

class ULSearchUserTableCellViewModel {
    var id: Int
    var name: String
    
    init(user: ULUser) {
        self.id = user.id ?? 0
        self.name = user.name ?? ""
    }
}
