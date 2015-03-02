//
//  VC_AjoutNote.swift
//  demoTableView
//
//  Created by userEPSI on 30/10/2014.
//  Copyright (c) 2014 Logimax. All rights reserved.
//

import UIKit

class VC_AjoutNote: UIViewController, UIAlertViewDelegate {
    
    var DataNote = Array<Matiere>()
    var matiere = String()
    var datePicker = UIDatePicker()
    var selectionedDate = NSDate()
    var selectedRow = Int()

    
    

    @IBOutlet weak var pk_matiere: UIPickerView!
    
    @IBOutlet weak var tf_Note: UITextField!
    @IBOutlet weak var tf_CoefNote: UITextField!
    @IBOutlet weak var l_verif: UILabel!
    @IBOutlet weak var l_date: UILabel!
    @IBOutlet weak var tv_desc: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Ajout Note"

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        l_date.text = dateFormatter.stringFromDate(selectionedDate)
        
        println(matiere)
        
        pk_matiere.selectRow(MesFonctions.RechercheIndexMatiereByName(DataNote, name: matiere), inComponent: 0, animated: true)
    }

    override func viewWillDisappear(animated: Bool) {
        
        if let VC: AccueilVC = self.parentViewController?.childViewControllerForStatusBarHidden() as? AccueilVC
        {
            VC.DataNote = DataNote
        }
        else if let VC = self.parentViewController?.childViewControllerForStatusBarHidden() as? VC_Matiere
        {
            VC.DataNote = DataNote
        }
        
        
    }
    
    func pickerView(_: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }

    func numberOfComponentsInPickerView(_: UIPickerView!) -> Int {
        return 1
    }
    
    func pickerView(_: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return DataNote.count
    }
    
    func pickerView(_: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return DataNote[row].name
    }
    
    func pickerView(_: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRow = row
        matiere = DataNote[row].name
    }
    
    @IBAction func setDate(sender: AnyObject) {
        
        datePicker.datePickerMode = UIDatePickerMode.Date
        
        var alertView = UIAlertView()
        alertView.delegate = self
        alertView.addButtonWithTitle("Ok")
        alertView.addButtonWithTitle("Annuler")
        alertView.title = "Date";
        alertView.setValue(datePicker, forKey: "accessoryView")
        alertView.show()

    }
    
    func alertView(alertView: UIAlertView!, clickedButtonAtIndex buttonIndex: Int)
    {
        switch buttonIndex
            {
        case 0:
            selectionedDate = datePicker.date
            
            var dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            l_date.text = dateFormatter.stringFromDate(selectionedDate)
            
        default:
            println("annulé")
            
        }
    }

    
    @IBAction func AjoutNote(sender: UIButton) {
        
        if(CheckNote() == true)
        {
            let numberFormatter = NSNumberFormatter()
            let number = numberFormatter.numberFromString(tf_Note.text)
            let numberFloatValue = number?.doubleValue
            
            var note: Note = Note(Id: getRadomId(DataNote), NbPoint: numberFloatValue!, Date: selectionedDate, Description: tv_desc.text, Coefficient: tf_CoefNote.text.toInt()!)
            //var note = Note()
            
       println(selectedRow)
            
           
            
            DataNote[MesFonctions.RechercheIndexMatiereByName(DataNote, name:matiere)].listeNote.append(note)
            
            l_verif.text = "Votre note a bien été ajouté"
        }
        
    }
    
    func getRadomId(liste: Array<Matiere>) -> Int {
        
        var id = random()
        var validId = Bool()
        
        do
        {
            validId = true
        
            for matiere: Matiere in DataNote
            {
                for note: Note in matiere.listeNote
                {
                    if (note.id == id)
                    {
                        validId = false
                    }
                }
            }
            
        }while(validId == false)
        
        return id
    }
    
    func CheckCoefNote() -> Bool {
        
        var coefValid = true
        
        let regexCoef = "[a-zA-Z]+"       //      Verification du coef de la note
        
        if(tf_CoefNote.text == ""){
            l_verif.text = "Vous devez saisir un coef"
            coefValid = false
        }
        else if let match = tf_CoefNote.text.rangeOfString(regexCoef, options: .RegularExpressionSearch){
            l_verif.text = "un coef ne doit pas contenir de lettre"
            coefValid = false
        }
        else if tf_Note.text.toInt() > 20
        {
            l_verif.text = "un coef ne peut pas être supérieur a vinght"
            coefValid = false
        }
        else if tf_Note.text.toInt() < 0
        {
            l_verif.text = "un coef doit être supérieur à 0"
            coefValid = false
        }
        
        if(coefValid == true)
        {
            l_verif.text = "Le coef est valide"
        }
        
        return coefValid
    }
    
    func CheckNoteValue() -> Bool {
        
        var NoteValid = true
        
        let regexNote = "[a-zA-Z]+"       //      Verification de la note
        
        if(tf_Note.text == ""){
            l_verif.text = "Vous devez saisir une note"
            NoteValid = false
        }
        else if let match = tf_Note.text.rangeOfString(regexNote, options: .RegularExpressionSearch){
            l_verif.text = "la note ne doit pas contenir de lettre"
            NoteValid = false
        }
        else if tf_Note.text.toInt() > 20
        {
            l_verif.text = "Une Note ne peut pas être supérieur a vinght"
            NoteValid = false
        }
        else if tf_Note.text.toInt() < 0
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

    func CheckNote() -> Bool {
        
   
        var coefValid = CheckCoefNote()
        var NoteValid = CheckNoteValue()

        if(coefValid == true && NoteValid == true)
        {
            return true
        }
        
        return false
    }
    
    @IBAction func CheckNote(sender: AnyObject) {
        CheckNoteValue()
    }
    
    @IBAction func ChechCoef(sender: AnyObject) {
        CheckCoefNote()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if let VC: AccueilVC = segue.destinationViewController as? AccueilVC
        {
            VC.DataNote = DataNote
        }
        
        if let VC: ViewController = segue.destinationViewController as? ViewController
        {
            VC.DataNote = DataNote
        }
        if let VC: VC_AjoutMatiere = segue.destinationViewController as? VC_AjoutMatiere
        {
            VC.DataNote = DataNote
        }
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
