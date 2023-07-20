//
//  ULProfileViewModel.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 20/07/23.
//

import Foundation

class ULProfileViewModel {
    
    var isLoadingData: ULObservable<Bool> = ULObservable(false)
    var dataSource: ULProfile?
    var profile: ULObservable<ULProfile> = ULObservable(nil)
    
    func getData() {
        if isLoadingData.value ?? true {
            return
        }
        
        isLoadingData.value = true
        
        AthService.getProfile(successBlock: { [weak self] profile in
            guard let self = self else { return }
            self.dataSource = profile
            self.mapData()
            isLoadingData.value = false
            
        }, errorBlock: { [weak self] error in
            guard let self = self else { return }
            
            isLoadingData.value = false
        })
    }
    
    private func mapData() {
        profile.value = self.dataSource
    }
    
}
