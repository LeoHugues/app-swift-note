//
//  VC_Note.swift
//  demoTableView
//
//  Created by userEPSI on 30/10/2014.
//  Copyright (c) 2014 Logimax. All rights reserved.
//

import UIKit

class VC_Note: UIViewController, UIAlertViewDelegate {
    
    var DataNote = Array<Matiere>()
    var nomMatiere = String()
    var listeNote = Array<Note>()
    var id = Int()
    var note = Note()
    var indexNote = Int()
    var datePicker = UIDatePicker()
    var date = NSDate()
    var indexMatiere = Int()
    
    
    @IBOutlet weak var l_title: UILabel!

    @IBOutlet weak var l_date: UILabel!
    @IBOutlet weak var l_coef: UILabel!
    @IBOutlet weak var l_note: UILabel!
    @IBOutlet weak var l_verif: UILabel!
    
    @IBOutlet weak var b_date: UIButton!
    @IBOutlet weak var b_coef: UIButton!
    @IBOutlet weak var b_note: UIButton!
    
    @IBOutlet weak var b_prec: UIButton!
    @IBOutlet weak var b_next: UIButton!
    @IBOutlet weak var b_supp: UIButton!
    
    @IBOutlet weak var tv_desc: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Notes : \(nomMatiere)"

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        var i = 0
        for n: Note in listeNote
        {
            if (n.id == id)
            {
                note = n
                indexNote = i
            }
            i++
        }
        
        
        if(indexNote == 0)
        {
            b_prec.hidden = true
        }
        else
        {
            b_prec.hidden = false
        }
        
        if(indexNote == listeNote.count - 1)
        {
            b_next.hidden = true
        }
        else
        {
            b_next.hidden = false
        }

        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        var dateForNs = note.date
        var date = dateFormatter.stringFromDate(note.date)
        
        l_date.text = date
        l_coef.text = String(note.coefficient)
        l_note.text = String(format: "%.2f", note.nbPoint)
        tv_desc.text = note.description
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        DataNote[indexMatiere].listeNote = listeNote
        
        if let VC: VC_Matiere = self.parentViewController?.childViewControllerForStatusBarHidden() as? VC_Matiere
        {
            VC.DataNote = DataNote
            VC.tableView.reloadData()
        }
        else if let VC = self.parentViewController?.childViewControllerForStatusBarHidden() as? ViewController
        {
            VC.DataNote = DataNote
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        
        if let VC: VC_Matiere = segue!.destinationViewController as? VC_Matiere
        {
            VC.DataNote = DataNote
            VC.matiere = nomMatiere
        }
        
    }
    @IBAction func modifierDate(sender: AnyObject) {
        
        datePicker.datePickerMode = UIDatePickerMode.Date
        
        var alertView = UIAlertView()
        alertView.delegate = self
        alertView.addButtonWithTitle("Ok")
        alertView.addButtonWithTitle("Annuler")
        alertView.title = "Date";
        alertView.setValue(datePicker, forKey: "accessoryView")
        alertView.show()
    }


    
    @IBAction func setCoef(sender: AnyObject) {
        
        var alertView = UIAlertView()
        
        alertView.delegate = self
        alertView.addButtonWithTitle("OK")
        alertView.addButtonWithTitle("Annuler")
        alertView.title = "Modifier coef"
        alertView.alertViewStyle = UIAlertViewStyle.PlainTextInput
        alertView.show()
        
    }
    
