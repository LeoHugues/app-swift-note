//
//  Eleve.swift
//  Note Manager
//
//  Created by Tristan on 05/11/2014.
//  Copyright (c) 2014 Hugues Prophete. All rights reserved.
//

import UIKit

class Eleve
    
{
    // Attributs
    
    var id: Int
    var nom: String
    var prenom: String
    var email: String
    var photo: UIImage
    var date_naissance: NSDate
    var classe: Classe
    
    var listeMatiere: Array<Matiere>
    
    
    // Constructeurs
    
    init(Id: Int, Nom: String, Prenom: String, Date_naissance: NSDate, ListeMatiere: Array<Matiere>)
    {
        self.id = Id
        self.nom = Nom
        self.prenom = Prenom
        self.email = "whatever"
        self.photo = UIImage()
        self.date_naissance = Date_naissance
        self.listeMatiere = ListeMatiere
        self.classe = Classe()
    }
    
    
    init(eleve: NSDictionary, classe: Classe){
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        // convert string into date
        let date:NSDate? = dateFormatter.dateFromString(eleve["dateOfBirth"] as! String)
        
        var id = eleve["id"] as! String
        
        self.id = id.toInt()!
        self.nom = eleve["lastName"] as! String
        self.prenom = eleve["firstName"] as! String
        self.email = eleve["email"] as! String
        self.photo = UIImage()
        self.date_naissance = date!
        self.listeMatiere = []
        self.classe = classe
    }
    
    internal func update() {
        
        // Prepare data
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        
            // convert string into date
        let date: String = dateFormatter.stringFromDate(self.date_naissance as NSDate)
        
        var bodyData = Dictionary<String, AnyObject>()
        bodyData = [
            "idClasse": self.classe.id,
            "firstName": self.prenom,
            "lastName": self.nom,
            "email": self.email,
            "dateOfBirth": date
        ]
        
        var body = NSJSONSerialization.dataWithJSONObject(bodyData, options: nil, error: nil)
        
        // Prepare request
        let url = NSURL(string: Constants.UrlApi + "/eleve/\(self.id)")!
        
        var request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "PUT"
        request.HTTPBody = body
        
        var response: NSURLResponse?
        var error: NSError?
        
        let data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
    }
    
    internal func delete() {
        let url = NSURL(string: Constants.UrlApi + "/eleve/\(self.id)")!
        
        var request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "DELETE"
        
        var response: NSURLResponse?
        var error: NSError?
        
        let data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
    }
}
