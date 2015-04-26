//
//  VC_Matiere.swift
//  demoTableView
//
//  Created by userEPSI on 29/10/2014.
//  Copyright (c) 2014 Logimax. All rights reserved.
//

import UIKit

class VC_Matiere: UIViewController, UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate {

    var matiere = String()
    var DataNote = Array<Matiere>()
    var IndexOfmatiere = Int()
    var ListeNote = Array<Note>()
    var l_verif = String()
    
    @IBOutlet weak var l_messageError: UILabel!
    @IBOutlet weak var l_title: UILabel!
    @IBOutlet weak var l_moyenne: UILabel!
    @IBOutlet weak var l_coef: UILabel!
    @IBOutlet weak var tv_description: UITextView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var b_backButton: UIButton!
    @IBOutlet weak var b_nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Matière"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        IndexOfmatiere = MesFonctions.RechercheIndexMatiereByName(DataNote, name: matiere)
        
        if(IndexOfmatiere == 0)
        {
            b_backButton.hidden = true
        }
        else
        {
            b_backButton.hidden = false
        }
        
        if(IndexOfmatiere == DataNote.count - 1)
        {
            b_nextButton.hidden = true
        }
        else
        {
            b_nextButton.hidden = false
        }
        
        let index = MesFonctions.RechercheIndexMatiereByName(DataNote, name: matiere)
        
        ListeNote = DataNote[index].listeNote
        
        l_title.text = DataNote[index].name
        l_moyenne.text = String(format: "%.2f",moyenne())
        l_coef.text = "\(String(DataNote[index].coefficient))"
        tv_description.text = DataNote[index].description
        
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        if let VC: AccueilVC = self.parentViewController?.childViewControllerForStatusBarHidden() as? AccueilVC
        {
           // VC.DataNote = DataNote
        }
        else if let VC = self.parentViewController?.childViewControllerForStatusBarHidden() as? ViewController
        {
            VC.DataNote = DataNote
        }
        
