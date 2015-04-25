//
//  VC_AjoutMatiere.swift
//  demoTableView
//
//  Created by Léo on 25/04/2015.
//  Copyright (c) 2015 Logimax. All rights reserved.
//

import UIKit

class VC_AjoutClasse: UIViewController, ValidationDelegate, UITextFieldDelegate  {

    @IBOutlet weak var tf_classeName: UITextField!
    @IBOutlet weak var l_verifName: UILabel!
    
    let validator = Validator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        validator.registerField(
            textField: tf_classeName,
            errorLabel: l_verifName,
            rules: [
                RequiredRule(),
                StringRule(),
            ]
        )

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addClasse(sender: AnyObject) {
        
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
            label: l_verifName,
            textField: tf_classeName
        )
    }
    
    // MARK: ValidationDelegate Methods
    
    func validationWasSuccessful() {
        
        //  Validation SUCCESS
        
        addClasse()
        
        var alert = UIAlertController(
            title: "Enregistrement",
            message: "Votre classe a bien été ajouté",
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
    
    // MARK: Api request
    
    func addClasse(){
        var data = Dictionary<String, String>()
        data = [
            "name" : tf_classeName.text,
        ]
        
        var body = NSJSONSerialization.dataWithJSONObject(data, options: nil, error: nil)
        
        let url = NSURL(string: Constants.UrlApi + "/classe")!
        var request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.HTTPBody = body
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler:{ (response:NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            
            var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
            
            let jsonResult: NSDictionary! = NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers, error: error) as? NSDictionary
            
            if (jsonResult != nil) {
                println(jsonResult.description)
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
