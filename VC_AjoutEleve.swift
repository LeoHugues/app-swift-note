import UIKit

class VC_AjoutEleve: UIViewController, ValidationDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var lb_verifFirstName: UILabel!
    @IBOutlet weak var lb_verifName: UILabel!
    @IBOutlet weak var txt_nameEleve: UITextField!
    @IBOutlet weak var txt_firstnameEleve: UITextField!
    @IBOutlet weak var tf_email: UITextField!
    @IBOutlet weak var l_verifEmail: UILabel!
    
    var classeListe = Array<Classe>()
    var indexOfClasse = 0
    
    let validator = Validator()
    var datePicker = UIDatePicker()
    var classePicker = ClassePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDisplayAjoutEleve()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setDisplayAjoutEleve()
    {
            lb_verifFirstName.hidden = true
            lb_verifName.hidden = true
            datePicker.datePickerMode = UIDatePickerMode.Date
        
        validator.registerField(
            textField: txt_nameEleve,
            errorLabel: lb_verifName,
            rules: [
                RequiredRule(),
                StringRule(),
            ]
        )
        
        validator.registerField(
            textField: txt_firstnameEleve,
            errorLabel: lb_verifFirstName,
            rules: [
                RequiredRule(),
                StringRule(),
            ]
        )
    }
    
    
    @IBAction func addEleve(sender: AnyObject) {
        // Validating ...
        self.clearErrors()
        validator.validateAll(self)
    }
    
    // MARK: Error Styling
    
    func removeError(#label:UILabel, textField:UITextField) {
        label.hidden = true
        textField.layer.borderWidth = 0.0
    }
    
    func removeAllErrors(){
        removeError(
            label: lb_verifName,
            textField: txt_nameEleve
        )
        removeError(
            label: lb_verifFirstName,
            textField: txt_firstnameEleve
        )
    }
    
    @IBAction func setClasse(sender: AnyObject) {
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

    
    // MARK: ValidationDelegate Methods
    
    func validationWasSuccessful() {
        
        //  Validation SUCCESS
        
        var alert = UIAlertController(
            title: "Enregistrement",
            message: "Votre élève a bien été ajouté",
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
//        var eleve = Eleve(
//            Id: 1,
//            Nom: txt_nameEleve.text,
//            Prenom: txt_firstnameEleve.text,
//            Date_naissance: dp_BirthdayEleve.date)
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
}
