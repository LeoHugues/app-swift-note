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
    }
    
    
    init(eleve: NSDictionary){
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        // convert string into date
        let date:NSDate? = dateFormatter.dateFromString(eleve["dateOfBirth"] as! String)
        
        var id = eleve["id"] as! String
        
        self.id = id.toInt()!
        self.nom = eleve["firstName"] as! String
        self.prenom = eleve["lastName"] as! String
        self.email = eleve["email"] as! String
        self.photo = UIImage()
        self.date_naissance = date!
        self.listeMatiere = []
    }
}
