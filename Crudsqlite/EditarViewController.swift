import UIKit

class EditarViewController: UIViewController {

    @IBOutlet weak var nota: UITextField!
    @IBOutlet weak var fecha: UITextField!
    var notasEditar : Notas!
    let picker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nota.text = notasEditar.nota
        fecha.text = notasEditar.fecha
        crearDatePicker()
    }

    @IBAction func editar(_ sender: UIButton) {
        Tablanotas.shared.update(ids: notasEditar.id, nota: nota.text!, fecha: fecha.text!)
        navigationController?.popViewController(animated: true)
    }
    
    func crearDatePicker(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(enviarFecha))
        toolbar.setItems([done], animated: false)
        fecha.inputAccessoryView = toolbar
        fecha.inputView = picker
        picker.datePickerMode = .date
    }
    
    @objc func enviarFecha(){
        let formatter = DateFormatter()
        //formatter.dateStyle = .full
        formatter.dateFormat = "dd-MM-yyyy"
        let fechaFormateada = formatter.string(from: picker.date)
        fecha.text = "\(fechaFormateada)"
        self.view.endEditing(true)
    }
    
}











