//
//  ViewController.swift
//  demoTableView
//
//  Created by Maxime Britto on 16/10/2014.
//  Copyright (c) 2014 Logimax. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var l_moyenne: UILabel!
    @IBOutlet weak var tableViewNote: UITableView!
    var DataNote: Array<Matiere> = []
    var bl_retract = false
    var liste_retract = Array<Bool>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for(var i = 0; i < DataNote.count; i++)
        {
            liste_retract.append(false)
        }
        
         self.navigationItem.title = "Mes Notes"
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        tableViewNote.reloadData()
        l_moyenne.text = String(format: "%.2f", MesFonctions.MoyenneGenerale(DataNote))
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        if let VC: AccueilVC = self.parentViewController?.childViewControllerForStatusBarHidden() as? AccueilVC
        {
            VC.DataNote = DataNote
        }
    }
    
    func tableView(tableView: UITableView!, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int
    {
        return DataNote.count
    }
    
    
    func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int
    {
        if(bl_retract == true)
        {
            return 0
        }
        else
        {
            var nbRow = Int()
            var i = 0
          
            
                    if(liste_retract[i] == false)
                    {
                       nbRow = DataNote[section].listeNote.count
                    }
                    i++
            
            
            
            
            return nbRow
        }
    }
    
    func tableView(tableView: UITableView!, viewForHeaderInSection section: Int) -> UIView! {
        
        let cell: TVC_SectionMatiereTableViewCell = tableView.dequeueReusableCellWithIdentifier("cellSection") as TVC_SectionMatiereTableViewCell
        
        liste_retract[section] = cell.bl_retract
        
        cell.l_title.text = DataNote[section].name
        cell.nbRow.text = String(DataNote[section].listeNote.count)
        cell.b_add.tag = section
        cell.section.tag = section
        
        return cell
        
    }
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellType1") as UITableViewCell
    
        
       // cell.accessoryType = UITableViewCellAccessoryType.None
        
        if(bl_retract == true)
        {
            
        }
        else
        {
            
        }
        
        cell.textLabel!.text = String(format:"%.2f", DataNote[indexPath.section].listeNote[indexPath.row].nbPoint)
        cell.detailTextLabel!.text = String(DataNote[indexPath.section].listeNote[indexPath.row].coefficient)
        
        return cell
    }
    
    @IBAction func sectionTapped(sender: UIButton) {
        
        if(liste_retract[sender.tag] == false)
        {
            liste_retract[sender.tag] = true
        }
        else
        {
            liste_retract[sender.tag] = false
        }
        
        tableViewNote.reloadData()
        
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        
        if let VC: VC_Note = segue!.destinationViewController as? VC_Note
        {
           if let indexPath = tableViewNote.indexPathForSelectedRow() as NSIndexPath?
           {
                VC.listeNote = DataNote[indexPath.section].listeNote
                VC.id = DataNote[indexPath.section].listeNote[indexPath.row].id
                VC.nomMatiere = DataNote[indexPath.section].name
                VC.indexNote = indexPath.row
                VC.indexMatiere = indexPath.section
           }
            
           VC.DataNote = DataNote

        }
        
        if let VC: VC_Matiere = segue!.destinationViewController as? VC_Matiere
        {
            
            VC.DataNote = DataNote
            if let button = sender as? UIButton
            {
                VC.matiere = DataNote[button.tag].name
            }
            
        }
        
        if let VC: VC_AjoutMatiere = segue!.destinationViewController as? VC_AjoutMatiere
        {
            VC.DataNote = DataNote
        }
        
    }
    
    @IBAction func retract(sender: AnyObject) {
        
        
        if(bl_retract == true)
        {
            tableViewNote.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
            bl_retract = false
        }
        else
        {
            bl_retract = true
            tableViewNote.separatorStyle = UITableViewCellSeparatorStyle.None
        }

        
        tableViewNote.reloadData()
        
    }
    
    func setDataNote(data: Array<Matiere>)
    {
        DataNote = data
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
