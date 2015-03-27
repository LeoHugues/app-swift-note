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
    var photo: UIImage
    var date_naissance: NSDate
    
    var listeMatiere: Array<Matiere>
    
    
    // Constructeurs
    
    init(Id: Int, Nom: String, Prenom: String, Photo: UIImage, Date_naissance: NSDate, ListeMatiere: Array<Matiere>)
    {
        self.id = Id
        self.nom = Nom
        self.prenom = Prenom
        self.photo = Photo
        self.date_naissance = Date_naissance
        self.listeMatiere = ListeMatiere
    }
    
    init(Id: Int, Nom: String, Prenom: String, Date_naissance: NSDate, ListeMatiere: Array<Matiere>)
    {
        self.id = Id
        self.nom = Nom
        self.prenom = Prenom
        self.photo = UIImage()
        self.date_naissance = Date_naissance
        self.listeMatiere = ListeMatiere
    }
    
    init(Id: Int, Nom: String, Prenom: String, Date_naissance: NSDate)
    {
        self.id = Id
        self.nom = Nom
        self.prenom = Prenom
        self.date_naissance = Date_naissance
        self.photo = UIImage()
        self.listeMatiere = Array<Matiere>()
    }

    
    //Méthodes
    
    
    
}
