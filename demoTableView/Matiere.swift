//
//  Matiere.swift
//  demoTableView
//
//  Created by userEPSI on 22/10/2014.
//  Copyright (c) 2014 Logimax. All rights reserved.
//

import UIKit

class Matiere {
   
    var id: Int
    var name: String
    var coefficient: Int
    var description: String
    var listeNote: Array<Note>
    
    init(Id: Int, Name: String, Coefficient: Int, Description: String, ListeNote: Array<Note> ) {
        
        self.id = Id
        self.name = Name
        self.coefficient = Coefficient
        self.description = Description
        self.listeNote = ListeNote
    }
    
    init()
    {
        self.id = 0
        self.name = ""
        self.coefficient = 0
        self.description = ""
        var ListeNote: Array<Note> = []
        self.listeNote = ListeNote
    }
    
    func cleanAllNote()
    {
        self.listeNote.removeAll()
    }

    func getMatiere() -> Matiere
    {
        return self
    }
    
    func rechercheNote(IdNote: Int) -> Note?     // recherche note
    {
        for note: Note in listeNote
        {
            if(note.id == IdNote)
            {
                return note
            }
        }
        var note = Note()
        
        return note     //  retourne une note vide si la note n'existe pas
    }
    
    
    func setNote(NbPoint: Double, IdNote: Int) -> Matiere
    {
        if var Note = rechercheNote(IdNote) as Note?
        {
            if (Note.id == 0)
            {
                return self     //      Renvoie la matière tel quel si l'Id n'existe pas
            }
        }
        
        listeNote[IdNote].nbPoint = NbPoint
        
        return self
    }
    
    
    func setNote(date: NSDate, IdNote: Int) -> Matiere
    {
        if var Note = rechercheNote(IdNote) as Note?
        {
            if (Note.id == 0)
            {
                return self     //      Renvoie la matière tel quel si l'Id n'existe pas
            }
        }
        
        listeNote[IdNote].date = date
        
        return self
    }
    
    func setDesc(desc: String) -> Matiere
    {
        self.description = desc
        return self
    }
    
    func setCoef(Coefficient: Int) -> Matiere
    {
        self.coefficient = Coefficient
        return self
    }
    
    func saveMatière()
    {
        var data: Matiere = self
  //      let jsonError: NSError?
 //       let decodedJson = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: jsonError!) as NSDictionary
     //   if !(jsonError != nil) {
//            println(decodedJson["title"])
//        }
        
    }
}
