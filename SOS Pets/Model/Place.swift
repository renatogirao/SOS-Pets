//
//  Place.swift
//  SOS Pets
//
//  Created by Renato Girão on 15/03/2018.
//  Copyright © 2018 Renato Savoia Girão. All rights reserved.
//

import Foundation
import UIKit

class Place {
    
    var name: String?
    var coordinate: Double?
    var telephone: String?
    var logo: UIImage?
    var address: String?
    var hourOperating: String?
    var specialty: String?
    
    init(name: String, coordinate: Double, telephone: String, logo: UIImage, address: String, hourOperating: String, specialty: String) {
        self.name = name
        self.coordinate = coordinate
        self.telephone = telephone
        self.logo = logo
        self.address = address
        self.hourOperating = hourOperating
        self.specialty = specialty
    }
    
}
