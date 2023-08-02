//
//  ULCourseDetailViewModel.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 1/08/23.
//

import Foundation

class ULCourseDetailViewModel {
    
    var subscription: ULSubscription
    
    var title: String
    
    init(data: ULSubscription) {
        self.subscription = data
        
        self.title = data.course?.title ?? ""
    }
    
    
}
