//
//  ULEndpoint.swift
//  ulearning_app_ios
//
//  Created by Gonzalo López on 29/06/23.
//

import Foundation

/// Represents unique API endpoint
@frozen enum ULEndpoint: String, CaseIterable, Hashable {
    /// Endpoint to get character info
    case character
    /// Endpoint to get location info
    case location
    /// Endpoint to get episode info
    case episode
}
