//
//  ULPackageDetailViewModel.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 22/09/23.
//

import Foundation


class ULPackageDetailViewModel {
        
    var idLearningPackage: Int
    var dataObservable: ULObservable<ULSubscription> = ULObservable(nil)

    
    init(idLearningPackage: Int) {
        self.idLearningPackage = idLearningPackage
    }
    
    
    func getLearningPackage() {

        CourseService.getLearningPackage(learningPackageId: self.idLearningPackage,
            successBlock: { [weak self] data in
            
            guard let self = self else { return }
            
            self.dataObservable.value = data
            
        }, errorBlock: { [weak self] error in
            guard let self = self else { return }
        })
        
    }
    
    
}
