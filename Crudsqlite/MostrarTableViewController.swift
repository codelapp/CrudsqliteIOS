import UIKit

class MostrarTableViewController: UITableViewController {

    var notasUsuario = [Notas]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        mostrarNotas()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return notasUsuario.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let nota = notasUsuario[indexPath.row]
        cell.textLabel?.text = nota.nota
        cell.detailTextLabel?.text = nota.fecha
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "editar", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editar" {
            if let id = tableView.indexPathForSelectedRow{
                let fila = notasUsuario[id.row]
                let destino = segue.destination as! EditarViewController
                destino.notasEditar = fila
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let nota = notasUsuario[indexPath.row]
            let id = nota.id
            Tablanotas.shared.borrar(ids: id)
        }
        mostrarNotas()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    

    func mostrarNotas(){
        notasUsuario.removeAll()
        for row in (try! Database.shared.conexion?.prepare("SELECT id, nota, fecha FROM notas"))! {
            let id = row[0]! as! Int64
            let nota = row[1]! as! String
            let fecha = row[2]! as! String
            let lista = Notas(id: id, nota: nota, fecha: fecha)
            self.notasUsuario.append(lista)
        }
    }
    

}
