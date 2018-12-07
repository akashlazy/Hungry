import Foundation

public struct Constant {
    
    struct Database {
        static let DATABASE_NAME_Tracker = "Hungry.sqlite"
    }
  
    struct API {
        static let zomatokey = "0ce009b35be67155c0a0fb86f2a18eba"
        
    }
    
    struct URL {
        static let serverAddress = "https://developers.zomato.com/api/v2.1/"
    }
    
    struct MethodCommon {
        static let methodCategories = "categories"
        static let methodCities = "cities"
        static let methodCollections = "collections"
        static let methodCuisines = "cuisines"
        static let methodEstablishment = "establishment"
        static let methodGeocode = "geocode"
    }
    
    struct Location {
        static let methodLocationDetails = "location_details"
        static let methodLocations = "locations"
    }
    
    struct Restaurant {
        static let methodDailyMenu = "dailymenu"
        static let methodRestaurant = "restaurant"
        static let methodReviews = "reviews"
        static let methodSearch = "search"
    }
}
