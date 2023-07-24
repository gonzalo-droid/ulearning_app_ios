//
//  ULPackageCourseViewModel.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 17/07/23.
//

import Foundation

class ULPackageCourseViewModel {
    
    var isLoadingData: ULObservable<Bool> = ULObservable(false)
    var dataSource: [ULSubscription]?
    var subscriptions: ULObservable<[ULLearningPackageTableCellViewModel]> = ULObservable(nil)
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(in section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    
    func getData(classification: String) {
        if isLoadingData.value ?? true {
            return
        }
        
        isLoadingData.value = true
        CourseService.getSubscriptionsPackage(classification:classification, successBlock: { [weak self] subscriptions in
            guard let self = self else { return }
            self.dataSource = subscriptions
            self.mapData()
            isLoadingData.value = false
            
        }, errorBlock: { [weak self] error in
            guard let self = self else { return }
            
            isLoadingData.value = false
        })
    
    
    }
    
    private func mapData() {
        subscriptions.value = self.dataSource?.compactMap({ULLearningPackageTableCellViewModel(subscription: $0)})
    }
    
}
