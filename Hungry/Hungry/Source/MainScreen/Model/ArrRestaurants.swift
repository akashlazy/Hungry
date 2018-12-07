
import Foundation

class ArrRestaurants {
    
    static let sharedInstance = ArrRestaurants()
    
    var resID = ""
    var name = ""
    var currency = ""
    var thumb = ""
    var avgCost = ""
    var rating = ""
    var color = ""
    var locality = ""
    var cuisines = ""
    var photo_count = ""
    
    func getRestaurants() -> [ArrRestaurants] {
        
        var arr = [ArrRestaurants]()
        
        let database = DatabaseOperation()
        database.openDatabase(false)
        
        let sql = "select " + database.dbName + ", " + database.dbCurrency
            + ", " + database.dbThumb + ", " + database.dbAvgcCost
            + ", " + database.dbAgreeRating + ", " + database.dbRatingColor
            + ", " + database.dbLocality + ", " + database.dbCuisinesName
            + ", " + database.dbPhotoCount + ", " + database.dbRestaurantID
            + " from " + database.Restaurants_Tbl
        
        let cursor = database.selectRecords(sql)
        
        if cursor != nil {
            while cursor!.next() {
                let rest = ArrRestaurants()
                
                rest.name = cursor!.stringValue(0)
                rest.currency = cursor!.stringValue(1)
                rest.thumb = cursor!.stringValue(2)
                rest.avgCost = cursor!.stringValue(3)
                rest.rating = cursor!.stringValue(4)
                rest.color = cursor!.stringValue(5)
                rest.locality = cursor!.stringValue(6)
                rest.cuisines = cursor!.stringValue(7)
                rest.photo_count = cursor!.stringValue(8)
                rest.resID = cursor!.stringValue(9)
                
                arr.append(rest)
            }
            cursor!.close()
        }
        
        database.closeDatabase()
        
        return arr
    }
}
