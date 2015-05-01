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
    
    init()
    {
        self.id = 0
        self.name = ""
        self.coefficient = 0
        self.description = ""
        var ListeNote: Array<Note> = []
        self.listeNote = ListeNote
    }
    
    init(Name: String, Coefficient: Int, Description: String) {
        self.id = Int()
        self.name = Name
        self.coefficient = Coefficient
        self.description = Description
        self.listeNote = Array<Note>()
    }
    
    init(Id: Int, Name: String, Coefficient: Int, Description: String, ListeNote: Array<Note> ) {
        self.id = Id
        self.name = Name
        self.coefficient = Coefficient
        self.description = Description
        self.listeNote = ListeNote
    }
    
    func APIGetMatiereById(id: Int) {
        let url = NSURL(string: Constants.UrlApi + "/matiere/\(id)")!
        
        var request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        
        var response: NSURLResponse?
        var error: NSError?
        
        let data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
        
        let jsonResult = MesFonctions.parseJSON(data!)
        
        var matiere = jsonResult["matiere"] as! NSDictionary
        
        self.id = matiere["id"] as! Int
        self.name = matiere["name"] as! String
        self.coefficient = matiere["coefficient"] as! Int
        self.description = matiere["description"] as! String
    }
    
    func APICreateMatiere() {
        var data = Dictionary<String, AnyObject>()
        data = [
            "nom" : self.name,
            "coefficient" : self.coefficient,
            "description" : self.description
        ]
        
        var body = NSJSONSerialization.dataWithJSONObject(data, options: nil, error: nil)
        
        let url = NSURL(string: Constants.UrlApi + "/Matiere")!
        var request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.HTTPBody = body
        
        var response: NSURLResponse?
        var error: NSError?
        
        NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
    }
    
    func APIGetNotesByEleveID(id: Int) {
        let url = NSURL(string: Constants.UrlApi + "/note")!
        
        var bodyFiltre = Dictionary<String, Dictionary<String, String>>()
        bodyFiltre = [
            "filtre" : [
                "idEleve": String(id),
                "idMatiere": String(self.id)
            ]
        ]
        
        var body = NSJSONSerialization.dataWithJSONObject(bodyFiltre, options: nil, error: nil)
        
        var request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.HTTPBody = body
        
        var response: NSURLResponse?
        var error: NSError?
        
        let data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
        
        if (data?.length != 0) {
            let jsonResult = MesFonctions.parseJSON(data!)
        
            var notes = jsonResult["notes"] as! NSArray
        
            for array in notes {
                let dico = array as! NSDictionary
            
                var note = Note(id: dico["id"] as! String, NbPoint: dico["nbPoints"] as! String, dateString: dico["date"] as! String, Description: dico["apreciation"] as! String, Coefficient:             dico["coefficient"] as! String, idMatiere: dico["matiere_id"] as! String)
                self.listeNote.append(note)
            }
        }
        
    }
}
