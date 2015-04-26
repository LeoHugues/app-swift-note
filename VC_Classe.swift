import UIKit

class VC_Classe: UIViewController, UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate {
    
    var classeListe: Array<Classe> = Array<Classe>()
    var loader = UIAlertView()

    @IBOutlet weak var tv_classe: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Mes Classe"
        
        getClasses()
    }
    
    //MARK: Table view implementation
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return classeListe.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classeListe[section].listeEleve.count
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cell: TVC_CustomSection = tableView.dequeueReusableCellWithIdentifier("cellSection") as! TVC_CustomSection
        
        cell.l_title.text = classeListe[section].nom
        cell.nbRow.text = String(classeListe[section].listeEleve.count)
        cell.section.tag = section
        
        return cell
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("eleve") as! UITableViewCell
        
        cell.textLabel?.text = classeListe[indexPath.section].listeEleve[indexPath.row].nom
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(indexPath)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
                getEleve(classe)
                self.classeListe.append(classe)
            }
        }
    
        internal func getEleve(classe: Classe){
    
            let url = NSURL(string: Constants.UrlApi + "/eleve")!
    
            var bodyFiltre = Dictionary<String, Dictionary<String, String>>()
            bodyFiltre = [
                "filtre" : [
                    "classe_id": String(classe.id)
                ]
            ]
    
            var body = NSJSONSerialization.dataWithJSONObject(bodyFiltre, options: nil, error: nil)
    
            var request = NSMutableURLRequest(URL: url)
            request.HTTPMethod = "POST"
            request.HTTPBody = body
    
            var response: NSURLResponse?
            var error: NSError?
    
            let data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
    
            let jsonResult = MesFonctions.parseJSON(data!)
    
            var eleves = jsonResult["eleves"] as! NSArray
    
            for array in eleves {
                let dico = array as! NSDictionary
                var eleve = Eleve(eleve: dico, classe: classe)
                classe.listeEleve.append(eleve)
            }
        }
    
        internal func getLoader(){
    
            loader = UIAlertView(title: "Loading", message: "Please wait...", delegate: nil, cancelButtonTitle: nil);
    
            var loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(50, 10, 37, 37)) as UIActivityIndicatorView
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            loadingIndicator.startAnimating();
    
            loader.setValue(loadingIndicator, forKey: "accessoryView")
            loadingIndicator.startAnimating()
    
            loader.show()
        }

    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        
        if let VC = segue!.destinationViewController as? VC_ClasseDetail {
            if let bt_section = sender as? UIButton {
                VC.indexOfClasse = bt_section.tag
                VC.classeListe = self.classeListe
            }
        }
        if let VC = segue!.destinationViewController as? VC_Eleves {
            if let indexPath = tv_classe.indexPathForSelectedRow() as NSIndexPath? {
                VC.classe = classeListe[indexPath.section]
                VC.indexOfEleve = indexPath.row
            }
        }
    }

}
