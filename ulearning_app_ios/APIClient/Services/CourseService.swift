//
//  CourseService.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 30/06/23.
//

import Foundation
import Alamofire


class CourseService {
    
    static func getSubscriptions(
        successBlock: @escaping(_ groupBenefits: RootBenefits) -> Void,
        errorBlock: @escaping(_ error:  String?) -> Void
    ) {
        
        let pathUrl: BenefitApi = .groupedBenefits(
            country: BusinessLogin.getTenantApiHost()?.contains("peru") ?? false ? "PE" : "CL",
            gruoped: true
        )
        
        AF.request(pathUrl).validate(statusCode: 200..<205).responseObject {
            (response: DataResponse<RootBenefits, AFError>) in
            getRefreshToken(response)
            switch response.result {
            case .success(let value):
                if value.error == nil {
                    let tempElemt = value.value?.categorias?.first(where: {$0.titulo == "_"})
                    tempElemt?.titulo = "Todos"
                    tempElemt?.id = -1
                    if let benefits = tempElemt?.beneficios {
                        for benefit in benefits {
                            benefit.titulo_categoria = benefit.titulo_categoria == "_" ? "Todos" : benefit.titulo_categoria
                            benefit.categoria_id = -1
                        }
                    }
                    let indexValue = value.value?.categorias?.firstIndex(where: {$0.titulo == "Todos" && $0.id == -1})
                    if let index = indexValue {
                        value.value?.categorias?.remove(at: index )
                        value.value?.categorias?.insert(tempElemt ?? Categorias(), at: 0)
                    }
                    successBlock(value)
                } else {
                    errorBlock(value.error ?? "ERROR AQUI")
                }
            case .failure(let error):
                errorBlock(error.localizedDescription)
            }
        }
    }
    
}
