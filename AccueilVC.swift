//
//  AccueilVC.swift
//  demoTableView
//
//  Created by userEPSI on 16/10/2014.
//  Copyright (c) 2014 Logimax. All rights reserved.
//

import UIKit
import Foundation

class AccueilVC: UIViewController {
    
    @IBOutlet weak var b_setting: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Accueil"

    }
    
    @IBAction func settingsAction(sender: AnyObject) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}