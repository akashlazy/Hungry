
import Foundation
import SQLite3
import FMDB

class DatabaseOperation: DBInfo {
    
    static let sharedInstance = DatabaseOperation()
    
    override init() {
        super.init()
        
        let documentsDirectory = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString) as String
        pathToDatabase = documentsDirectory.appending("/\(Constant.Database.DATABASE_NAME_Tracker)")
    }
    
    func openDatabase(_ isReadWrite: Bool) {
        // Call for create database, if not available
        if database == nil {
            database = FMDatabase(path: pathToDatabase)
        }
        
        if database != nil {
            if isReadWrite {
                if database.open() {
                    let appPref = MySharedPreference()
                    if !appPref.getISDBOperationCreated() {
                        self.createDatabase()
                    }
                }
            } else {
                if !database.open(withFlags: 2) {
                    return
                }
            }
        }
    }
    
    func closeDatabase() {
        database.close()
    }
    
    func createDatabase() {
        
        CategoriesTableCreate(database)
        CollectionTableCreate(database)
        CuisinesTableCreate(database)
        RestaurantsTableCreate(database)
        LocationTableCreate(database)
        LocationDetailsTableCreate(database)
        
        let appPref = MySharedPreference()
        appPref.setISDBOperationCreated(true)
    }
    
    func dropPreviousTable() {
//        UsersListTableUpgrade(database, oldVersion: 0, newVersion: 0)
//        ActivityListTableUpgrade(database, oldVersion: 0, newVersion: 0)
//        ActivityParticipentListTableUpgrade(database, oldVersion: 0, newVersion: 0)
//        ActivityTaskListTableUpgrade(database, oldVersion: 0, newVersion: 0)
//        ActivityLogListTableUpgrade(database, oldVersion: 0, newVersion: 0)
    }
    
    /////////////////UsersList
    func InsertCategoriesList(_ ID: String, name: String) {
        
        let parameter = NSMutableDictionary()
        parameter.setValue(dbCategoriesID, forKey: "1")
        parameter.setValue(dbCategoriesName, forKey: "2")
        
        let values = NSMutableDictionary()
        values.setValue(ID, forKey: "1")
        values.setValue(name, forKey: "2")
        
        insertExecuteBind(Categories_Tlb, parameter: parameter, value: values)
    }
    
    func InsertCuisinesList(_ ID: String, name: String) {
        
        let parameter = NSMutableDictionary()
        parameter.setValue(dbCuisinesID, forKey: "1")
        parameter.setValue(dbCuisinesName, forKey: "2")
        
        let values = NSMutableDictionary()
        values.setValue(ID, forKey: "1")
        values.setValue(name, forKey: "2")
        
        insertExecuteBind(Cuisines_Tlb, parameter: parameter, value: values)
    }
    
    
    func InsertLocationList(_ id: String, type: String, title: String, lat: String, lon: String, cityID: String, cityName: String, countryID: String, countryName: String) {
        
        let parameter = NSMutableDictionary()
        parameter.setValue(dbEntityID, forKey: "1")
        parameter.setValue(dbEntityType, forKey: "2")
        parameter.setValue(dbTitle, forKey: "3")
        parameter.setValue(dbLattitude, forKey: "4")
        parameter.setValue(dbLongitude, forKey: "5")
        parameter.setValue(dbCityID, forKey: "6")
        parameter.setValue(dbCityName, forKey: "7")
        parameter.setValue(dbCountryID, forKey: "8")
        parameter.setValue(dbCountryName, forKey: "9")
        
        let values = NSMutableDictionary()
        values.setValue(id, forKey: "1")
        values.setValue(type, forKey: "2")
        values.setValue(title, forKey: "3")
        values.setValue(lat, forKey: "4")
        values.setValue(lon, forKey: "5")
        values.setValue(cityID, forKey: "6")
        values.setValue(cityName, forKey: "7")
        values.setValue(countryID, forKey: "8")
        values.setValue(countryName, forKey: "9")
        
        insertExecuteBind(Locations_Tbl, parameter: parameter, value: values)
    }
 
    func InsertRestaurentList(_ resID: String, name: String, currency: String, thumb: String, avgCost: String, rating: String, color: String, locality: String, cuisinesName: String, photocount: String) {
        
        let parameter = NSMutableDictionary()
        parameter.setValue(dbCurrency, forKey: "1")
        parameter.setValue(dbThumb, forKey: "2")
        parameter.setValue(dbAvgcCost, forKey: "3")
        parameter.setValue(dbAgreeRating, forKey: "4")
        parameter.setValue(dbRatingColor, forKey: "5")
        parameter.setValue(dbLocality, forKey: "6")
        parameter.setValue(dbCuisinesName, forKey: "7")
        parameter.setValue(dbName, forKey: "8")
        parameter.setValue(dbPhotoCount, forKey: "9")
        parameter.setValue(dbRestaurantID, forKey: "10")
        
        let values = NSMutableDictionary()
        values.setValue(currency, forKey: "1")
        values.setValue(thumb, forKey: "2")
        values.setValue(avgCost, forKey: "3")
        values.setValue(rating, forKey: "4")
        values.setValue(color, forKey: "5")
        values.setValue(locality, forKey: "6")
        values.setValue(cuisinesName, forKey: "7")
        values.setValue(name, forKey: "8")
        values.setValue(photocount, forKey: "9")
        values.setValue(resID, forKey: "10")
        
        
        insertExecuteBind(Restaurants_Tbl, parameter: parameter, value: values)
    }
    
    func InsertLocationDetailList(_ resID: String, address: String) {
        
        let parameter = NSMutableDictionary()
        parameter.setValue(dbRestaurantID, forKey: "1")
        parameter.setValue(dbAddress, forKey: "2")
        
        let values = NSMutableDictionary()
        values.setValue(resID, forKey: "1")
        values.setValue(address, forKey: "2")
        
        insertExecuteBind(LocationDetails_Tbl, parameter: parameter, value: values)
    }
    
    ///////////Collection
    func InsertCollectionList(_ id: String, description: String, title: String, image: String, count: String, shareUrl: String, url: String) {
        
        let parameter = NSMutableDictionary()
        parameter.setValue(dbDescription, forKey: "1")
        parameter.setValue(dbTitle, forKey: "2")
        parameter.setValue(dbImage_url, forKey: "3")
        parameter.setValue(dbRes_count, forKey: "4")
        parameter.setValue(dbShare_url, forKey: "5")
        parameter.setValue(dbUrl, forKey: "6")
        parameter.setValue(dbCollectionID, forKey: "7")

        let values = NSMutableDictionary()
        values.setValue(description, forKey: "1")
        values.setValue(title, forKey: "2")
        values.setValue(image, forKey: "3")
        values.setValue(count, forKey: "4")
        values.setValue(shareUrl, forKey: "5")
        values.setValue(url, forKey: "6")
        values.setValue(id, forKey: "7")
        
        insertExecuteBind(Collections_Tlb, parameter: parameter, value: values)
    }}
