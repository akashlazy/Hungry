
import Foundation
import FMDB

class DBInfo {
    var pathToDatabase: String!
    var database: FMDatabase!
        
    ///////Categories Table
    let Categories_Tlb = "CategoriesTable"
    let dbID = "ID"
    let dbCategoriesID = "Categories_ID"
    let dbCategoriesName = "Categories_Name"
   
    
    func CategoriesTableCreate(_ db: FMDatabase) {
        //prepare table creations query
        let CategoriesTableCreate = "create table "
            + Categories_Tlb + " (" + dbID + " integer primary key autoincrement, "
            + dbCategoriesID + " text, " + dbCategoriesName + " text" + " ); "
        
        sqlExecute(CategoriesTableCreate)
    }
    ///////// end Users Table
    
    let Collections_Tlb = "CollectionsTable"
    let dbCollectionID = "Collection_ID"
    let dbDescription = "Description"
    let dbImage_url = "Image_url"
    let dbRes_count = "Res_count"
    let dbShare_url = "Share_url"
    let dbTitle = "Title"
    let dbUrl = "Url"
    

    func CollectionTableCreate(_ db: FMDatabase) {
//        prepare table creations query
        let CollectionTableCreate = "create table "
            + Collections_Tlb + " (" + dbID + " integer primary key autoincrement, "
            + dbCollectionID + " text, "
            + dbDescription + " text, " + dbImage_url + " text, "
            + dbRes_count + " text, " + dbShare_url + " text, "
            + dbTitle + " text, " + dbUrl
            + " text " + " ); "
        
        sqlExecute(CollectionTableCreate)
    }
    func ActivityListTableUpgrade(_ db: FMDatabase, oldVersion: Int, newVersion: Int) {
//        let ActivityListTableDelete = "DROP TABLE IF EXISTS " + ActivityMaster_Tlb
//        sqlExecute(ActivityListTableDelete)
//        ActivityListTableCreate(db)
    }
    ///////// end ActivityMaster Table
    
    
    
    let Cuisines_Tlb = "CuisinesTable"
    let dbCuisinesID = "Cuisines_ID"
    let dbCuisinesName = "Cuisines_Name"
    
    
    func CuisinesTableCreate(_ db: FMDatabase) {
        //prepare table creations query
        let CuisinesTableCreate = "create table "
            + Cuisines_Tlb + " (" + dbID + " integer primary key autoincrement, "
            + dbCuisinesID + " text, " + dbCuisinesName + " text" + " ); "
        
        sqlExecute(CuisinesTableCreate)
    }
    
    let Locations_Tbl = "LocationsTable"
    let dbCityID = "City_ID"
    let dbCityName = "City_Name"
    let dbCountryID = "Country_ID"
    let dbCountryName = "Country_Name"
    let dbEntityID = "Entity_ID"
    let dbEntityType = "Entity_Type"
    let dbLattitude = "Lattitude"
    let dbLongitude = "Longitude"
    
    func LocationTableCreate(_ db: FMDatabase) {
        //        prepare table creations query
        let LocationTableCreate = "create table "
            + Locations_Tbl + " (" + dbID + " integer primary key autoincrement, "
            + dbCityID + " text, " + dbCityName + " text, "
            + dbCountryID + " text, " + dbCountryName + " text, "
            + dbEntityID + " text, " + dbEntityType + " text, "
            + dbLattitude + " text, " + dbLongitude + " text, " + dbTitle
            + " text " + " ); "
        
        sqlExecute(LocationTableCreate)
    }
    
    let Restaurants_Tbl = "RestaurantsTable"
    let dbRestaurantID = "Restaurant_ID"
    let dbName = "RestaurantName"
    let dbCurrency = "Currency"
    let dbThumb = "Thumb"
    let dbAvgcCost = "Average_Cost_For_Two"
    let dbAgreeRating = "Aggregate_Rating"
    let dbRatingColor = "Rating_Color"
    let dbLocality = "Locality_Verbose"
    let dbPhotoCount = "Photo_Count"
    
    func RestaurantsTableCreate(_ db: FMDatabase) {
        //        prepare table creations query
        let RestaurantsTableCreate = "create table "
            + Restaurants_Tbl + " (" + dbID + " integer primary key autoincrement, "
            + dbCurrency + " text, " + dbThumb + " text, "
            + dbAvgcCost + " text, " + dbAgreeRating + " text, "
            + dbRatingColor + " text, " + dbLocality + " text, "
            + dbName + " text, " + dbCuisinesName + " text, "
            + dbRestaurantID + " text, "
            + dbPhotoCount + " text " + " ); "
        
        sqlExecute(RestaurantsTableCreate)
    }
    
    
    let LocationDetails_Tbl = "LocationDetailsTable"
    let dbAddress = "Address"
    
