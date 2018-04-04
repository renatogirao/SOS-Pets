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
    
    @IBOutlet weak var LetsGoButton: UIButton!
    @IBOutlet weak var contactButton: UIButton!
    
    //MARK: - OVERRIDES
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
    }
    
    //MARK: - ACTIONS
    //MARK: - METHODS
    //MARK: - EXTENSIONS / DELEGATES
    



}

