import UIKit

class Eleve
    
{
    //MARK: - Attributs
    
    var id: Int
    var nom: String
    var prenom: String
    var email: String
    var photo: UIImage
    var date_naissance: NSDate
    var classe: Classe
    var notes: Array<Note>
    
    //MARK: - Constructeurs
    init()
    {
        self.id = Int()
        self.nom = String()
        self.prenom = String()
        self.email = String()
        self.photo = UIImage()
        self.date_naissance = NSDate()
        self.classe = Classe()
        self.notes = Array<Note>()
    }
    
    init(Id: Int, Nom: String, Prenom: String, Date_naissance: NSDate)
    {
        self.id = Id
        self.nom = Nom
        self.prenom = Prenom
        self.email = "whatever"
        self.photo = UIImage()
        self.date_naissance = Date_naissance
        self.classe = Classe()
        self.notes = Array<Note>()
    }
    
    
    init(eleve: NSDictionary, classe: Classe){
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        // convert string into date
        let date:NSDate? = dateFormatter.dateFromString(eleve["dateOfBirth"] as! String)
        
        var id = eleve["id"] as! String
        
        self.id = id.toInt()!
        self.nom = eleve["lastName"] as! String
        self.prenom = eleve["firstName"] as! String
        self.email = eleve["email"] as! String
        self.photo = UIImage()
        self.date_naissance = date!
        self.classe = classe
        self.notes = Array<Note>()
    }
    
    internal func update() {
        
        // Prepare data
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        
            // convert string into date
        let date: String = dateFormatter.stringFromDate(self.date_naissance as NSDate)
        
        var bodyData = Dictionary<String, AnyObject>()
        bodyData = [
            "idClasse": self.classe.id,
            "firstName": self.prenom,
            "lastName": self.nom,
            "email": self.email,
            "dateOfBirth": date
        ]
        
        var body = NSJSONSerialization.dataWithJSONObject(bodyData, options: nil, error: nil)
        
        // Prepare request
        let url = NSURL(string: Constants.UrlApi + "/eleve/\(self.id)")!
        
        var request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "PUT"
        request.HTTPBody = body
        
        var response: NSURLResponse?
        var error: NSError?
        
        let data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
    }
    
    internal func delete() {
        let url = NSURL(string: Constants.UrlApi + "/eleve/\(self.id)")!
        
        var request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "DELETE"
        
        var response: NSURLResponse?
        var error: NSError?
        
        let data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
    }
    
    internal func APIgetNotes() {
        
        let url = NSURL(string: Constants.UrlApi + "/note")!
        
        var bodyFiltre = Dictionary<String, Dictionary<String, String>>()
        bodyFiltre = [
            "filtre" : [
                "idEleve": String(self.id)
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
        
        var notes = jsonResult["notes"] as! NSArray
        
        for array in notes {
            let dico = array as! NSDictionary

            var note = Note(id: dico["id"] as! String, NbPoint: dico["nbPoints"] as! String, dateString: dico["date"] as! String, Description: dico["apreciation"] as! String, Coefficient: dico["coefficient"] as! String, idMatiere: dico["matiere_id"] as! String)
            self.notes.append(note)
        }
        
    }
    
    internal func getNoteByMatiere() -> Array<Matiere> {
        
        var listeMatiere = Array<Matiere>()
        
        for note: Note in notes {
            var matiereExiste = false
            for matiere: Matiere in listeMatiere {
                if (note.matiere.id == matiere.id) {
                    matiere.listeNote.append(note)
                    matiereExiste = true
                }
            }
            if(matiereExiste == false) {
                note.matiere.listeNote.append(note)
                listeMatiere.append(note.matiere)
            }
        }
        return listeMatiere
    }
}
