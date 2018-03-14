//
//  ViewController.swift
//  SOS Pets
//
//  Created by Renato Savoia Girão on 14/03/18.
//  Copyright © 2018 Renato Savoia Girão. All rights reserved.
//

import UIKit
import Firebase

class InitialViewController: UIViewController {

    var firebaseDBReference : DatabaseReference! = Database.database().reference()
    
    //MARK: - LOGS
    func log(_ str: Any...){
        print("RLOG InitialViewController: \(str[0])"); if str.count > 1 { print(str[1]) }
    }
    
    //MARK: - PROPRIEDADES
    //MARK: - OUTLETS
    //MARK: - OVERRIDES
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        firebaseDBReference.child("Teste De Banco de Dados222").setValue("100")
        
    }
    
    //MARK: - ACTIONS
    //MARK: - METHODS
    //MARK: - EXTENSIONS / DELEGATES
    



}