    @IBAction func setNote(sender: AnyObject) {
        
        datePicker.datePickerMode = UIDatePickerMode.Date
        
        var alertView = UIAlertView()
        alertView.delegate = self
        alertView.addButtonWithTitle("Ok")
        alertView.addButtonWithTitle("Annuler")
        alertView.title = "Modifier note";
        alertView.alertViewStyle = UIAlertViewStyle.PlainTextInput
        alertView.show()
    }
    
    
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int)
    {
        
        if(alertView.title == "Date")
        {
            switch buttonIndex
                {
            case 0:
                date = datePicker.date
                
                var dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "dd-MM-yyyy"
                l_date.text = dateFormatter.stringFromDate(date)
                
                DataNote[indexMatiere].listeNote[indexNote].date = date
                
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
                    DataNote[indexMatiere].listeNote[indexNote].coefficient = alertView.textFieldAtIndex(0)!.text.toInt()!
                    l_coef.text = alertView.textFieldAtIndex(0)!.text
                }
                
            default:
                println("annulé")
                
            }
            
            
        }
        else if(alertView.title == "Modifier note")
        {
            switch buttonIndex
                {
            case 0:
                
                if(CheckNoteValue(alertView.textFieldAtIndex(0)!.text) == true)
                {
                    var string = NSString(string: alertView.textFieldAtIndex(0)!.text)
                    string.doubleValue
                    
                    println(string.doubleValue)
                    
                    DataNote[indexMatiere].listeNote[indexNote].nbPoint = string.doubleValue
                    
                    l_note.text = alertView.textFieldAtIndex(0)!.text
                }
            default:
                println("annulé")
                
            }
            
            
        }
        else if(alertView.title == "Supprimer note")
        {
            switch buttonIndex
                {
            case 0:
                
                if(listeNote.count == 1)
                {
                    l_verif.text = "Si vous supprimez cette note le programme plante :) "
                }
                else if (indexNote < listeNote.count - 1)
                {
                    listeNote.removeAtIndex(indexNote)
                    
                    note = listeNote[indexNote]
                    id = note.id
                    self.viewWillAppear(true)
                }
                else if(indexNote > 0)
                {
                    listeNote.removeAtIndex(indexNote)
                    
                    note = listeNote[indexNote - 1]
                    id = note.id
                    self.viewWillAppear(true)
                }
                
            default:
                println("annulé")
                
            }
        }

    }

    func CheckNoteValue(note: String) -> Bool {
        
        var NoteValid = true
        
        let regexNote = "[a-zA-Z]+"       //      Verification de la note
        
        if(note == ""){
            l_verif.text = "Vous devez saisir une note"
            NoteValid = false
        }
        else if let match = note.rangeOfString(regexNote, options: .RegularExpressionSearch){
            l_verif.text = "la note ne doit pas contenir de lettre"
            NoteValid = false
        }
        else if note.toInt() > 20
        {
            l_verif.text = "Une Note ne peut pas être supérieur a vinght"
            NoteValid = false
        }
        else if note.toInt() < 0
        {
            l_verif.text = "Une Note doit être supérieur à 0"
            NoteValid = false
        }
        
        if(NoteValid == true)
        {
            l_verif.text = "La note est valide"
        }
        
        return NoteValid
        
    }
    
    func CheckCoefMatiere(coef: String) -> Bool  //    Verifie l'utilisateur a saisie un coef valide
    {
        var coefValid = true
        
        
        let RegexLettre = "[a-zA-Z]+"
        
        if let match = coef.rangeOfString(RegexLettre, options: .RegularExpressionSearch){
            l_verif.text = "le coef ne doit pas contenir de lettre"
            coefValid = false
        }
        else if coef.toInt() > 20
        {
            l_verif.text = "le coef ne peut pas être supérieur a vinght"
            coefValid = false
        }
        else if coef == ""
        {
            l_verif.text = "vous devez saisir un coeficient"
            coefValid = false
        }
        else if coef.toInt() < 0
        {
            l_verif.text = "le coef doit être supérieur à 0"
            coefValid = false
        }
        
        if(coefValid == true)
        {
            l_verif.text = "Le coef est valide"
        }
        
        return coefValid
    }
    
    @IBAction func backMatiere(sender: AnyObject) {
        
        if(indexNote > 0)
        {
            note = listeNote[indexNote - 1]
            id = note.id
            self.viewWillAppear(true)
        }
    }
    
    @IBAction func nextMatiere(sender: AnyObject) {
        
        if(indexNote < DataNote.count - 1)
        {
            note = listeNote[indexNote + 1]
            id = note.id
            self.viewWillAppear(true)
        }
        
    }
    @IBAction func DeleteMatiere(sender: AnyObject) {
        
        var alertView = UIAlertView()
        alertView.delegate = self
        alertView.addButtonWithTitle("OK")
        alertView.addButtonWithTitle("Annuler")
        alertView.title = "Supprimer note"
        alertView.message = "Etes vous certain de vouloir supprimer cette note ?"
        alertView.show()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
