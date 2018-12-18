//
//  Registration.swift
//  Hotel Manzana
//
//  Created by James and Ray Berry on 18/12/2018.
//  Copyright © 2018 JARBerry. All rights reserved.
//

import Foundation

struct Registration {
    var firstName: String
    var lastName: String
    var emailAddress: String
    
    var checkInDate: Date
    var checkOutDate: Date
    var numberOfAdults: Int
    var numberOfChildren: Int
    
    var roomType: RoomType
    var wifi: Bool
}

