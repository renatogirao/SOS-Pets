//
//  VetsListTableViewController.swift
//  SOS Pets
//
//  Created by Renato Girão on 15/03/2018.
//  Copyright © 2018 Renato Savoia Girão. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation

class VetsListTableViewController: UITableViewController {

    var firebaseDBReference : DatabaseReference! = Database.database().reference()
    let VetInfo = "VetInfo"
    var vets = [Place]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        firebaseDBReference.child("Teste De Banco de Dados222").setValue("100")
        
        registerNotifications()
        
      
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
    
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    func registerNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadVets(notification:)), name: NSNotification.Name(rawValue: VetInfo) , object: nil)
    }
    
    @objc func reloadVets(notification: Notification) {
        
        if let userinfo = notification.userInfo{
            if let vets = userinfo["vets"] as? [Place]{
                self.vets = vets
                self.tableView.reloadData()
                
            }
        }
    }
    
    func getVetsFromDB () {
        
        self.firebaseDBReference.child("Vets").observe(.value, with: {(snapshot: DataSnapshot) in
        
            if let values = snapshot.value as? [String: Any]{
            var vets = [Place]()
            
                for postValue in values {
                    let value = postValue.value as! [String: Any]
                    
                    let vet = Place()
                    
                    vet.name = value["Nome"] as? String
                    vet.coordinate = value["Coordenadas"] as? [String]
                    vet.telephone = value["Telefone"] as? String
                    vet.logo = value["Logo"] as? UIImage
                    vet.address = value["Endereco"] as? String
                    vet.hourOperating = value["Horario de Funcionamento"] as? String
                    
                    vets.append(vet)
                    
                }
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: self.VetInfo), object: nil, userInfo: ["vets": vets])
        }
        })
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return vets.count
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
