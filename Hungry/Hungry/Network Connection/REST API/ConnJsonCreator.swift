
import Foundation
import UIKit
import SwiftyJSON

class ConnJsonCreator {
    
    var mySharedObj = MySharedPreference()
    
    // create Json values to send it to server
    func putDefaultJSON()  -> JSON {
    
        let mJson = NSMutableDictionary()

        return JSON(mJson)
    }
    
    // send Parameter Lat, Lon as well as city name
    func putCollecionsJSON()  -> JSON {
        
        let appPrefs = MySharedPreference()
        
        let mJson = NSMutableDictionary()
        
        if appPrefs.getCityName() != "" {
            mJson.setValue(appPrefs.getCityName(), forKey: "query")
        }
        
        mJson.setValue(appPrefs.getTempLatitude(), forKey: "lat")
        mJson.setValue(appPrefs.getTempLongitude(), forKey: "lon")
        
        return JSON(mJson)
    }
    
    // send Parameter restaurantID
    func putRestaurantJSON()  -> JSON {
        
        let appPrefs = MySharedPreference()
        
        let mJson = NSMutableDictionary()
    
        mJson.setValue(appPrefs.getRestaurantID(), forKey: "res_id")
        
        return JSON(mJson)
    }
}

extension ConnJsonCreator {
    
    // Store Server data in shared preferences depending upon the type of current request
    func storeCategories(_ json: JSON)  {
        let dict = json.dictionaryValue
        
        let appPrefs = MySharedPreference()
        appPrefs.setHttpResponseCode(0)

        guard let list = dict["categories"] else {
            return
        }
      
        let database = DatabaseOperation()
        database.openDatabase(true)
        
        for index in 0 ..< list.count {
            let categories = list[index].dictionaryValue
            
            guard let category = categories["categories"] else {
                continue
            }
            
            let value =  category.dictionaryValue
            
            guard let name = value["name"] else {
                continue
            }
            guard let id = value["id"] else {
                continue
            }
            database.InsertCategoriesList("\(id.int!)", name: name.string!)
        }
        
        database.closeDatabase()
    }
    
    
    func storeCollecions(_ json: JSON)  {
        let dict = json.dictionaryValue
        
        let appPrefs = MySharedPreference()
        appPrefs.setHttpResponseCode(0)
        
        
        guard let list = dict["collections"] else {
            return
        }
        
        let database = DatabaseOperation()
        database.openDatabase(true)
        
        for index in 0 ..< list.count {
            let colls = list[index].dictionaryValue
            
            guard let coll = colls["collection"] else {
                continue
            }
            
            let value =  coll.dictionaryValue
            
            guard let id = value["collection_id"] else {
                continue
            }
            guard let description = value["description"] else {
                continue
            }
            guard let image_url = value["image_url"] else {
                continue
            }
            guard let res_count = value["res_count"] else {
                continue
            }
            guard let share_url = value["share_url"] else {
                continue
            }
            guard let title = value["title"] else {
                continue
            }
            guard let url = value["url"] else {
                continue
            }
            
            database.InsertCollectionList("\(id.int32!)", description: description.string!, title: title.string!, image: image_url.string!, count: "\(res_count.int!)", shareUrl: share_url.string!, url: url.string!)
        }
        
        database.closeDatabase()
    }
    
    func storeCuisines(_ json: JSON)  {
        let dict = json.dictionaryValue
        
        let appPrefs = MySharedPreference()
        appPrefs.setHttpResponseCode(0)
        
        guard let list = dict["cuisines"] else {
            return
        }
        
        let database = DatabaseOperation()
        database.openDatabase(true)
        
        for index in 0 ..< list.count {
            let cuisines = list[index].dictionaryValue
            
            guard let cuisine = cuisines["cuisine"] else {
                continue
            }
            
            let value =  cuisine.dictionaryValue
            
            guard let name = value["cuisine_name"] else {
                continue
            }
            guard let id = value["cuisine_id"] else {
                continue
            }
            database.InsertCuisinesList("\(id.int!)", name: name.string!)
        }
        
        database.closeDatabase()
    }
    
