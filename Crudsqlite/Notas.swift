import Foundation

class Notas{
    var id : Int64
    var nota: String?
    var fecha: String?
    
    init(id:Int64, nota:String?, fecha:String?) {
        self.id = id
        self.nota = nota
        self.fecha = fecha
    }
    
}
