//
//  ULProgressCourseViewModel.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 10/07/23.
//

import Foundation

class ULProgressCourseViewModel {
    
    var isLoadingData: ULObservable<Bool> = ULObservable(false)
    var dataSource: [ULSubscription]?
    var subscriptions: ULObservable<[ULCourseTableCellViewModel]> = ULObservable(nil)
    
    var percentages: ULObservable<[ULCoursePercentage]> = ULObservable(nil)

    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(in section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    
    func getData() {
        if isLoadingData.value ?? true {
            return
        }
        
        isLoadingData.value = true
        
        CourseService.getSubscriptions(page: 1, isFinished: false, successBlock: { [weak self] subscriptions in
            guard let self = self else { return }
            self.dataSource = subscriptions
            
            if subscriptions == nil {
                self.mapData()
                isLoadingData.value = false
            } else {
                var courseIds: [Int] = []
                if let unwrappedSubscriptions = subscriptions {
                    for subscription in unwrappedSubscriptions {
                        courseIds.append((subscription.course?.id)!)
                    }
                    let courseIdsString = courseIds.map { String($0) }.joined(separator: ",")
                    getCoursePercentage(courseIds: courseIdsString)
                }
            }
        }, errorBlock: { [weak self] error in
            guard let self = self else { return }
            isLoadingData.value = false
        })
    }
    
    func getCoursePercentage(courseIds : String) {
        CourseService.getCoursePercentages(courseIds: courseIds, successBlock: { [weak self] percentages in
            guard let self = self else { return }
            self.percentages.value = percentages
            
            self.dataSource?.forEach({data in
                let percentage = percentages?.first(where: {$0.courseId == data.courseId })
                data.percentageAdvance = percentage?.percentage
                
            })
            
            self.mapData()
            isLoadingData.value = false
            
        }, errorBlock: { [weak self] error in
            guard let self = self else { return }
            isLoadingData.value = false
        })
    }
    
    private func mapData() {
        subscriptions.value = self.dataSource?.compactMap({ULCourseTableCellViewModel(subscription: $0)})
    }
    
    func retriveSubscription(withId id: Int) -> ULSubscription? {
        guard let data = dataSource?.first(where: {$0.id == id}) else {
            return nil
        }
        return data
    }
}