    func storeCityLocation(_ json: JSON)  {
        let dict = json.dictionaryValue
        
        let appPrefs = MySharedPreference()
        appPrefs.setHttpResponseCode(0)
        
        guard let list = dict["location_suggestions"] else {
            return
        }
        
        let database = DatabaseOperation()
        database.openDatabase(true)
        
        for index in 0 ..< list.count {
            let value = list[index].dictionaryValue
            
            guard let entity_type = value["entity_type"] else {
                continue
            }
            guard let entity_id = value["entity_id"] else {
                continue
            }
            guard let title = value["title"] else {
                continue
            }
            guard let latitude = value["latitude"] else {
                continue
            }
            guard let longitude = value["longitude"] else {
                continue
            }
            guard let city_id = value["city_id"] else {
                continue
            }
            guard let city_name = value["city_name"] else {
                continue
            }
            guard let country_id = value["country_id"] else {
                continue
            }
            guard let country_name = value["country_name"] else {
                continue
            }
            
            
            database.InsertLocationList("\(entity_id.int!)", type: entity_type.string!, title: title.string!, lat: latitude.string!, lon: longitude.string!, cityID: "\(city_id.int!)", cityName: city_name.string!, countryID: "\(country_id.int!)", countryName: country_name.string!)
        }
        
        database.closeDatabase()
    }
    
    func storeLocationGeocode(_ json: JSON)  {
        let dict = json.dictionaryValue
        
        let appPrefs = MySharedPreference()
        appPrefs.setHttpResponseCode(0)
        
        guard let nearby_restaurants = dict["nearby_restaurants"] else {
            return
        }
        
        let database = DatabaseOperation()
        database.openDatabase(true)
        
        for index in 0 ..< nearby_restaurants.count {
            let value = nearby_restaurants[index].dictionaryValue
            
            guard let restaurant = value["restaurant"] else {
                continue
            }
            
            print(restaurant)
            let detail = restaurant.dictionaryValue
            
            guard let R = detail["R"] else {
                continue
            }
            let resDict = R.dictionaryValue
            guard let res_id = resDict["res_id"] else {
                continue
            }
            
            guard let name = detail["name"] else {
                continue
            }
            guard let currency = detail["currency"] else {
                continue
            }
            guard let thumb = detail["thumb"] else {
                continue
            }
            guard let average_cost_for_two = detail["average_cost_for_two"] else {
                continue
            }
            guard let cuisines = detail["cuisines"] else {
                continue
            }
//            guard let photo_count = value["photo_count"] else {
//                continue
//            }
            

            /////
            guard let user_rating = detail["user_rating"] else {
                continue
            }
            let rating = user_rating.dictionaryValue
            guard let aggregate_rating = rating["aggregate_rating"] else {
                continue
            }
            guard let rating_color = rating["rating_color"] else {
                continue
            }
            guard let votes = rating["votes"] else {
                continue
            }
            
            ////
            guard let location = detail["location"] else {
                continue
            }
            let loc = location.dictionaryValue
            guard let locality_verbose = loc["locality_verbose"] else {
                continue
            }
            
            database.InsertRestaurentList("\(res_id.int64!)" ,name: name.string!, currency: currency.string!, thumb: thumb.string!, avgCost: "\(average_cost_for_two.int!)", rating: "\(aggregate_rating.numberValue)", color: rating_color.string!, locality: locality_verbose.string!, cuisinesName: cuisines.string!, photocount: "\(0)")
   
        }
        
        database.closeDatabase()
    }
    
    func storeDetailLocation(_ json: JSON, completionClosure: @escaping(_ dict: JSON) -> () )  {
        let dict = json.dictionaryValue
        
        let appPrefs = MySharedPreference()
        appPrefs.setHttpResponseCode(0)
        
        guard let location = dict["location"] else {
            return
        }
        
        let loc = location.dictionaryValue
        
        guard let latitude = loc["latitude"] else {
            return
        }
        guard let longitude = loc["longitude"] else {
            return
        }
        guard let address = loc["address"] else {
            return
        }
        
        appPrefs.setLatitude(latitude.double!)
        appPrefs.setLongitude(longitude.double!)
        
        
        completionClosure(json)
    }
}
