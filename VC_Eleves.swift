//
//  VC_Eleves.swift
//  demoTableView
//
//  Created by Tristan on 09/03/2015.
//  Copyright (c) 2015 Logimax. All rights reserved.
//

import UIKit

class VC_Eleves: UIViewController {
    
    @IBOutlet weak var b_nextEleve: UIButton!
    @IBOutlet weak var l_birthdayEleve: UILabel!
    @IBOutlet weak var l_fullnameEleve: UILabel!
    var DataEleve = Array<Eleve>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDisplayEleve(0)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setDisplayEleve(index: Int)
    {
        DataEleve = MesFonctions.tableEleve()
        l_fullnameEleve.text = DataEleve[index].prenom + " " + DataEleve[index].nom
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        var dateForNs = DataEleve[index].date_naissance
        var date = dateFormatter.stringFromDate(DataEleve[index].date_naissance)
        
        l_birthdayEleve.text = date
    }
    
    @IBAction func deteteEleve(sender: AnyObject) {
        
    }
    @IBAction func getNextEleve(sender: AnyObject) {
        
    }
    
    @IBAction func getBackEleve(sender: AnyObject) {
    }
}
