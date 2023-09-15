//
//  ULAddMessageSupportViewModel.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 14/09/23.
//

class ULAddMessageSupportViewModel {
        
    var courseId: Int?
    var typeMessage: String?
    var userIds: String?

    init(typeMessage: String?, courseId:Int?, userIds:String?) {
        self.typeMessage = typeMessage ?? ""
        self.userIds = userIds ?? ""
        self.courseId = courseId ?? 0
    }
}
