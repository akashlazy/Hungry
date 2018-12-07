
import Foundation


class ArrCuisines {
    
    static let sharedInstance = ArrCuisines()
    
    var id = ""
    var Name = ""
    
    
    func getCuisiness() -> [ArrCuisines] {
        
        var arr = [ArrCuisines]()
        
        let database = DatabaseOperation()
        database.openDatabase(false)
        
        let sql = "select " + database.dbCuisinesID
            + ", " + database.dbCuisinesName + " from " + database.Categories_Tlb
        
        let cursor = database.selectRecords(sql)
        
        if cursor != nil {
            while cursor!.next() {
                let cuisines = ArrCuisines()
                
                cuisines.id = cursor!.stringValue(0)
                cuisines.Name = cursor!.stringValue(1)
                
                arr.append(cuisines)
            }
            cursor!.close()
        }
        
        database.closeDatabase()
        
        return arr
    }
}


