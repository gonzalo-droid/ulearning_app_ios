//
//  ULPackageDetailViewModel.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 22/09/23.
//

import Foundation


class ULPackageDetailViewModel {
        
    var isLoadingData: ULObservable<Bool> = ULObservable(false)
    var idLearningPackage: Int
    var dataObservable: ULObservable<ULSubscription> = ULObservable(nil)
    var percentages: ULObservable<[ULCoursePercentage]> = ULObservable(nil)
    var dataSource: ULSubscription?

    
    init(idLearningPackage: Int) {
        self.idLearningPackage = idLearningPackage
    }
    
    
    func getLearningPackage() {
        if isLoadingData.value ?? true {
            return
        }
        
        isLoadingData.value = true
        
        CourseService.getLearningPackage(learningPackageId: self.idLearningPackage,
            successBlock: { [weak self] data in
            
            guard let self = self else { return }
            
            self.dataSource = data

            let items = data?.learningPackage?.items
            debugPrint("percentage items \(items)")
            if items?.count == 0 {
                
                self.dataObservable.value = self.dataSource
                
                isLoadingData.value = false
                
            } else {
                var courseIds: [Int] = []
                if let unwrappedSubscriptions = items {
                    for items in unwrappedSubscriptions {
                        courseIds.append((items.course?.id)!)
                    }
                    let courseIdsString = courseIds.map { String($0) }.joined(separator: ",")
                    getCoursePercentage(courseIds: courseIdsString)
                }
            }
            
            
            
            isLoadingData.value = false
        }, errorBlock: { [weak self] error in
            guard let self = self else { return }
            isLoadingData.value = false
        })
        
    }
    
    func getCoursePercentage(courseIds : String) {
        debugPrint("percentage getCoursePercentage \(courseIds)")
        CourseService.getCoursePercentages(courseIds: courseIds, successBlock: { [weak self] percentages in
            guard let self = self else { return }
            self.percentages.value = percentages
            
            self.dataSource?.learningPackage?.items.forEach({data in
                let percentage = percentages?.first(where: {$0.courseId == data.courseId })
                data.percentageAdvance = percentage?.percentage
                debugPrint("percentage percentageAdvance \(percentage?.percentage)")

            })
            
            self.dataObservable.value = self.dataSource
            
            isLoadingData.value = false
            
        }, errorBlock: { [weak self] error in
            guard let self = self else { return }
            isLoadingData.value = false
        })
    }
    
    
}
