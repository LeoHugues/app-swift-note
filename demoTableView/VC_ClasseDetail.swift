//
//  VC_ClasseDetail.swift
//  demoTableView
//
//  Created by Léo on 25/04/2015.
//  Copyright (c) 2015 Logimax. All rights reserved.
//

import UIKit

class VC_ClasseDetail: UIViewController, UITableViewDataSource, UITableViewDelegate, ValidationDelegate {

    var classeListe = Array<Classe>()
    var indexOfClasse = Int()
    
    var validator = Validator()
    
    var textField = UITextField()
    var validationSuccess = Bool()
    
    @IBOutlet weak var l_title: UILabel!
    @IBOutlet weak var l_verifName: UILabel!
    
    @IBOutlet weak var tv_eleve: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        l_title.text = classeListe[indexOfClasse].nom
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Table view implementation
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classeListe[indexOfClasse].listeEleve.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("eleve") as! UITableViewCell
        
        cell.textLabel?.text = classeListe[indexOfClasse].listeEleve[indexPath.row].nom
        
        return cell
    }
    
    // MARK: - Update functions
    
    @IBAction func UpdateName(sender: AnyObject) {
        var alertView = UIAlertView()
        
        alertView.delegate = self
        alertView.addButtonWithTitle("OK")
        alertView.addButtonWithTitle("Annuler")
        alertView.title = "Modifier le Nom de la Classe"
        alertView.alertViewStyle = UIAlertViewStyle.PlainTextInput
        textField = alertView.textFieldAtIndex(0)!
        
        validator.registerField(
            textField: textField,
            errorLabel: l_verifName,
            rules: [
                RequiredRule()
            ])
        
        alertView.show()
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        
        if(alertView.title == "Modifier le Nom de la Classe"){
            switch buttonIndex
            {
            case 0:
                let newName = textField.text
                self.clearErrors(l_verifName)
                validator.validateAll(self)
                
                if(validationSuccess == true) {
                    classeListe[indexOfClasse].nom = newName
                    l_title.text = newName
                    
                    validationSuccess = false
                }
                validator.clearValidation()
                validator.clearErrors()
                break
            default:
                break
            }
        }
    }
    
    // MARK: Error Styling
    
    func removeError(#label:UILabel, textField:UITextField) {
        label.hidden = true
        textField.layer.borderWidth = 0.0
    }
    
    func removeAllErrors(label: UILabel, tf: UITextField){
        removeError(
            label: label,
            textField: tf
        )
    }
    
    // MARK: ValidationDelegate Methods
    
    func validationWasSuccessful() {
        validationSuccess = true
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
    
    private func clearErrors(label: UILabel){
        label.text = ""
    }

    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        
        if let VC = segue!.destinationViewController as? VC_Eleves {
            if let indexPath = tv_eleve.indexPathForSelectedRow() as NSIndexPath? {
                VC.classe = classeListe[indexOfClasse]
                VC.indexOfEleve = indexPath.row
            }
        }
    }
}
