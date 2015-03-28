//
//  Required.swift
//  pyur-ios
//
//  Created by Jeff Potter on 12/22/14.
//  Copyright (c) 2014 ringseven. All rights reserved.
//

import Foundation


class RequiredRule: Rule {
    
    init(){}
    
    var message: String {
        return "Vous devez remplir ce champs"
    }
    
    func validate(value:String) -> Bool {
        if value.isEmpty {
            return false
        }
        return true
    }
    
    func errorMessage() -> String {
        return message
    }
}