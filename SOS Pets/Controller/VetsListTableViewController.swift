//
//  VetsListTableViewController.swift
//  SOS Pets
//
//  Created by Renato Girão on 15/03/2018.
//  Copyright © 2018 Renato Savoia Girão. All rights reserved.
//

import UIKit
import FirebaseDatabase
import CoreLocation
import Firebase

class VetsListTableViewController: UITableViewController, CLLocationManagerDelegate {

    let VetInfo = "VetInfo"
    var vets : [Place] = []
    var localizationManager = CLLocationManager()
    let firebaseDBReference : DatabaseReference! = Database.database().reference()
    var refPics: DatabaseReference?
    
    @IBOutlet weak var distanceFromVetCell: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print ("\(vets.description)")
        
        //        registerNotifications()
        //tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
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
            
            let imageOfVet = dadosRecuperadosDoVet?["logo"] as! UIImage
            
            let specialtyOfVet = dadosRecuperadosDoVet?["especialidade"] as! String
            
            let hourOfVet = dadosRecuperadosDoVet?["horario"] as! String
            
            let veterinario = Place(name: nameOfVet, coordinate: coordinateOfVet, telephone: telephoneOfVet, logo: imageOfVet, address: addressOfVet, hourOperating: hourOfVet, specialty: specialtyOfVet)
            
            print ("dados recuperados: \(dadosRecuperados)")
            
            // MARK: Pega a localização do usuário
            
            self.localizationManager.delegate = self
            self.localizationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.localizationManager.requestWhenInUseAuthorization()
            self.localizationManager.startUpdatingLocation()
            
        } )
        
        self.tableView.reloadData()
        
    }
    
    
    func registerNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadVets(notification:)), name: NSNotification.Name(rawValue: VetInfo) , object: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let localizacaoUsuario = locations.last!
        //let longitude = localizacaoUsuario.coordinate.longitude
        //let latitude = localizacaoUsuario.coordinate.latitude
        
    }
    
    @objc func reloadVets(notification: Notification) {
        
        if let userinfo = notification.userInfo{
            if let vets = userinfo["vets"] as? [Place]{
                self.vets = vets
                self.tableView.reloadData()
                
            }
        }
    }
    

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.vets.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "verDetalhesVet", sender: self )
        
        
    }
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        let reusableCell = "celulaVet"
        let cell = tableView.dequeueReusableCell(withIdentifier: reusableCell, for: indexPath)
        cell.textLabel?.text = vets[indexPath.row].name
        
        // TO DO: Pegar Localização do usuário aqui
        var localOfUser : Double
        localOfUser = 2
        //var distanceFromVet = (celula.coordinate as! Double - localOfUser)
        
       
        return cell
     }
    
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

