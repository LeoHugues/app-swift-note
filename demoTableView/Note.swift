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
    var nbPoint: Int
    var date: NSDate
    var description: String
    var coefficient: Int
    
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
    
    init(NbPoint: Int, Date: NSDate, Description: String, Coefficient: Int, eleve: Eleve, matiere:Matiere) {
        self.id = Int()
        self.nbPoint = NbPoint
        self.date = Date
        self.description = Description
        self.coefficient = Coefficient
        self.matiere = matiere
        self.eleve = eleve
    }
    
    init(Id: Int, NbPoint: Int, Date: NSDate, Description: String, Coefficient: Int, eleve: Eleve, matiere:Matiere) {
        self.id = Id
        self.nbPoint = NbPoint
        self.date = Date
        self.description = Description
        self.coefficient = Coefficient
        self.matiere = matiere
        self.eleve = eleve
    }
    
    func APICreateNote() {
        
        do {
            let dateFormatter : NSDateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "dd-MM-YYYY"
            let dateString = dateFormatter.stringFromDate(self.date)
            
            var data = Dictionary<String, AnyObject>()
            
            data = [
                "nbPoint"      : self.nbPoint,
                "coefficient"  : self.coefficient,
                "appreciation" : self.description,
                "date"         : dateString,
                "idMatiere"    : self.matiere.id,
                "idEleve"      : self.eleve.id
            ]
            print(data)
            
            let url = NSURL(string: Constants.UrlApi + "/note")!
            
            let request = NSMutableURLRequest(URL: url)
            request.HTTPMethod = "POST"
            
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(data, options: [])
            
            var response: NSURLResponse?
            
            _ = try NSURLConnection.sendSynchronousRequest(request, returningResponse: &response)
        } catch (let e) {
            print(e)
        }
    }
    
    func APIUpdateNote() {
        
        do {
            let dateFormatter : NSDateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "dd-MM-YYYY"
            let dateString = dateFormatter.stringFromDate(self.date)
            
            var data = Dictionary<String, AnyObject>()
            
            data = [
                "nbPoint"      : self.nbPoint,
                "coefficient"  : self.coefficient,
                "appreciation" : self.description,
                "date"         : dateString,
                "idMatiere"    : self.matiere.id,
                "idEleve"      : self.eleve.id
            ]
            print(data)
            
            let body = try NSJSONSerialization.dataWithJSONObject(data, options: [])
            
            let url = NSURL(string: Constants.UrlApi + "/note/\(self.id)")!
            
            let request = NSMutableURLRequest(URL: url)
            request.HTTPMethod = "PUT"
            request.HTTPBody = body
            
            var response: NSURLResponse?
            
            _ = try NSURLConnection.sendSynchronousRequest(request, returningResponse: &response)
        } catch (let e) {
            print(e)
        }
    }
    
    internal func APIdelete() {
        do {
            let url = NSURL(string: Constants.UrlApi + "/note/\(self.id)")!
            
            let request = NSMutableURLRequest(URL: url)
            request.HTTPMethod = "DELETE"
            
            var response: NSURLResponse?

            _ = try NSURLConnection.sendSynchronousRequest(request, returningResponse: &response)
        } catch (let e) {
            print(e)
        }
    }
}
