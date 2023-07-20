//
//  ULCompletedCourseViewModel.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 11/07/23.
//

import Foundation

class ULCompletedCourseViewModel {
    
    var isLoadingData: ULObservable<Bool> = ULObservable(false)
    var dataSource: [ULSubscription]?
    var subscriptions: ULObservable<[ULCourseTableCellViewModel]> = ULObservable(nil)
    
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
        CourseService.getSubscriptions(page: 1, isFinished: true, successBlock: { [weak self] subscriptions in
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
        subscriptions.value = self.dataSource?.compactMap({ULCourseTableCellViewModel(subscription: $0)})
    }
    
}