    func LocationDetailsTableCreate(_ db: FMDatabase) {
        //prepare table creations query
        let LocationDetailsTableCreate = "create table "
            + LocationDetails_Tbl + " (" + dbID + " integer primary key autoincrement, "
            + dbRestaurantID + " text, " + dbAddress + " text" + " ); "
        
        sqlExecute(LocationDetailsTableCreate)
    }
    

    func sqlExecute(_ sqlString: String) {
        if database!.executeStatements(sqlString) {
            
        } else {
            print("Databse Error===\(database!.lastErrorMessage()) in \n \(sqlString)")
        }
    }
    
    func selectRecords(_ queryString: String) -> FMResultSet? {
        do {
            return try database!.executeQuery(queryString, values: nil)
        } catch {
            print("Databse Error===\(database.lastErrorMessage())")
            return nil
        }
    }
    
    
    
    func insertExecuteBind(_ tableName: String, parameter: NSMutableDictionary, value: NSMutableDictionary) {
        
        var query = "INSERT INTO \(tableName)"
        
        var paraStr = ""
        var valueStr = ""
        var arr = [String]()
        
        for i in 0 ..< parameter.count {
            paraStr = paraStr + "\(paraStr.isEmpty ? "\(parameter.value(forKey: "\(i+1)") as! String)":",\(parameter.value(forKey: "\(i+1)") as! String)")"
            valueStr  = valueStr + "\(valueStr.isEmpty ? "?":",?")"
            arr.append(value.value(forKey: "\(i+1)") as! String)
        }
        query = query + "(" + paraStr + ") VALUES (" + valueStr + ");"
        
        if database.executeUpdate(query, withArgumentsIn: arr) {
            return
        } else {
            print("Databse Insert Error===\(database.lastErrorMessage())")
        }
    }
    
    func insertMultipleExecuteBind(_ tableName: String, parameter: NSMutableDictionary, value: NSMutableArray) {
        
        var query = "INSERT INTO \(tableName)"
        
        var paraStr = ""
        var valueStr = ""
        
        
        for i in 0 ..< parameter.count {
            paraStr = paraStr + "\(paraStr.isEmpty ? "\(parameter.value(forKey: "\(i+1)") as! String)":",\(parameter.value(forKey: "\(i+1)") as! String)")"
            valueStr  = valueStr + "\(valueStr.isEmpty ? "?":",?")"
        }
        query = query + "(" + paraStr + ") VALUES (" + valueStr + ");"
        
        database.beginTransaction()
        for i in 0 ..< value.count {
            let dict = value.object(at: i) as! NSMutableDictionary
            var arr = [String]()
            for j in 0 ..< dict.count {
                arr.append(dict.value(forKey: "\(j+1)") as! String)
            }
            
            if database.executeUpdate(query, withArgumentsIn: arr) {
                continue
            } else {
                print("Databse Multiple Insert Error===\(database.lastErrorMessage())")
            }
        }
        database.commit()
    }
    
    func updateExecuteBind(_ tableName: String, parameter: NSMutableDictionary, value: NSMutableDictionary, condition: String) {
        
        var query = "UPDATE \(tableName) SET "
        var arr = [String]()
        
        for i in 0 ..< parameter.count {
            query = query + "\(parameter.value(forKey: "\(i+1)") as! String) = ?" + (((i+1) != parameter.count) ? "," : "")
            arr.append(value.value(forKey: "\(i+1)") as! String)
        }
        if !condition.isEmpty {
            query = query + " WHERE " + condition
        }
        
        if database.executeUpdate(query, withArgumentsIn: arr) {
            return
        } else {
            print("Databse Error===\(database!.lastErrorMessage()) in \n \(query)")
        }
    }

    func deleteRecord(_ tableName: String, condition: String) {
        var query = "";
        if condition.isEmpty {
            query = "delete from " + tableName;
        } else {
            query = "delete from " + tableName + " WHERE " + condition;
        }
        
        let a = [Any]()
        
        if database!.executeUpdate(query, withArgumentsIn: a) {
            return
        } else {
            print("Databse Error===\(database!.lastErrorMessage())")
        }
    }
}

extension FMResultSet {
    func stringValue(_ Index: Int32) -> String {
        guard let value = self.string(forColumnIndex: Index) else {
            return ""
        }
        return value
    }
    
    func doubleValue(_ Index: Int32) -> Double {
        return self.double(forColumnIndex: Index)
    }
}
