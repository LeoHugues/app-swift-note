//
//  VC_AjoutNote.swift
//  demoTableView
//
//  Created by userEPSI on 30/10/2014.
//  Copyright (c) 2014 Logimax. All rights reserved.
//

import UIKit

class VC_AjoutNote: UIViewController, ValidationDelegate, UIAlertViewDelegate {
    
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
    @IBOutlet weak var lb_verifNote: UILabel!
    @IBOutlet weak var lb_verifCoef: UILabel!
    
    let validator = Validator()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Ajout Note"
        
        tf_Note.restorationIdentifier = "nbPoint"
        
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

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        l_date.text = dateFormatter.stringFromDate(selectionedDate)
        
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
        self.clearErrors()
        validator.validateAll(self)
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
    
    // MARK: Error Styling
    
    func removeError(#label:UILabel, textField:UITextField) {
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
        
        //  Validation SUCCESS
        
        var alert = UIAlertController(
            title: "Enregistrement",
            message: "Votre Note a bien été ajoutée.",
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

//        var newNote: Note = Note()
//        
//        newNote.setNote(Float(tf_Note.text, "%,2"))
//        newNote.setNote(tf_CoefNote.text.toInt()!)
//        newNote.setNote(tv_desc.text)
//        newNote.setNote(datePicker.date)
        
        
        var dateFormatter : NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-YYYY"
        let dateString = dateFormatter.stringFromDate(datePicker.date)
        
        var data = Dictionary<String, String>()
        data = [
            "nbPoint"      : tf_Note.text,
            "coefficient"  : tf_CoefNote.text,
            "appreciation" : tv_desc.text,
            "date" : dateString,
        ]
        
        println(data)
        
        var body = NSJSONSerialization.dataWithJSONObject(data, options: nil, error: nil)
        //var jsonObj = NSJSONSerialization.JSONObjectWithData(bytes!, options: nil, error: nil) as [Dictionary<String, String>]

//        let stringData = NSString(
//            data: bytes!,
//            encoding: NSUTF8StringEncoding
//        )

        
       // let body = (stringData! as NSString).dataUsingEncoding(NSUTF8StringEncoding)

        
        let url = NSURL(string: Constants.UrlApi + "/note")!
        
        var request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.HTTPBody = body
        
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler:{ (response:NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            
            var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
            
            let jsonResult: NSDictionary! = NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers, error: error) as? NSDictionary
            
            if (jsonResult != nil) {
                println(jsonResult)
            } else {
                println("Marche pas")
            }
        })
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
