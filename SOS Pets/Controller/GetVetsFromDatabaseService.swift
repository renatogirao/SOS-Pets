//
//  GetVetsFromDatabaseService.swift
//  SOS Pets
//
//  Created by Renato Savoia Girão on 26/04/2018.
//  Copyright © 2018 Renato Savoia Girão. All rights reserved.
//

import Foundation
import Firebase

struct GetVetsFromDatabaseService {
    
    func getVetsFromDB () {
        
        var firebaseDBReference : DatabaseReference! = Database.database().reference()
        
        firebaseDBReference.child("Vets").observe(.value, with: {(snapshot: DataSnapshot) in
            
            if let values = snapshot.value as? [String: Any]{
                var vets = [Place]()
                
                for postValue in values {
                    let value = postValue.value as! [String: Any]
                    
                    let vetName = value["Nome"] as? String
                    let vetCoordinate = value["Coordenadas"] as? [String]
                    let vetTelephone = value["Telefone"] as? String
                    let vetLogo = value["Logo"] as? UIImage
                    let vetAddress = value["Endereco"] as? String
                    let vetHourOperating = value["Horario de Funcionamento"] as? String
                    let vetSpecialty = value["Especialidade"] as? String
                    
                    var vet = Place(name: vetName!, coordinate: vetCoordinate!, telephone: vetTelephone, logo: vetLogo, address: vetAddress, hourOperating: vetHourOperating, specialty: vetSpecialty)

                    vets.append(vet)
                    
                }
                
                //NotificationCenter.default.post(name: NSNotification.Name(rawValue: self.VetInfo), object: nil, userInfo: ["vets": vets])
                
            }
        })
    }
    
    
}
