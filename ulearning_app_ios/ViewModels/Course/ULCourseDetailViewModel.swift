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
    
    var dataSourceTopics: [ULTopic]?

    init(data: ULSubscription) {
        self.subscription = data
        self.title = data.course?.title ?? ""
    }
    
    func getTopicsData(courseId: Int) {
 
        CourseService.getTopics(courseId:courseId, successBlock: { [weak self] topics in
            guard let self = self else { return }
            self.dataSourceTopics = topics
            self.mapData()
            
        }, errorBlock: { [weak self] error in
            guard let self = self else { return }
        })
    }
    
    private func mapData() {
    }
}
