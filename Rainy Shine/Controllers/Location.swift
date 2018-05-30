//
//  Location.swift
//  Rainy Shine
//
//  Created by macos on 5/22/18.
//  Copyright © 2018 macos. All rights reserved.
//

import Foundation

class Location {
    static var sharedInstance = Location()
    private init() {}
    
    var latitude: Double!
    var longitude: Double!
    
}
