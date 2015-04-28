import UIKit

class VC_Eleves: UIViewController, UIAlertViewDelegate, ValidationDelegate {
    
    var classeListe = Array<Classe>()
    var classe = Classe()
    var indexOfEleve = Int()
    var indexOfClasse = 0
    var eleveWasUpdated = Bool()
    
    let validator = Validator()
    var validationSuccess = Bool()
    
    var datePicker = UIDatePicker()
    var classePicker = ClassePicker()
    
    // MARK: - Data Outlet
    
    @IBOutlet weak var l_lastName: UILabel!
    @IBOutlet weak var l_verifLastName: UILabel!
    @IBOutlet weak var l_verifFirstName: UILabel!
    @IBOutlet weak var l_firstName: UILabel!
    @IBOutlet weak var l_email: UILabel!
    @IBOutlet weak var l_verifEmail: UILabel!
    @IBOutlet weak var l_dateOfBirth: UILabel!
    @IBOutlet weak var l_classe: UILabel!
    
    var textField = UITextField()
    
    // MARK: - Navigation Outlet
    
    @IBOutlet weak var b_nextEleve: UIButton!
    @IBOutlet weak var b_precedentEleve: UIButton!
    
    // MARK: - Init Function
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDisplayEleve()
        getClasses()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(animated: Bool) {
        if(eleveWasUpdated == true) {
            updateEleve()
            eleveWasUpdated = false
        }
    }
    
    func setDisplayEleve()
    {
        // Display Labels
        var date = classe.listeEleve[indexOfEleve].date_naissance
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        var dateString = dateFormatter.stringFromDate(date)
        
        l_lastName.text = classe.listeEleve[indexOfEleve].nom
        l_firstName.text = classe.listeEleve[indexOfEleve].prenom
        l_email.text = classe.listeEleve[indexOfEleve].email
        l_dateOfBirth.text = dateString
        l_classe.text = classe.nom
        
        // Display buttons
        if(indexOfEleve == 0) {
            b_precedentEleve.hidden = true
        } else {
            b_precedentEleve.hidden = false
        }
        if(indexOfEleve == classe.listeEleve.count - 1) {
            b_nextEleve.hidden = true
        } else {
            b_nextEleve.hidden = false
        }
    }
    
    // MARK: - Update function implementation
    func updateEleve(){
        classe.listeEleve[indexOfEleve].update()
    }
    
    @IBAction func updateLastName(sender: AnyObject) {
        
        var alertView = UIAlertView()
        
        alertView.delegate = self
        alertView.addButtonWithTitle("OK")
        alertView.addButtonWithTitle("Annuler")
        alertView.title = "Modifier le Nom"
        alertView.alertViewStyle = UIAlertViewStyle.PlainTextInput
        textField = alertView.textFieldAtIndex(0)!
        
        validator.registerField(
            textField: textField,
            errorLabel: l_verifLastName,
            rules: [
                RequiredRule()
            ])
        
        alertView.show()
    }
    
    @IBAction func updateFirstName(sender: AnyObject) {
        
        var alertView = UIAlertView()
        
        alertView.delegate = self
        alertView.addButtonWithTitle("OK")
        alertView.addButtonWithTitle("Annuler")
        alertView.title = "Modifier le Prénom"
        alertView.alertViewStyle = UIAlertViewStyle.PlainTextInput
        textField = alertView.textFieldAtIndex(0)!
        
        validator.registerField(
            textField: textField,
            errorLabel: l_verifFirstName,
            rules: [
                RequiredRule()
            ])
        
        alertView.show()
    }
    
    @IBAction func updateEmail(sender: AnyObject) {
        
        var alertView = UIAlertView()
        
        alertView.delegate = self
        alertView.addButtonWithTitle("OK")
        alertView.addButtonWithTitle("Annuler")
        alertView.title = "Modifier l'email"
        alertView.alertViewStyle = UIAlertViewStyle.PlainTextInput
        textField = alertView.textFieldAtIndex(0)!
        
        validator.registerField(
            textField: textField,
            errorLabel: l_verifEmail,
            rules: [
                RequiredRule()
            ])
        
        alertView.show()
    }
    
    @IBAction func updateDateOfBirth(sender: AnyObject) {
        
        var datePickerOfbirth = UIDatePicker()
        datePickerOfbirth.datePickerMode = UIDatePickerMode.Date
        
        datePicker = datePickerOfbirth
        
        var alertView = UIAlertView()
        alertView.delegate = self
        alertView.addButtonWithTitle("Ok")
        alertView.addButtonWithTitle("Annuler")
        alertView.title = "Date de Naissance";
        alertView.setValue(datePickerOfbirth, forKey: "accessoryView")
        alertView.show()
    }
    
