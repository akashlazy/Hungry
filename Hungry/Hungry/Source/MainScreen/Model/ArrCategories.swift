

import Foundation

class ArrCategories {
    
    static let sharedInstance = ArrCategories()
    
    var id = ""
    var Name = ""
    
    func getCategories() -> [ArrCategories] {
        
        var arr = [ArrCategories]()
        
        let database = DatabaseOperation()
        database.openDatabase(false)
        
        let sql = "select * from " + database.Categories_Tlb
        
        let cursor = database.selectRecords(sql)
        
        if cursor != nil {
            while cursor!.next() {
                let category = ArrCategories()
                
                category.id = cursor!.stringValue(0)
                category.Name = cursor!.stringValue(1)
                
                arr.append(category)
            }
            cursor!.close()
        }
        
        database.closeDatabase()
        
        return arr
    }
}



