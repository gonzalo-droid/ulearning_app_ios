//
//  ULAPIConfig.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 29/06/23.
//

import Foundation
import Alamofire


protocol ULAPIConfig: URLRequestConvertible {
    var urlBase: String { get }
    var method: Alamofire.HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
    var encoding: ParameterEncoding? { get }
    var queryItems: [URLQueryItem]? { get }
}

extension ULAPIConfig {

    // Defaults
    var urlBase: String {
        return "https://sandbox.api.ulearning.com.pe/api/"
    }

    var method: HTTPMethod { return .get }
    var contentType: String { return "application/json" }
    var acceptHeader: String { return "application/json" }
    var parameters: Parameters? { return nil }
    var encoding: ParameterEncoding? { return URLEncoding.default }
    var queryItems: [URLQueryItem]? { return nil }
}

extension ULAPIConfig {

    /// Serializes an HTTP dictionary to a JSON Data Object
    /// - Parameter params: HTTP Parameters dictionary
    /// - Returns: Encoded JSON
    private func requestBodyFrom(params: [String: Any]?) -> Data? {
        guard let params = params else { return nil }
        guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else {
            return nil
        }
        return httpBody
    }

    private func setAuthorizationHeader(in urlRequest: inout URLRequest) {
        if let token = ULUserStore().getToken() {
            debugPrint("Bearer \(String(describing: token))")
            urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
    }

    /// Transforms a Request into a standard URL request
    /// - Parameter baseURL: API Base URL to be used
    /// - Returns: A ready to use URLRequest
    func asURLRequest(baseURL: String) -> URLRequest {

        let fullUrl = baseURL + path
        let url = URL(string: fullUrl)!

        var urlRequest = URLRequest(url: url)

        urlRequest.httpMethod = method.rawValue
        urlRequest.timeoutInterval = 30
        urlRequest.setValue(contentType, forHTTPHeaderField: "Content-Type")
        urlRequest.setValue(acceptHeader, forHTTPHeaderField: "Accept")
        debugPrint("urlRequest:\(urlRequest)")

        if let querys = queryItems {
            var urlComponents = URLComponents(string: fullUrl)
            urlComponents?.queryItems = querys

            if let url = urlComponents?.url,
               let queryItems = urlComponents?.queryItems {
                var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
                urlComponents?.queryItems = queryItems
                urlRequest.url = url
            }

        }

        setAuthorizationHeader(in: &urlRequest)

        if let encodedURLRequest = try? encoding?.encode(urlRequest, with: parameters), parameters != nil {
            return encodedURLRequest
        } else {
            return urlRequest
        }
        
    }

    func handleResponse<T>(_ dataResponse: DataResponse<T, AFError>) {
        if let httpResponse = dataResponse.response {
            debugPrint("Response Data: \(httpResponse)")
        }
    }
}
