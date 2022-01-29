//
//  Photo.swift
//  week-2-task
//
//  Created by Mohammed Al-Quraini on 1/28/22.
//

import Foundation

struct Mars : Codable {
    let photos : [Photo]
}

struct Photo : Codable {
    let id : Int
    let img_src : String
    
    
//    var status : Bool = false
}
