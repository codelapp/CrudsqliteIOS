import Foundation
import SQLite

class Tablanotas {
    
    static let shared = Tablanotas()
    
    private let tabla = Table("notas")
    
    private let id = Expression<Int64>("id")
    private let nombreNota = Expression<String>("nota")
    private let fechaNota = Expression<String>("fecha")
    
    private init(){
        do {
            if let conexion = Database.shared.conexion {
                try conexion.run(tabla.create(temporary: false, ifNotExists: true, withoutRowid: false, block: { (t) in
                    t.column(self.id, primaryKey: true)
                    t.column(self.nombreNota)
                    t.column(self.fechaNota)
                }))
                print("La tabla se creo correctamente")
            }else{
                print("la tabla no se creo")
            }
            
        } catch let error as NSError {
            print("Error al crear la tabla", error)
        }
    }
    
    // INSERTAR
    
    func insertar(nota: String, fecha:String){
        do {
            let insertar = tabla.insert(self.nombreNota <- nota, self.fechaNota <- fecha)
            try Database.shared.conexion?.run(insertar)
        } catch let error as NSError {
            print("error al guardar", error)
        }
    }
    
    // ACTUALIZAR
    
    func update(ids: Int64, nota: String, fecha: String){
        let identificador = tabla.filter(id == ids)
        try! Database.shared.conexion?.run(identificador.update(nombreNota <- nota, fechaNota <- fecha))
        print("Edito correctamente")
    }
    // BORRAR
    func borrar(ids: Int64){
        let identificador = tabla.filter(id == ids)
        try! Database.shared.conexion?.run(identificador.delete())
        print("Edito correctamente")
    }
    
    
}
















