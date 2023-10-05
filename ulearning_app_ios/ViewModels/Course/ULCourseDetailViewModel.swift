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
    let urlStudent = "https://student.ulearning.com.pe"
    var dataSource: [ULTopic]?
    var topics: ULObservable<[ULTopicCellViewModel]> = ULObservable(nil)
    var topicsObservable: ULObservable<[ULTopic]> = ULObservable(nil)
    var urlTopic: String?

    init(data: ULSubscription) {
        self.subscription = data
        self.title = data.course?.title ?? ""
    }
    
    func getTopicsData(courseId: Int) {

        CourseService.getTopics(courseId:courseId, successBlock: { [weak self] topics in
            guard let self = self else { return }

            var mutableTopics: [ULTopic] = []                         
            let index = 0
            if let unwrappedTopics = topics {
                for topic in unwrappedTopics {
                    mutableTopics.append(topic)
                    topic.orderIndex += index
                    if let children = topic.children {
                        for child in children {
                            mutableTopics.append(child)
                            child.orderIndex += index
                        }
                    }
                }
            }
            self.topicsObservable.value = mutableTopics

            
        }, errorBlock: { [weak self] error in
            guard let self = self else { return }
        })
        
    }
    
    func getTokenWeb() {
        AuthService.selfAuthToken(successBlock: { [weak self] tokenWeb in
            guard let self = self else { return }
            urlTopic = "\(urlStudent)/sessions/signin-token/\(tokenWeb)"
                    
        }, errorBlock: { [weak self] error in
            guard let self = self else { return }

        })
    }
    
    
    private func mapData() {
        topics.value = self.dataSource?.compactMap({ULTopicCellViewModel(topic: $0)})
    }
}
