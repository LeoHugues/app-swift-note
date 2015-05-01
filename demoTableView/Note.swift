//
//  Note.swift
//  demoTableView
//
//  Created by userEPSI on 22/10/2014.
//  Copyright (c) 2014 Logimax. All rights reserved.
//

import UIKit

class Note {
    
    var id: Int
    var eleve: Eleve
    var matiere: Matiere
    var nbPoint: Double
    var date: NSDate
    var description: String
    var coefficient: Int
    
    init(Id: Int, NbPoint: Double, Date: NSDate, Description: String, Coefficient: Int) {
        self.id = Id
        self.nbPoint = NbPoint
        self.date = Date
        self.description = Description
        self.coefficient = Coefficient
        self.matiere = Matiere()
        self.eleve = Eleve()
    }
    
    init()
    {
        self.id = 0
        self.nbPoint = 0
        self.date = NSDate()
        self.description = ""
        self.coefficient = 0
        self.matiere = Matiere()
        self.eleve = Eleve()
    }
    
    init(id: String, NbPoint: String, dateString: String, Description: String, Coefficient: String, idMatiere: String) {
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        
        var date = dateFormatter.dateFromString(dateString)
        
        self.id = id.toInt()!
        self.nbPoint = Double(NbPoint.toInt()!)
        self.date = date!
        self.description = Description
        self.coefficient = Coefficient.toInt()!
        self.matiere = Matiere()
        self.matiere.APIGetMatiereById(idMatiere.toInt()!)
        self.eleve = Eleve()
    }   
}
