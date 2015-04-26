//
//  AccueilVC.swift
//  demoTableView
//
//  Created by userEPSI on 16/10/2014.
//  Copyright (c) 2014 Logimax. All rights reserved.
//

import UIKit
import Foundation

class AccueilVC: UIViewController {
    
//    var classeListe = Array<Classe>()
//    var loader = UIAlertView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Accueil"
        self.navigationController!.navigationBar.tintColor = UIColor.blackColor()
    }
    
//    @IBAction func pushView(sender: AnyObject) {
//        getLoader()
//        getClasses()
//    }
    
    // MARK: - Api Rest Request
    
//    internal func getClasses(){
//        
//        let url = NSURL(string: Constants.UrlApi + "/classe")!
//        
//        var request = NSMutableURLRequest(URL: url)
//        request.HTTPMethod = "GET"
//        
//        var response: NSURLResponse?
//        var error: NSError?
//        
//        let data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
//        
//        let jsonResult = MesFonctions.parseJSON(data!)
//        
//        var classes = jsonResult["classe"] as! NSArray
//        
//        for array in classes {
//            let dico = array as! NSDictionary
//            var classe = Classe(classe: dico)
//            getEleve(classe)
//            self.classeListe.append(classe)
//        }
//    }
//    
//    internal func getEleve(classe: Classe){
//        
//        let url = NSURL(string: Constants.UrlApi + "/eleve")!
//        
//        var bodyFiltre = Dictionary<String, Dictionary<String, String>>()
//        bodyFiltre = [
//            "filtre" : [
//                "classe_id": String(classe.id)
//            ]
//        ]
//        
//        var body = NSJSONSerialization.dataWithJSONObject(bodyFiltre, options: nil, error: nil)
//        
//        var request = NSMutableURLRequest(URL: url)
//        request.HTTPMethod = "POST"
//        request.HTTPBody = body
//        
//        var response: NSURLResponse?
//        var error: NSError?
//        
//        let data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
//        
//        let jsonResult = MesFonctions.parseJSON(data!)
//        
//        var eleves = jsonResult["eleves"] as! NSArray
//        
//        for array in eleves {
//            let dico = array as! NSDictionary
//            var eleve = Eleve(eleve: dico, classe: classe)
//            classe.listeEleve.append(eleve)
//        }
//    }
//    
//    internal func getLoader(){
//        
//        loader = UIAlertView(title: "Loading", message: "Please wait...", delegate: nil, cancelButtonTitle: nil);
//        
//        var loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(50, 10, 37, 37)) as UIActivityIndicatorView
//        loadingIndicator.hidesWhenStopped = true
//        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
//        loadingIndicator.startAnimating();
//        
//        loader.setValue(loadingIndicator, forKey: "accessoryView")
//        loadingIndicator.startAnimating()
//        
//        loader.show()
//    }
//    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if let VC = segue.destinationViewController as? VC_Classe {
//            VC.classeListe = self.classeListe
//        }
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}