        DataNote[MesFonctions.RechercheIndexMatiereByName(DataNote, name: matiere)].description = tv_description.text
    }
    
    func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int
    {
        
        return ListeNote.count
    }
    @IBAction func setNameMatiere(sender: AnyObject) {
        
        var alertView = UIAlertView()
        alertView.delegate = self
        alertView.addButtonWithTitle("OK")
        alertView.addButtonWithTitle("Annuler")
        alertView.title = "Modifier nom matiere"
        alertView.alertViewStyle = UIAlertViewStyle.PlainTextInput
        alertView.show()
    }
    
    @IBAction func setCoefMatiere(sender: AnyObject) {
        
        
        
        var alertView = UIAlertView()
        alertView.delegate = self
        alertView.addButtonWithTitle("OK")
        alertView.addButtonWithTitle("Annuler")
        alertView.title = "Modifier coef"
        alertView.alertViewStyle = UIAlertViewStyle.PlainTextInput
        alertView.show()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cellNote") as! UITableViewCell
        
        cell.textLabel!.text = String(format: "%.2f", ListeNote[indexPath.row].nbPoint)
        cell.detailTextLabel?.text = String(ListeNote[indexPath.row].coefficient)
        
        return cell
    }
    
    func CheckNomMatiere(nom: String) -> Bool
    {
        var nomValid = true
        
        for matiere: Matiere in DataNote    //  Vérifie si la matière n'existe pas déjà
        {
            if(matiere.name.lowercaseString == nom.lowercaseString)
            {
                l_verif = "Cette Matière existe déjà"
                nomValid = false
            }
        }
        
        let regexChiffre = "/^[a-zA-Z]+$/"      //      Vérifie si le nom de la matière est valide
        
        if let match = nom.rangeOfString(regexChiffre, options: .RegularExpressionSearch){
            l_verif = "Le nom de la matière ne doit pas contenir de chiffre"
            nomValid = false
        }
        else if (nom == "")
        {
            l_verif = "Veuillez saisir un nom de matiere"
            nomValid = false
        }
        
        if(nomValid == true)
        {
            l_verif = "Le nom de la matiere est valide"
        }
        return nomValid
    }
    
    func CheckCoefMatiere(coef: String) -> Bool  //    Verifie l'utilisateur a saisie un coef valide
    {
        var coefValid = true
        
        
        let RegexLettre = "[a-zA-Z]+"
        
        if let match = coef.rangeOfString(RegexLettre, options: .RegularExpressionSearch){
            l_verif = "le coef ne doit pas contenir de lettre"
            coefValid = false
        }
        else if coef.toInt() > 20
        {
            l_verif = "le coef ne peut pas être supérieur a vinght"
            coefValid = false
        }
        else if coef == ""
        {
            l_verif = "vous devez saisir un coeficient"
            coefValid = false
        }
        else if coef.toInt() < 0
        {
            l_verif = "le coef doit être supérieur à 0"
            coefValid = false
        }
        
        if(coefValid == true)
        {
            l_verif = "Le coef est valide"
        }
        
        return coefValid
    }
    
    func moyenne() -> Double
    {
        var sommeCoef = 0
        var sommeNote = 0.0
        
        for note: Note in ListeNote
        {
            sommeCoef += note.coefficient
            sommeNote += note.nbPoint * Double(note.coefficient)
        }
        
        return sommeNote / Double(sommeCoef)
    }
    
    func alertView(alertView: UIAlertView!, clickedButtonAtIndex buttonIndex: Int)
    {
        if(alertView.title == "Modifier nom matiere")
        {
            switch buttonIndex
                {
            case 0:
                if(CheckNomMatiere(alertView.textFieldAtIndex(0)!.text) == true)
                {
                    DataNote[MesFonctions.RechercheIndexMatiereByName(DataNote, name: matiere)].name = alertView.textFieldAtIndex(0)!.text
                    l_title.text = alertView.textFieldAtIndex(0)!.text
                }
                else
                {
                    l_messageError.text = l_verif
                }
                
            default:
                println("annulé")
                
            }
        }
        else if(alertView.title == "Modifier coef")
        {
            switch buttonIndex
                {
            case 0:
            
                
                
                if(CheckCoefMatiere(alertView.textFieldAtIndex(0)!.text) == true)
                {
                    DataNote[MesFonctions.RechercheIndexMatiereByName(DataNote, name: matiere)].coefficient = alertView.textFieldAtIndex(0)!.text.toInt()!
                    l_coef.text = alertView.textFieldAtIndex(0)!.text
                }
                else
                {
                    l_messageError.text = l_verif
                }
                
            default:
                println("annulé")
                
            }
        }
        else if(alertView.title == "Supprimer matiere")
        {
            switch buttonIndex
                {
            case 0:
                if(IndexOfmatiere > 0)
                {
                    ListeNote = DataNote[IndexOfmatiere-1].listeNote
                    matiere = DataNote[IndexOfmatiere-1].name
                    
                    DataNote.removeAtIndex(IndexOfmatiere)
                    
                    self.viewWillAppear(true)
                    self.tableView.reloadData()
                }
                else if (IndexOfmatiere < DataNote.count - 1)
                {
                    ListeNote = DataNote[IndexOfmatiere+1].listeNote
                    matiere = DataNote[IndexOfmatiere+1].name
                    
                    DataNote.removeAtIndex(IndexOfmatiere)
                    
                    self.viewWillAppear(true)
                    self.tableView.reloadData()
                }
                else
                {
                    l_messageError.text = "Si vous supprimez cette note le programme plante"
                }
                
            default:
                println("annulé")
                
            }
        }

        
    }

    @IBAction func backMatiere(sender: AnyObject) {
        
        if(IndexOfmatiere > 0)
        {
            ListeNote = DataNote[IndexOfmatiere-1].listeNote
            matiere = DataNote[IndexOfmatiere-1].name
            self.viewWillAppear(true)
            self.tableView.reloadData()
        }
    }
    
    @IBAction func nextMatiere(sender: AnyObject) {
        
        if(IndexOfmatiere < DataNote.count - 1)
        {
            ListeNote = DataNote[IndexOfmatiere+1].listeNote
            matiere = DataNote[IndexOfmatiere+1].name
            self.viewWillAppear(true)
            self.tableView.reloadData()
        }
        
    }
    @IBAction func DeleteMatiere(sender: AnyObject) {
        
        var alertView = UIAlertView()
        alertView.delegate = self
        alertView.addButtonWithTitle("OK")
        alertView.addButtonWithTitle("Annuler")
        alertView.title = "Supprimer matiere"
        alertView.message = "Etes vous certain de vouloir supprimer cette matiere ?"
        alertView.show()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        
        if let VC: VC_Note = segue!.destinationViewController as? VC_Note
        {
            if let indexPath = tableView.indexPathForSelectedRow() as NSIndexPath?
            {
                VC.id = ListeNote[indexPath.row].id
            }
            
            VC.DataNote = DataNote
            VC.listeNote = ListeNote
            VC.nomMatiere = matiere
        }
        
        if let VC: VC_AjoutNote = segue!.destinationViewController as? VC_AjoutNote
        {
            VC.DataNote = DataNote
            VC.matiere = matiere
        }
        

        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
