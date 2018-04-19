
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var nota: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    @IBAction func guardar(_ sender: UIButton) {
        let formatter = DateFormatter()
        //formatter.dateStyle = .full
        formatter.dateFormat = "dd-MM-yyyy"
        let fecha = formatter.string(from: datePicker.date)
        Tablanotas.shared.insertar(nota: nota.text!, fecha: fecha)
    }
    
    
    @IBAction func mostrar(_ sender: UIButton) {
        for row in (try! Database.shared.conexion?.prepare("SELECT id, nota, fecha FROM notas"))! {
            print("id: \(row[0]!), nota: \(row[1]!), fecha: \(row[2]!) ")
        }
    }
    

}

