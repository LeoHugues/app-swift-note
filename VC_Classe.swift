import UIKit

class VC_Classe: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var classeListe: Array<Classe> = Array<Classe>()

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
        
        return cell
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("eleve") as! UITableViewCell
        
        cell.textLabel?.text = classeListe[indexPath.section].listeEleve[indexPath.row].nom
        
        return cell
    }
    
    // MARK: - Api Rest Request
    
    internal func getClasses(){
        
        let url = NSURL(string: Constants.UrlApi + "/classe")!
        
        var request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        
        var response: NSURLResponse?
        var error: NSError?
        
        let data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
        
        let jsonResult = self.parseJSON(data!)
        
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
        
        let jsonResult = self.parseJSON(data!)
        
        var eleves = jsonResult["eleves"] as! NSArray
        
        for array in eleves {
            let dico = array as! NSDictionary
            print(dico)
            var eleve = Eleve(eleve: dico)
            classe.listeEleve.append(eleve)
        }
    }
    
    func parseJSON(inputData: NSData) -> NSDictionary{
        var error: NSError?
        var boardsDictionary = NSJSONSerialization.JSONObjectWithData(inputData, options: NSJSONReadingOptions.MutableContainers, error: &error) as! NSDictionary
        
        return boardsDictionary
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