    @IBAction func updateClasse(sender: AnyObject) {
        var picker = ClassePicker()

        picker.classeListe = classeListe
        picker.delegate = picker
        picker.dataSource = picker
        
        classePicker = picker
        picker.selectRow(indexOfClasse, inComponent: 0, animated: false)
        
        var alertView = UIAlertView()
        alertView.delegate = self
        alertView.addButtonWithTitle("Ok")
        alertView.addButtonWithTitle("Annuler")
        alertView.title = "Classe de l'éleve";
        alertView.setValue(picker, forKey: "accessoryView")
        alertView.show()
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        
        if(alertView.title == "Modifier le Nom"){
            switch buttonIndex
            {
            case 0:
                let newName = textField.text
                self.clearErrors(l_verifLastName)
                validator.validateAll(self)
                
                if(validationSuccess == true) {
                    classe.listeEleve[indexOfEleve].nom = newName
                    l_lastName.text = newName
                    eleveWasUpdated = true
                    validationSuccess = false
                }
                validator.clearValidation()
                validator.clearErrors()
                break
            default:
                break
            }
        } else if(alertView.title == "Modifier le Prénom") {
            switch buttonIndex
            {
            case 0:
                let newName = textField.text
                self.clearErrors(l_verifFirstName)
                validator.validateAll(self)
                
                if(validationSuccess == true) {
                    classe.listeEleve[indexOfEleve].prenom = newName
                    l_firstName.text = newName
                    eleveWasUpdated = true
                    validationSuccess = false
                }
                validator.clearValidation()
                validator.clearErrors()
                break
            default:
                break
            }
        } else if(alertView.title == "Modifier l'email") {
            switch buttonIndex
            {
            case 0:
                let email = textField.text
                self.clearErrors(l_verifEmail)
                validator.validateAll(self)
                
                if(validationSuccess == true) {
                    classe.listeEleve[indexOfEleve].email = email
                    l_email.text = email
                    eleveWasUpdated = true
                    validationSuccess = false
                }
                validator.clearValidation()
                validator.clearErrors()
                break
            default:
                break
            }
        } else if(alertView.title == "Date de Naissance") {
            switch buttonIndex
            {
            case 0:
                let date = datePicker.date
                
                var dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "dd-MM-yyyy"
                l_dateOfBirth.text = dateFormatter.stringFromDate(date)
                classe.listeEleve[indexOfEleve].date_naissance = date
                eleveWasUpdated = true
                break
                
            default:
                break
            }
        } else if(alertView.title == "Classe de l'éleve") {
            switch buttonIndex
            {
            case 0:
                  indexOfClasse = classePicker.selectedRowInComponent(0)
                  l_classe.text = classeListe[indexOfClasse].nom
                  classe.listeEleve[indexOfEleve].classe = classeListe[indexOfClasse]
                  eleveWasUpdated = true
                break
                
            default:
                break
            }
        }
    }
    
//    // MARK: - UIPicker implementation
//    
//    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
//        return 30
//    }
//    
//    func numberOfComponentsInPickerView(_: UIPickerView) -> Int {
//        return 1
//    }
//    
//    func pickerView(_: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return classeListe.count
//    }
//    
//    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
//        return classeListe[row].nom
//    }
    
    // MARK: - Navigation Eleves
    
    @IBAction func deteteEleve(sender: AnyObject) {
        classe.listeEleve[indexOfEleve].delete()
        classe.listeEleve.removeAtIndex(indexOfEleve)
        viewDidLoad()
    }
    
    @IBAction func getNextEleve(sender: AnyObject) {
        updateEleve()
        indexOfEleve++
        self.viewDidLoad()
    }
    
    @IBAction func getBackEleve(sender: AnyObject) {
        updateEleve()
        indexOfEleve--
        self.viewDidLoad()
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
    
    // MARK: - Api Rest Request
    
    internal func getClasses(){
        
        let url = NSURL(string: Constants.UrlApi + "/classe")!
        
        var request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        
        var response: NSURLResponse?
        var error: NSError?
        
        let data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
        
        let jsonResult = MesFonctions.parseJSON(data!)
        
        var classes = jsonResult["classe"] as! NSArray
        
        for array in classes {
            let dico = array as! NSDictionary
            var classe = Classe(classe: dico)
            self.classeListe.append(classe)
        }
    }
    
    // MARK: - View change
    
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        
        if let VC = segue!.destinationViewController as? ViewController {
            if let bt_section = sender as? UIButton {
                VC.eleve = classe.listeEleve[indexOfEleve]
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
