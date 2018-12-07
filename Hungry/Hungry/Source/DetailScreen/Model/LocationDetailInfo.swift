

import Foundation


class LocationDetailInfo {
    
    static let sharedInstance = LocationDetailInfo()
    
    var lat = ""
    var lon = ""
    var address = ""
    
    let header = ["Cuisines", "Photos", "Address"]
    
//    func getInfo() -> LocationDetailInfo {
//
//        let obj = LocationDetailInfo()
//
//        let database = DatabaseOperation()
//        database.openDatabase(false)
//
//        let sql = "select " + database.dbAddress + " from " + database.LocationDetails_Tbl
//
//        let cursor = database.selectRecords(sql)
//
//        if cursor != nil {
//            if cursor!.next() {
//                obj.address = cursor!.stringValue(0)
//            }
//            cursor!.close()
//        }
//        database.closeDatabase()
//
//        return obj
//    }
    
   
}
