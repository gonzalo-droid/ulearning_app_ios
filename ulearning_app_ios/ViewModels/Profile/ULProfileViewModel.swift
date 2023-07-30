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
    var dataSourceTokenWeb: String?
    
    var profile: ULObservable<ULProfile> = ULObservable(nil)
    var webPayment: ULObservable<String> = ULObservable(nil)
    
    let urlStudent = "https://student.ulearning.com.pe"

    
    func getData() {
        if isLoadingData.value ?? true {
            return
        }
        
        isLoadingData.value = true
        
        AuthService.getProfile(successBlock: { [weak self] profile in
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
    
    
    func getTokenWeb() {
        if isLoadingData.value ?? true {
            return
        }
        
        isLoadingData.value = true
        
        AuthService.selfAuthToken(successBlock: { [weak self] tokenWeb in
            guard let self = self else { return }
            self.dataSourceTokenWeb = tokenWeb
            
            webPayment.value = "\(urlStudent)/sessions/signin-token/\(tokenWeb)?return=/payments"
            
            isLoadingData.value = false
            
        }, errorBlock: { [weak self] error in
            guard let self = self else { return }
            
            isLoadingData.value = false
        })
    }
    
    private func redirectPayments() {
        webPayment.value = "\(urlStudent)/sessions/signin-token/\(String(describing: self.dataSourceTokenWeb))?return=/payments"
    }
    
}
