//
//  MesFonctions.swift
//  demoTableView
//
//  Created by userEPSI on 30/10/2014.
//  Copyright (c) 2014 Logimax. All rights reserved.
//

import UIKit

struct MesFonctions {
    
    static func parseJSON(inputData: NSData) -> NSDictionary{
        var error: NSError?
        var boardsDictionary = NSJSONSerialization.JSONObjectWithData(inputData, options: NSJSONReadingOptions.MutableContainers, error: &error) as! NSDictionary
        
        return boardsDictionary
    }
    
    static func randDate() -> NSDate
    {
        let jour = arc4random_uniform(27) + 1
        let mois = arc4random_uniform(11) + 1
        let annee = arc4random_uniform(9) + 2005
        
        var dateString = "\(String(jour))-\(String(mois))-\(String(annee))" // change to your date format
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        var date = dateFormatter.dateFromString(dateString)
                
        return date!
    }
    
    static func RechercheIndexMatiereByName(liste: Array<Matiere>, name: String) -> Int
    {
        var i = 0
        
        for matiere: Matiere in liste
        {
            if(matiere.name == name)
            {
                return i
            }
            i++
        }
        
        return 0
    }
    
    static func RechercheIndexNoteById(liste: Array<Note>, id: Int) -> Int
    {
        var i = 0
        
        for note: Note in liste
        {
            if(note.id == id)
            {
                return i
            }
            i++
        }
        
        return 0
    }
    static func tableEleve() ->Array<Eleve>
    {
        var DataEleve = Array<Eleve>()
        
        var newEleveOne: Eleve = Eleve(Id: 0, Nom: "Prophete", Prenom: "Tristan", Date_naissance: MesFonctions.randDate(), ListeMatiere: InitTestData())
        DataEleve.append(newEleveOne)
        
        var newEleveTwo: Eleve = Eleve(Id: 0, Nom: "Hugues", Prenom: "Léo", Date_naissance: MesFonctions.randDate(), ListeMatiere: InitTestData())
        DataEleve.append(newEleveTwo)
        
        var newEleveThree: Eleve = Eleve(Id: 0, Nom: "Bourial", Prenom: "Morad", Date_naissance: MesFonctions.randDate(), ListeMatiere: InitTestData())
        DataEleve.append(newEleveThree)
        
        
        var newEleveFour: Eleve = Eleve(Id: 0, Nom: "Welmant", Prenom: "Pierre", Date_naissance: MesFonctions.randDate(), ListeMatiere: InitTestData())
        DataEleve.append(newEleveFour)
     
        return DataEleve
    }
    
    
    static func InitTestData() -> Array<Matiere>
    {
        var DataNote = Array<Matiere>()
        
        for(var i = 0; i < 5; i++)
        {
            var newMatiere: Matiere = Matiere()
            
            for(var y = 0; y < 5; y++)
            {
                var note: Note = Note(Id: random(), NbPoint: Double(arc4random_uniform(20)), Date: MesFonctions.randDate(), Description: "", Coefficient: Int(arc4random_uniform(7) + 1))
                newMatiere.listeNote.append(note)
            }
            switch(i){
            case 0 : newMatiere.name = "Math"
            newMatiere.description = "Arithmétique, calcul logique, graphe et matrice, rien de très compliqué"
            case 1 : newMatiere.name = "Anglais"
            newMatiere.description = "Anglais niveau TOIC, spécialisé dans l'informatique. Tous le vocabulaire et les textes étudiés tournent autour de l'informatique"
            case 2 : newMatiere.name = "Français"
            newMatiere.description = "Pour obtenir le BTS uniquement, le thème est le rêve"
            case 3 : newMatiere.name = "Swift"
            newMatiere.description = "Programation objet, manipulation des listes, travail sur un modèle MVC, avec les view controller et table view controller utilisation des protocoles et Delagate"
            case 4 : newMatiere.name = "Algo"
            newMatiere.description = "Algo basique : trie, recherche dicotomique, path finding..."
                
                
            default : newMatiere.name = "Math"
            }
            newMatiere.coefficient = Int(arc4random_uniform(7)+1)
            
            DataNote.append(newMatiere)
        }
        
        return DataNote
    }
    
    static func MoyenneGenerale(Liste : Array<Matiere>) -> Double
    {
        var sommemoyennematiere = 0.00
        var sommecoefmatiere = 0
        
        for matiere : Matiere in Liste
        {
            if matiere.listeNote.count > 0
            {
            var sommeCoef = 0
            var sommeNote = 0.0
            
            for note:Note in matiere.listeNote
            {
                sommeCoef += note.coefficient
                sommeNote += note.nbPoint * Double(note.coefficient)
                
            }
            
            sommemoyennematiere += Double(matiere.coefficient) * (sommeNote / Double(sommeCoef))
            sommecoefmatiere += matiere.coefficient
        }
            }
        return sommemoyennematiere / Double(sommecoefmatiere)
        
    }

   
}
