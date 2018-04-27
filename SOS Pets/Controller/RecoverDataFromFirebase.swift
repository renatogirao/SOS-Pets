//
//  RecoverDataFromFirebase.swift
//  SOS Pets
//
//  Created by Renato Savoia Girão on 27/04/2018.
//  Copyright © 2018 Renato Savoia Girão. All rights reserved.
//

import Foundation
import Firebase

class RecoverDataFromFirebaseService {
    
    let firebaseDBReference : DatabaseReference! = Database.database().reference()
    
    func RecoverDataFromFirebase() {
    //MARK: Recuperar dados do Firebase
    var vetsList = firebaseDBReference.child("Vets").child("Vet Legal")
    
    //MARK: Observer "avisa" o banco de que tem novas informaçøes
    vetsList.observe(DataEventType.value, with: {(dadosRecuperados) in
    let dadosRecuperadosDoVet = dadosRecuperados.value as? NSDictionary
    
    //MARK: Recupera os dados do Firebase
    
    let nameOfVet = dadosRecuperadosDoVet?["nome"] as! String
    let addressOfVet = dadosRecuperadosDoVet?["endereco"] as! String
    let telephoneOfVet = dadosRecuperadosDoVet?["telefone"] as! String
    let coordinateOfVet = dadosRecuperadosDoVet?["coordenada"] as! Double
    let imageOfVet = dadosRecuperadosDoVet?["logo"] as! String
    let URLOfString = URL(string: imageOfVet)
    let specialtyOfVet = dadosRecuperadosDoVet?["especialidade"] as! String
    let hourOfVet = dadosRecuperadosDoVet?["horario"] as! String
    
    print ("dados recuperados: \(dadosRecuperados)")
    
    //MARK: Downlaod da imagem com a URL que é recuperada do Firebase
    
    let session = URLSession(configuration: .default)
    let getImageFromUrl = session.dataTask(with: URLOfString!) { (data, response, error) in
    if let e = error {
    print("Error Occurred: \(e)")
    } else {
    if (response as? HTTPURLResponse) != nil {
    if let imageData = data {
    //Pegando a imagem
    let image = UIImage(data: imageData)
    let veterinario = Place(name: nameOfVet, coordinate: coordinateOfVet as! String, telephone: telephoneOfVet, logo: image!, address: addressOfVet, hourOperating: hourOfVet, specialty: specialtyOfVet)
    
    } else {
    print("Algum erro ao recuperar a imagem")
    }
    }
    }
    }
    getImageFromUrl.resume()
    
    })
}
}
