//
//  VC_AjoutNote.swift
//  demoTableView
//
//  Created by userEPSI on 30/10/2014.
//  Copyright (c) 2014 Logimax. All rights reserved.
//

import UIKit

class VC_AjoutNote: UIViewController, ValidationDelegate, UIAlertViewDelegate {
    
    var eleve = Eleve()
    var indexOfMatiere = Int()
    var datePicker = UIDatePicker()
    var matierePicker = MatierePicker()

    @IBOutlet weak var pk_matiere: UIPickerView!
    
    @IBOutlet weak var l_titleView: UILabel!
    @IBOutlet weak var tf_Note: UITextField!
    @IBOutlet weak var tf_CoefNote: UITextField!
    @IBOutlet weak var lb_verifNote: UILabel!
    @IBOutlet weak var lb_verifCoef: UILabel!
    @IBOutlet weak var l_date: UILabel!
    @IBOutlet weak var l_matiere: UILabel!
    @IBOutlet weak var tv_desc: UITextView!
    
    @IBOutlet weak var b_date: UIButton!
    @IBOutlet weak var b_matiere: UIButton!
    @IBOutlet weak var b_add: UIButton!
    

    
    let validator = Validator()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MesFonctions.convertButton(
            [
                b_date,
                b_matiere,
                b_add,
            ]
        )
        
        lb_verifCoef.hidden = true
        lb_verifNote.hidden = true
        self.navigationItem.title = "Ajout Note"
        l_titleView.text = "Ajouter une note à " + eleve.nom + " " + eleve.prenom
        
        let date = datePicker.date
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        l_date.text = dateFormatter.stringFromDate(date)
        matierePicker.selectRow(indexOfMatiere, inComponent: 0, animated: true)
        l_matiere.text = eleve.matieres[indexOfMatiere].name
        
        validator.registerField(
            textField: tf_Note,
            errorLabel: lb_verifNote,
            rules: [
                RequiredRule(),
                NoteRule(),
            ]
        )
        validator.registerField(
            textField: tf_CoefNote,
            errorLabel: lb_verifCoef,
            rules: [
                RequiredRule(),
                NoteRule(),
            ]
        )
    }
    
    func setDate() {
        let date = datePicker.date
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        l_date.text = dateFormatter.stringFromDate(date)
    }
    
    @IBAction func setDate(sender: AnyObject) {
        
        let datePickerOfbirth = UIDatePicker(frame: CGRectMake(-8, 180, 300, 300))
        datePickerOfbirth.datePickerMode = UIDatePickerMode.Date
        
        datePickerOfbirth.date = datePicker.date
        
        datePicker = datePickerOfbirth
        
        
        let alert = SCLAlertView()
        
        alert.kWindowWidth += 50
        alert.kWindowHeight += 200
        
        alert.labelTitle.frame.origin.x += 25
        
        alert.contentView.addSubview(datePickerOfbirth)
        alert.addButton("Remplacer") {
            self.setDate()
        }
        
        alert.showEdit("Modifier", subTitle:"Modifier la date de la note")

    }
    
    func setMatiere() {
        indexOfMatiere = matierePicker.selectedRowInComponent(0)
        l_matiere.text = eleve.matieres[indexOfMatiere].name
    }
    
    @IBAction func setMatiere(sender: AnyObject) {
        let picker = MatierePicker(frame: CGRectMake(-8, 180, 300, 300))
        
        picker.matiereList = eleve.matieres
        picker.delegate = picker
        picker.dataSource = picker
        
        matierePicker = picker
        picker.selectRow(indexOfMatiere, inComponent: 0, animated: false)
        
        let alert = SCLAlertView()
        
        alert.kWindowWidth += 50
        alert.kWindowHeight += 200
        
        alert.labelTitle.frame.origin.x += 25
        
        alert.contentView.addSubview(picker)
        alert.addButton("Ok") {
            self.setMatiere()
        }
        
        alert.showEdit("Modifier", subTitle:"Modifier la classe de l'élève")
    }
    
    @IBAction func AjoutNote(sender: UIButton) {
        self.clearErrors()
        validator.validateAll(self)
    }
    
    // MARK: Error Styling
    
    func removeError(label label:UILabel, textField:UITextField) {
        label.hidden = true
        textField.layer.borderWidth = 0.0
    }
    
    func removeAllErrors(){
        removeError(
            label:lb_verifNote,
            textField: tf_Note
        )
        removeError(
            label: lb_verifCoef,
            textField: tf_CoefNote
        )
    }
    
    func validationWasSuccessful() {
                
        let note = Note(NbPoint: Int(tf_Note.text!)!,
            Date        : datePicker.date,
            Description : tv_desc.text,
            Coefficient : Int(tf_CoefNote.text!)!,
            eleve       : eleve,
            matiere     : eleve.matieres[indexOfMatiere])
        
        note.APICreateNote()
        
        SCLAlertView().showSuccess("Ajout Réussi", subTitle: "Votre note a bien était enregistrer", closeButtonTitle: "Ok", duration: 5.0)
    }
    
    func validationFailed(errors:[UITextField:ValidationError]) {
        //  Validation FAILED
        self.setErrors()
    }
    
    private func setErrors(){
        for (field, error) in validator.errors {
            field.layer.borderColor = UIColor.redColor().CGColor
            field.layer.borderWidth = 1.0
            error.errorLabel?.text = error.errorMessage
            error.errorLabel?.hidden = false
        }
    }
    
    private func clearErrors(){
        for (field, error) in validator.errors {
            field.layer.borderWidth = 0.0
            error.errorLabel?.hidden = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
