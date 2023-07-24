//
//  ULUserStore.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 23/07/23.
//

import Foundation

class ULUserStore {
    
    public func saveRole(role:String){
        let defaults = UserDefaults.standard
        defaults.set(role, forKey: "role")
    }
    public func getRole() -> String?{
        let defaults = UserDefaults.standard
        debugPrint("Role \(defaults.object(forKey: "role") ?? "")")
        return defaults.object(forKey: "role") as? String
    }
    
    public func saveUserName(name:String){
        let defaults = UserDefaults.standard
        defaults.set(name, forKey: "username")
    }
    public func getUserName() -> String?{
        let defaults = UserDefaults.standard
        debugPrint("UserName \(defaults.object(forKey: "username") ?? "")")
        return defaults.object(forKey: "username") as? String
    }
    
    public func saveUserId(userId:Int){
        let defaults = UserDefaults.standard
        defaults.set(userId, forKey: "userId")
    }
    public func getUserId() -> Int?{
        let defaults = UserDefaults.standard
        debugPrint("UserId \(defaults.object(forKey: "userId") ?? "")")
        return defaults.object(forKey: "userId") as? Int
    }
    
    public func saveToken(token:String){
        let defaults = UserDefaults.standard
        defaults.set(token, forKey: "token")
    }

    public func getToken() -> String?{
        let defaults = UserDefaults.standard
        debugPrint("Token \(defaults.object(forKey: "token") ?? "")")
        return defaults.object(forKey: "token") as? String
    }

    public func logout(completion: @escaping()->()){

        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "role")
        defaults.removeObject(forKey: "username")
        defaults.removeObject(forKey: "userId")
        defaults.removeObject(forKey: "token")
        defaults.synchronize()
        completion()
        
    }

}


