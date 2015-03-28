//
//  Classe.swift
//  Note Manager
//
//  Created by Tristan on 05/11/2014.
//  Copyright (c) 2014 Hugues Prophete. All rights reserved.
//

import UIKit

class Classe

{
    //Attributs
    
    var id: Int
    var nom: String
    
    var listeEleve: Array<Eleve>
    
    
    //Contructeurs
    
    init(Id : Int, Nom: String, ListeEleve: Array<Eleve>)
    {
        self.id = Id
        self.nom = Nom
        self.listeEleve = ListeEleve
    }
    

}

