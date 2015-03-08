//
//  VC_AjoutMatiere.swift
//  demoTableView
//
//  Created by userEPSI on 30/10/2014.
//  Copyright (c) 2014 Logimax. All rights reserved.
//

import UIKit

class VC_AjoutMatiere: UIViewController, ValidationDelegate, UITextFieldDelegate {
    
    var DataNote = Array<Matiere>()
    var matiere = String()
    
    @IBOutlet weak var tf_saisieMatiere: UITextField!
    @IBOutlet weak var tf_coefMatiere: UITextField!
    @IBOutlet weak var tv_desc: UITextView!
    @IBOutlet weak var l_verif: UILabel!
    @IBOutlet weak var l_verifCoef: UILabel!

    let validator = Validator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Ajout Matiere"

        // Do any additional setup after loading the view.
        
        validator.registerField(tf_saisieMatiere, errorLabel: l_verif , rules: [RequiredRule()])
        validator.registerField(tf_coefMatiere, errorLabel: l_verifCoef, rules: [RequiredRule()])
    }
    
    @IBAction func AjouterMatiere(sender: AnyObject) {
        
       /* if(CheckMatiere() == true)
        {
            var listeNote: Array<Note> = []
            var newMatiere: Matiere = Matiere(Id: DataNote.count+1, Name: tf_saisieMatiere.text, Coefficient: tf_coefMatiere.text.toInt()!, Description: tv_desc.text, ListeNote: listeNote)
            
            DataNote.append(newMatiere)
            matiere = newMatiere.name
            l_verif.text = "Une nouvelle matière a été ajouté :  \(newMatiere.name)"
        }*/
        println("Validating...")
        self.clearErrors()
        validator.validateAll(self)
        
    }
    
   override func viewWillDisappear(animated: Bool) {
        
        if let VC: AccueilVC = self.parentViewController?.childViewControllerForStatusBarHidden() as? AccueilVC
        {
            VC.DataNote = DataNote
        }
        else if let VC = self.parentViewController?.childViewControllerForStatusBarHidden() as? ViewController
        {
            VC.DataNote = DataNote
        }
        else if let VC = self.parentViewController?.childViewControllerForStatusBarHidden() as? VC_AjoutNote
        {
            println(matiere)
            
            if(matiere != "")
            {
                VC.matiere = matiere
            }
            
            VC.DataNote = DataNote
            VC.pk_matiere.reloadAllComponents()
        }

        
    }
    
    
    @IBAction func CheckNom(sender: AnyObject) {
       // CheckNomMatiere()
    }
    
    @IBAction func CheckCoef(sender: AnyObject) {
       // CheckCoefMatiere()
    }
    
  /*  func CheckNomMatiere() -> Bool
    {
        var nomValid = true
        
        for matiere: Matiere in DataNote    //  Vérifie si la matière n'existe pas déjà
        {
            if(matiere.name.lowercaseString == tf_saisieMatiere.text.lowercaseString)
            {
                l_verif.text = "Cette Matière existe déjà"
                nomValid = false
            }
        }
        
        let regexChiffre = "/^[a-zA-Z]+$/"      //      Vérifie si le nom de la matière est valide
        
        if let match = tf_saisieMatiere.text.rangeOfString(regexChiffre, options: .RegularExpressionSearch){
            l_verif.text = "Le nom de la matière ne doit pas contenir de chiffre"
            nomValid = false
        }
        else if (tf_saisieMatiere.text == "")
        {
            l_verif.text = "Veuillez saisir un nom de matiere"
            nomValid = false
        }
        
        if(nomValid == true)
        {
            l_verif.text = "Le nom de la matiere est valide"
        }
        return nomValid
    }
    
    func CheckCoefMatiere() -> Bool
    {
        var coefValid = true
        
        var coef = tf_coefMatiere.text //    Verifie l'utilisateur a saisie un coef valide
        
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
    
    func CheckMatiere() -> Bool {
        
        var coefValid = CheckCoefMatiere()
        var nomValid = CheckNomMatiere()
        
        if(nomValid == true && coefValid == true)    // Ne retourne true que si toutes les vérifs sont passés
        {
            return true
        }
        
        return false
    }*/
    
    // MARK: Error Styling
    
    func removeError(label:UILabel, textField:UITextField) {
        label.hidden = true
        textField.layer.borderWidth = 0.0
    }
    
    func removeAllErrors(){
        removeError(l_verif, textField: tf_saisieMatiere)
        removeError(l_verifCoef, textField: tf_coefMatiere)
    }
    
    // MARK: ValidationDelegate Methods
    
    func validationWasSuccessful() {
        println("Validation Success!")
        var alert = UIAlertController(title: "Success", message: "You are validated!", preferredStyle: UIAlertControllerStyle.Alert)
        var defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(defaultAction)
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    func validationFailed(errors:[UITextField:ValidationError]) {
        println("Validation FAILED!")
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

    
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        
        if let VC: AccueilVC = segue!.destinationViewController as? AccueilVC
        {
            VC.DataNote = DataNote
        }
        
        if let VC: ViewController = segue!.destinationViewController as? ViewController
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
