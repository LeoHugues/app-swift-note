//
//  EMailRule.swift
//  demoTableView
//
//  Created by Léo on 13/06/2015.
//  Copyright (c) 2015 Logimax. All rights reserved.
//

import Foundation

class EMailRule: Rule  {
    
    var detailMessage = String()
    
    var message:String {
        return self.detailMessage
    }
    
    func validate(note:String) -> Bool {
        
        let RegexEmail = "^[_A-Za-z0-9-]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*(\\.[A-Za-z]{2,4})$"

        if let match = note.rangeOfString(RegexEmail, options: .RegularExpressionSearch){
            return true
        }
        
        self.detailMessage = "L'adresse emaile est invalide"
        return false
    }
    
    func errorMessage() -> String {
        return message
    }
    
    
}
