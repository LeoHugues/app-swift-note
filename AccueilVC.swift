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
    
    var DataNote = Array<Matiere>()
    var DataEleve = Array<Eleve>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Accueil"
        self.navigationController!.navigationBar.tintColor = UIColor.blackColor()
        
        if(DataNote.count == 0)
        {
            DataNote = MesFonctions.InitTestData()
        }
        if(DataEleve.count == 0)
        {
            DataEleve = MesFonctions.tableEleve()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
       // CalculerMoyenneGeneral()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        //let TVController: UIViewController =  segue.destinationViewController as UITableViewController
        //c.setDataNote(DataNote)
        
        if let VC: ViewController = segue!.destinationViewController as? ViewController
        {
            VC.setDataNote(DataNote)
        }
        
       else if let VC: VC_AjoutNote = segue!.destinationViewController as? VC_AjoutNote
        {
            VC.DataNote=DataNote
        }
        
      else  if let VC: VC_AjoutMatiere = segue!.destinationViewController as? VC_AjoutMatiere
        {
            VC.DataNote=DataNote
        }
        
      else  if let VC: VC_Matiere = segue!.destinationViewController as? VC_Matiere
        {
            VC.DataNote=DataNote
        }
      else  if let VC: VC_Eleves = segue!.destinationViewController as? VC_Eleves
        {
            VC.DataEleve=DataEleve
        }
        
    }
    
    @IBAction func AjouterMatiere(sender: AnyObject) {
        

    }
    
    @IBAction func AjoutNote(sender: UIButton) {
        

        
    }
    
}