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
    
    init(Nom: String)
    {
        self.id = Int()
        self.nom = Nom
        self.listeEleve = Array<Eleve>()
    }
    
    init(classe: NSDictionary){
        self.id = classe["id"] as! Int
        self.nom = classe["name"] as! String
        self.listeEleve = []
    }
    
    init()
    {
        self.id = Int()
        self.nom = String()
        self.listeEleve = Array<Eleve>()
    }
    
    func APICreate(){
        var data = Dictionary<String, String>()
        data = [
            "name" : self.nom,
        ]
        
        var body = NSJSONSerialization.dataWithJSONObject(data, options: nil, error: nil)
        
        // Prepare request
        let url = NSURL(string: Constants.UrlApi + "/classe")!
        
        var request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.HTTPBody = body
        
        var response: NSURLResponse?
        var error: NSError?
        
        NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
    }
    
    func APIUpdate(){
        var data = Dictionary<String, String>()
        data = [
            "name" : self.nom,
        ]
        
        var body = NSJSONSerialization.dataWithJSONObject(data, options: nil, error: nil)
        
        // Prepare request
        let url = NSURL(string: Constants.UrlApi + "/classe/\(self.id)")!
        
        var request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "PUT"
        request.HTTPBody = body
        
        var response: NSURLResponse?
        var error: NSError?
        
        NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
    }
    
    func APIDelete(){
        // Prepare request
        let url = NSURL(string: Constants.UrlApi + "/classe/\(self.id)")!
        
        var request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "DELETE"
        
        var response: NSURLResponse?
        var error: NSError?
        
        NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
    }
}

