import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var l_moyenne: UILabel!
    @IBOutlet weak var tableViewNote: UITableView!
    
    var eleve: Eleve = Eleve()
    var DataNote: Array<Matiere> = []
    
    // MARK: - override Function
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eleve.APIgetNotes()
        DataNote = eleve.getNoteByMatiere()
        
        self.navigationItem.title = "Notes de " + eleve.prenom
    }
    
    
    override func viewWillAppear(animated: Bool) {
        tableViewNote.reloadData()
        l_moyenne.text = String(format: "%.2f", MesFonctions.MoyenneGenerale(DataNote))
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        if let VC: AccueilVC = self.parentViewController?.childViewControllerForStatusBarHidden() as? AccueilVC
        {
          //  VC.DataNote = DataNote
        }
    }
    
    // MARK: - TableView Function

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return DataNote.count
    }
    
    
    func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int
    {
      return DataNote[section].listeNote.count
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cell: TVC_CustomSection = tableView.dequeueReusableCellWithIdentifier("cellSection") as! TVC_CustomSection
        
        cell.l_title.text = DataNote[section].name
        cell.nbRow.text = String(DataNote[section].listeNote.count)
        cell.b_add.tag = section
        cell.section.tag = section
        
        return cell
        
    }
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellType1") as! UITableViewCell
        
        cell.textLabel!.text = String(format:"%.2f", DataNote[indexPath.section].listeNote[indexPath.row].nbPoint)
        cell.detailTextLabel!.text = String(DataNote[indexPath.section].listeNote[indexPath.row].coefficient)
        
        return cell
    }
    
    @IBAction func sectionTapped(sender: UIButton) {
        
    }

    // MARK: - Navigation Function

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
    
    // MARK: APIRequest
    func getMatieres() {
        let url = NSURL(string: Constants.UrlApi + "/matiere")!
        
        var request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        
        var response: NSURLResponse?
        var error: NSError?
        
        let data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
        print(data?.length)
        
        if (data?.length != 0) {
            let jsonResult = MesFonctions.parseJSON(data!)
            
            var matieres = jsonResult["matieres"] as! NSArray
            
            for array in matieres {
                let dico = array as! NSDictionary
                var matiere = Matiere(Name: dico[""] as! String, Coefficient: dico[""] as! Int, Description: dico[""] as! String)
                matiere.APIGetNotesByEleveID(eleve.id)
                self.classeListe.append(classe)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
