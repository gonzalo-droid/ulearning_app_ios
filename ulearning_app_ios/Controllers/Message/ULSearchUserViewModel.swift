//
//  ULSearchUserViewModel.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 2/01/24.
//

import Foundation

class ULSearchUserViewModel {
    
    var isLoadingData: ULObservable<Bool> = ULObservable(false)
    var dataSource: [ULUser]?
    var users: ULObservable<[ULSearchUserTableCellViewModel]> = ULObservable(nil)

    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(in section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    
    func getData(courseID: Int) {
        if isLoadingData.value ?? true {
            return
        }
        
        isLoadingData.value = true
                
        AuthService.getUsers(name: "", courseID: courseID, successBlock: { [weak self] users in
            guard let self = self else { return }
            self.dataSource = users
            self.mapData()
            isLoadingData.value = false
        }, errorBlock: { [weak self] error in
            guard let self = self else { return }
            isLoadingData.value = false
        })
    }

    private func mapData() {
        users.value = self.dataSource?.compactMap({ULSearchUserTableCellViewModel(user: $0)})
    }
    
    func retriveUser(withId id: Int) -> ULUser? {
        guard let data = dataSource?.first(where: {$0.id == id}) else {
            return nil
        }
        return data
    }
}

