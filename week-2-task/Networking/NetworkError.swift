//
//  NetworkError.swift
//  week-2-task
//
//  Created by Mohammed Al-Quraini on 1/28/22.
//

import Foundation

import Foundation

enum NetworkError: Error, LocalizedError {
    case badURL
    case other(Error)
    
    var errorDescription: String? {
        switch self {
        case .badURL:
            return "Bad url"
        case .other(let error):
            return error.localizedDescription
        }
    }
}
