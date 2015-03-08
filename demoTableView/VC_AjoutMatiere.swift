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
        
        validator.registerField(
            textField: tf_saisieMatiere,
            errorLabel: l_verif,
            rules: [
                RequiredRule(),
                StringRule(),
                MatiereNameRule()
            ]
        )
        
        validator.registerField(
            textField: tf_coefMatiere,
            errorLabel: l_verifCoef,
            rules: [
                RequiredRule(),
                CoefRule()
            ]
        )
  
    }
    
    @IBAction func AjouterMatiere(sender: AnyObject) {
        // Validating...
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
    
    // MARK: Error Styling
    
    func removeError(#label:UILabel, textField:UITextField) {
        label.hidden = true
        textField.layer.borderWidth = 0.0
    }
    
    func removeAllErrors(){
        removeError(
            label:l_verif,
            textField: tf_saisieMatiere
        )
        removeError(
            label: l_verifCoef,
            textField: tf_coefMatiere
        )
    }
    
    // MARK: ValidationDelegate Methods
    
    func validationWasSuccessful() {
        
        //  Validation SUCCESS
        
        var alert = UIAlertController(
            title: "Enregistrement",
            message: "Votre matière a bien était enregistré.",
            preferredStyle: UIAlertControllerStyle.Alert
        )
        
        var defaultAction = UIAlertAction(
            title: "OK",
            style: .Default,
            handler: nil
        )
        
        alert.addAction(defaultAction)
        
        self.presentViewController(
            alert,
            animated: true,
            completion: nil
        )
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if let VC: AccueilVC = segue.destinationViewController as? AccueilVC
        {
            VC.DataNote = DataNote
        }
        
        if let VC: ViewController = segue.destinationViewController as? ViewController
        {
            VC.DataNote = DataNote
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
