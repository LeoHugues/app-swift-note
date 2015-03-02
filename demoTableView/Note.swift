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
        
    }
    
    init()
    {
        self.id = 0
        self.nbPoint = 0
        self.date = NSDate()
        self.description = ""
        self.coefficient = 0
    }
    
    func getNote() -> Note
    {
        return self
    }
    
    func setNote(NbPoint: Double) -> Note
    {
        self.nbPoint = NbPoint
        return self
    }
    
    func setNote(Date: NSDate) -> Note
    {
        self.date = Date
        return self
    }
    
    func setNote(desc: String) -> Note
    {
        self.description = desc
        return self
    }
    
    func setNote(Coefficient: Int) -> Note
    {
        self.coefficient = Coefficient
        return self
    }
   
}
