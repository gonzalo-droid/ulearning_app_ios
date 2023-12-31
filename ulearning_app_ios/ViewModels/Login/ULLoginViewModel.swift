//
//  ULLoginViewModel.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 23/07/23.
//

import Foundation

class ULLoginViewmodel {
    
    var isLoadingData: ULObservable<Bool> = ULObservable(false)
    var dataSource: String?
    var tokenLogin: ULObservable<String> = ULObservable(nil)
    
    
    func sendLogin(username:String, password:String) {
        if isLoadingData.value ?? true {
            return
        }
        
        isLoadingData.value = true
        
        let params: [String:Any] = [
            "email":username,
            "password": password,
        ]
        
        
        AuthService.login(params, successBlock: { [weak self] tokenLogin, expiredAt in
            guard let self = self else { return }
            self.dataSource = tokenLogin
            self.mapData()
            isLoadingData.value = false
            
        }, errorBlock: { [weak self] error in
            guard let self = self else { return }
            isLoadingData.value = false
        })
        
    }
    
    func sendLoginGoogle(
        username:String?,
        email:String?,
        familyName:String = "",
        givenName:String = ""
    ) {
        if isLoadingData.value ?? true {
            return
        }
        
        isLoadingData.value = true
        
        let params: [String:Any] = [
            "email":email ?? "",
            "name": username ?? "",
            "family_name": familyName,
            "given_name": givenName,
        ]
        
        
        AuthService.loginGoogle(params, successBlock: { [weak self] tokenLogin, expiredAt in
            guard let self = self else { return }
            self.dataSource = tokenLogin
            self.mapData()
            isLoadingData.value = false
            debugPrint("Success AuthService.loginGoogle")

        }, errorBlock: { [weak self] error in
            guard let self = self else { return }
            isLoadingData.value = false
        })
        
    }
    
    func sendLoginFacebook(
        username:String,
        email:String,
        familyName:String = "",
        givenName:String = ""
    ) {
        if isLoadingData.value ?? true {
            return
        }
        
        isLoadingData.value = true
        
        let params: [String:Any] = [
            "email":email,
            "name": username,
            "family_name": familyName,
            "given_name": givenName,
        ]
        
        
        AuthService.loginFacebook(params, successBlock: { [weak self] tokenLogin, expiredAt in
            guard let self = self else { return }
            self.dataSource = tokenLogin
            self.mapData()
            isLoadingData.value = false
            
        }, errorBlock: { [weak self] error in
            guard let self = self else { return }
            isLoadingData.value = false
        })
        
    }
    
    private func mapData() {
        tokenLogin.value = self.dataSource
    }
    
}
